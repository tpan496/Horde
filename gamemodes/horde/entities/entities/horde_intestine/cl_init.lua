
include('shared.lua')

//local matBeam		 		= Material( "egon_middlebeam" )
local matBeam		 		= Material( "models/weapons/intestine/intestine" )
//local matLight 				= Material( "sprites/gmdm_pickups/light" )
//local matRefraction			= Material( "egon_ringbeam" )
//local matRefractRing		= Material( "refract_ring" )
//local matHook				= Material( "sprites/gmdm_pickups/light" )
//local hookTex = Texture:Download("sprites/yellowglow1")
//matHook:SetMaterialTexture( hookTex )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()		

	self.Size = 0
	self.MainStart = self.Entity:GetPos()
	self.MainEnd = self:GetEndPos()
	self.dAng = (self.MainEnd - self.MainStart):Angle()
	self.speed = 10000
	self.startTime = CurTime()
	self.endTime = CurTime() + self.speed
	self.dtt = -1
	
end

function ENT:Think()

	self.Entity:SetRenderBoundsWS( self:GetEndPos(), self.Entity:GetPos(), Vector()*8 )
	
	self.Size = math.Approach( self.Size, 1, 10*FrameTime() )
end


function ENT:DrawMainBeam( StartPos, EndPos, dt, dist )

	local TexOffset = 0//CurTime() * -2.0
	
	local ca = Color(255,255,255,255)
	//local dist = EndPos:Distance(StartPos)
	//self.endTime - self.startTime)
	//self.endTime - 
	
	// I found the console spam! WTF was this for?
	//Msg(dt .. "\n")
	
	EndPos = StartPos + (self.dAng * ((1 - dt)*dist))
	//StartPos = StartPos + (self.dAng * (((1 - dt)*dist)-3))
	
	// Cool Beam
	render.SetMaterial( matBeam )
	render.DrawBeam( EndPos, StartPos, 
	//32
					2, 
					TexOffset*-0.4, TexOffset*-0.4 + StartPos:Distance(EndPos) / 256, 
					ca )


end

function ENT:Draw()

	local Owner = self.Entity:GetOwner()
	if (!Owner || Owner == NULL) then return end

	local StartPos 		= self.Entity:GetPos()
	local EndPos 		= self:GetEndPos()
	local ViewModel 	= Owner == LocalPlayer()

	if (EndPos == Vector(0,0,0)) then return end
	
	// If it's the local player we start at the viewmodel
	StartPos = Owner:GetPos() + Owner:OBBCenter()

	
	// offset the texture coords so it looks like it's scrolling
	local TexOffset = CurTime() * -2
	
	// Make the texture coords relative to distance so they're always a nice size
	local Distance = EndPos:Distance( StartPos ) * self.Size

	local et = (self.startTime + (Distance/self.speed))
	if(self.dtt != 0) then
		self.dtt = (et - CurTime()) / (et - self.startTime)
	end
	if(self.dtt < 0) then
		self.dtt = 0
	end
	self.dAng = (EndPos - StartPos):Angle():Forward()

	gbAngle = (EndPos - StartPos):Angle()
	local Normal 	= gbAngle:Forward()

	// Draw the beam
	self:DrawMainBeam( StartPos, StartPos + Normal * Distance, self.dtt, Distance )

//	if (ViewModel) then
//		render.IgnoreZ( true )
//	end	
	
//	render.SetMaterial( matHook )
//	if(self.dtt == 0) then
//		render.DrawSprite( EndPos + Normal, 44, 44, Color( 255, 255, 255, self.Size * 255 ) )
//	else
//		EndPos = StartPos + (self.dAng * ((1 - self.dtt)*Distance))
//		render.DrawSprite( EndPos, 44, 44, Color( 120, 120, 255, self.Size * 255 ) )		
//	end
	
//	render.SetMaterial( matLight )
//	render.DrawSprite( StartPos, 28, 28, Color( 255, 255, 255, 255 * self.Size ) )
//	render.DrawSprite( StartPos, 64, 64, Color( 255, 255, 255, 255 * self.Size ) )
	// + Normal * 32
	
//	if (ViewModel) then
//		render.IgnoreZ( false )
//	end
	 
end

/*---------------------------------------------------------
   Name: IsTranslucent
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return true
end
