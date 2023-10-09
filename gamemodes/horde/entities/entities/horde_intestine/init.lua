
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local sndOnline = Sound( "hl1/fvox/activated.wav" )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self.Entity:DrawShadow( false )
	self.Entity:SetSolid( SOLID_NONE )
	
end

function ENT:Think()
	if (!self.Owner:Alive() or !self.Owner:IsValid()) then
		self:Remove()
	end
end

