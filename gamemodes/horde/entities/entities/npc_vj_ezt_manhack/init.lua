AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_medium.mdl"}
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.HullType = HULL_TINY
ENT.MovementType = VJ_MOVETYPE_AERIAL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasDeathRagdoll = false 
ENT.Aerial_TargetPos = Vector(4000,4000,4000)
ENT.FindEnemy_CanSeeThroughWalls = true
ENT.Aerial_ShouldBeFlying = true
ENT.HasMeleeAttack = false
ENT.Bleeds = false -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.HasBloodParticle = false -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = false -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.MeleeAttackDamage = 10
ENT.TimeUntilMeleeAttackDamage = math.random(0.1,0.3) -- This counted in seconds | This calculates the time until it hits something
ENT.NextMeleeAttackTime = math.random(0,0.6)
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC

ENT.MeleeAttackDamageAngleRadius = 100
ENT.Aerial_FlyingSpeed_Calm = 150 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking campared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 340 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running campared to ground SNPCs

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the leap attack animation?
ENT.LeapAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.LeapDistance = 405 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
	-- To use event-based attacks, set this to false:
ENT.TimeUntilLeapAttackDamage = 0.45 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 1 -- How much time until it can use a leap attack?
ENT.NextLeapAttackTime_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextAnyAttackTime_Leap_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.LeapAttackReps = 1 -- How many times does it run the leap attack code?
ENT.StopLeapAttackAfterFirstHit = true -- Should it stop the leap attack from running rest of timers when it hits an enemy?
ENT.TimeUntilLeapAttackVelocity = 0.1 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 50 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 0 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.LeapAttackDamage = 0
ENT.FriendsWithAllPlayerAllies = true
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SHOCK -- Type of Damage
ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 2 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.CallForHelp = false -- Does the SNPC call for help?
ENT.CallForHelpDistance = 1500 -- -- How far away the SNPC's call for help goes | Counted in World Units
ENT.NextCallForHelpTime = 5 -- Time until it calls for help again
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation
ENT.AnimTbl_CallForHelp = {"flinch_big"} -- Call For Help Animations
ENT.GodMode = true
ENT.CallForHelpAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.CallForHelpAnimationPlayBackRate = 1 -- How fast should the animation play? | Currently only for gestures!
ENT.CallForHelpStopAnimations = true -- Should it stop attacks for a certain amount of time?
	-- To let the base automatically detect the animation duration, set this to false:
ENT.CallForHelpStopAnimationsTime = 0.5 -- How long should it stop attacks?
ENT.CallForHelpAnimationFaceEnemy = true -- Should it face the enemy when playing the animation?
	-- To let the base automatically detect the animation duration, set this to false:
ENT.NextFlinchTime = 2 -- How much time until it can flinch again?

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------

local vec = Vector(0, 0, 0)
function ENT:CustomOnInitialize()
self.Manhack = ents.Create("sent_vj_ezt_manhack2")
        self.Manhack:SetPos(self:GetPos(1))
        self.Manhack:SetAngles(self:GetAngles())
        self.Manhack:SetOwner(self)
        self.Manhack:SetParent(self)
        self.Manhack:Spawn()
		self.Manhack.Owner = self
        self.Manhack:Activate()
		self.Manhack:SetMoveType(MOVETYPE_NONE)
	    self.Manhack:SetSolid(SOLID_BBOX)
		self.Manhack:DeleteOnRemove(self)
		self:SetNoDraw(true)
end
function ENT:AerialMove_Stop()
	if self:GetVelocity():Length() == 0 then
		self:SetLocalVelocity(Vector(0,0,0))
	end
end
function ENT:AerialMove_ChaseEnemy(ShouldPlayAnim,UseCalmVariables)
	if self.Dead == true or (self.NextChaseTime > CurTime()) or !IsValid(self:GetEnemy()) then return end
	local ShouldPlayAnim = ShouldPlayAnim or false
	local UseCalmVariables = UseCalmVariables or false
	local MoveSpeed = self.Aerial_FlyingSpeed_Alerted
	local Debug = self.Aerial_EnableDebug

	if UseCalmVariables == true then
		MoveSpeed = self.Aerial_FlyingSpeed_Calm
	end
	self:FaceCertainEntity(self:GetEnemy(),true)
	self.Aerial_ShouldBeFlying = false

	if ShouldPlayAnim == true && self.NextChaseTime < CurTime() then
		self.Aerial_CanPlayMoveAnimation = true
		if UseCalmVariables == true then
			self.Aerial_CurrentMoveAnimationType = "Calm"
		else
			self.Aerial_CurrentMoveAnimationType = "Alert"
		end
	else
		self.Aerial_CanPlayMoveAnimation = false
	end

	-- Main Calculations
	local vel_up =  10 //MoveSpeed
	local vel_for = 1
	local vel_stop = false
	local getenemyz = "None"
	local startpos = self:VJ_GetNearestPointToEntity(self:GetEnemy()).MyPosition // self:GetPos()
	local endpos = self:VJ_GetNearestPointToEntity(self:GetEnemy()).EnemyPosition // self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
	local tr = util.TraceHull({
		start = startpos,
		endpos = endpos,
		filter = self,
		mins = self:OBBMins(),
		maxs = self:OBBMaxs()
	})
	local selftohitpos = tr.HitPos
	local selftohitpos_dist = startpos:Distance(selftohitpos)
	if Debug == true then util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Beam",tr.StartPos,tr.HitPos,false,self:EntIndex(),0) end //vortigaunt_beam
	if selftohitpos_dist <= 2000 then
		if Debug == true then print("Aerial: Forward Blocked! [CHASE]") end
		vel_for = -10
		vel_up = 150
		//vel_for = -200
		//vel_stop = true
	end
	//else

	-- X Calculations
		-- Coming soon!

	-- Z Calculations
	local z_self = (self:GetPos()+self:OBBCenter()).z
	local z_ene = (self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()).z
	local tr_up_startpos = self:GetPos()+self:OBBCenter()
	//local tr_up = util.TraceLine({start = tr_up_startpos,endpos = self:GetPos()+self:OBBCenter()+self:GetUp()*300,filter = self})
	local tr_down_startpos = self:GetPos()+self:OBBCenter()
	local tr_down = util.TraceLine({start = tr_up_startpos,endpos = self:GetPos()+self:OBBCenter()+self:GetUp()*-300,filter = self})
	//print("UP - ",tr_up_startpos:Distance(tr_up.HitPos))
	//print(math.abs(z_ene)," OKK ",z_ene)
	//print(math.abs(z_self)," OKK ",z_self)
	if z_ene >= z_self then
		if math.abs(z_ene - z_self) >= 10 then
			if Debug == true then print("Aerial: UP [CHASE]") end
			getenemyz = "Up"
			//vel_up = 100
		end
	elseif z_ene <= z_self then
		if math.abs(z_self - z_ene) >= 10 then
			if Debug == true then print("Aerial: DOWN [CHASE]") end
			getenemyz = "Down"
			
			//vel_up = -100
		end
	end
	if getenemyz == "Up" && tr_down_startpos:Distance(tr_down.HitPos) >= 100 then
		if Debug == true then print("Aerial: GOING UP [CHASE]") end
		vel_up = MoveSpeed //100
	elseif getenemyz == "Up" && tr_down_startpos:Distance(tr_down.HitPos) >= 100 then
		if Debug == true then print("Aerial: GOING DOWN [CHASE]") end
		vel_up = -MoveSpeed //-100
	end
	/*if tr_up_startpos:Distance(tr_up.HitPos) <= 100 && tr_down_startpos:Distance(tr_down.HitPos) >= 100 then
		print("DOWN - ",tr_up_startpos:Distance(tr_up.HitPos))
		vel_up = -100
	end*/

	-- Set the velocity
	if vel_stop == false then
		//local myvel = self:GetVelocity()
		//local enevel = self:GetEnemy():GetVelocity()
		local vel_set = ((self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())-(self:GetPos()+self:OBBCenter())):GetNormal()*MoveSpeed +self:GetUp()*vel_up +self:GetForward()*vel_for
		//local vel_set_yaw = vel_set:Angle().y
		self:SetLocalVelocity(vel_set)
		if Debug == true then ParticleEffect("vj_impact1_centaurspit", self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter(), Angle(0,0,0), self) end
	else
	
		self:AerialMove_Stop()
	end
	//self.NextChaseTime = CurTime() + 0.1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
VJ_EmitSound(self,"npc/stukabat/stuka_explode.wav")
util.VJ_SphereDamage(self,self,self:GetPos(),250,math.random(30,40),DMG_ACID,true,true,{Force=30})
end
