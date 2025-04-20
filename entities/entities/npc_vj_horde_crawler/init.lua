AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
--ENT.Model = {"models/zombie/zm_fast.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 30
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"vjseq_melee"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 10
ENT.TimeUntilMeleeAttackDamage = 0.2
ENT.NextAnyAttackTime_Melee = 0.6
ENT.HasLeapAttack = false -- Should the SNPC have a leap attack?
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.AnimTbl_Run = ACT_WALK

ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 60
ENT.CanFlinch = 1
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetSkin(math.random(0,3))
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav", "npc/zombie/foot2.wav", "npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"vj_zombies/fast/fzombie_idle1.wav", "vj_zombies/fast/fzombie_idle2.wav", "vj_zombies/fast/fzombie_idle3.wav", "vj_zombies/fast/fzombie_idle4.wav", "vj_zombies/fast/fzombie_idle5.wav"}
ENT.SoundTbl_Alert = {"vj_zombies/fast/fzombie_alert1.wav", "vj_zombies/fast/fzombie_alert2.wav", "vj_zombies/fast/fzombie_alert3.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_zombies/fast/attack1.wav", "vj_zombies/fast/attack2.wav", "vj_zombies/fast/attack3.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"npc/zombie/claw_strike1.wav", "npc/zombie/claw_strike2.wav", "npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav", "vj_zombies/slow/miss2.wav", "vj_zombies/slow/miss3.wav", "vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_LeapAttackJump = {"vj_zombies/fast/hunter_attackmix_01.wav", "vj_zombies/fast/hunter_attackmix_02.wav", "vj_zombies/fast/hunter_attackmix_03.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/zombie/claw_strike1.wav", "npc/zombie/claw_strike2.wav", "npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_Pain = {"vj_zombies/fast/fzombie_pain1.wav", "vj_zombies/fast/fzombie_pain2.wav", "vj_zombies/fast/fzombie_pain3.wav"}
ENT.SoundTbl_Death = {"vj_zombies/fast/fzombie_die1.wav", "vj_zombies/fast/fzombie_die2.wav"}

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PreInit()
	if !self.Model then
		-- Have to randomize it here soo all types spawn equally since some are only skins
		local randModel = math.random(1, 7)
		if randModel == 1 then
			self.Model = "models/vj_zombies/fast1.mdl"
		elseif randModel == 2 then
			self.Model = "models/vj_zombies/fast2.mdl"
		elseif randModel == 3 then
			self.Model = "models/vj_zombies/fast3.mdl"
		elseif randModel == 4 then
			self.Model = "models/vj_zombies/fast4.mdl"
			self:SetSkin(1)
		elseif randModel == 5 then
			self.Model = "models/vj_zombies/fast4.mdl"
			self:SetSkin(2)
		elseif randModel == 6 then
			self.Model = "models/vj_zombies/fast4.mdl"
			self:SetSkin(3)
		else
			self.Model = "models/vj_zombies/fast4.mdl"
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(13, 13, 50), Vector(-13, -13, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "step" then
		self:PlayFootstepSound()
	elseif key == "melee" then
		self:ExecuteMeleeAttack()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE then
		if !self:OnGround() && !self:IsMoving() then
			return ACT_GLIDE
		elseif self:IsOnFire() then
			return ACT_IDLE_ON_FIRE
		end
	elseif act == ACT_CLIMB_DOWN then -- Because there is no animation, so just use climb up!
		return ACT_CLIMB_UP
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnLeapAttack(status, enemy)
	if status == "Jump" then
		return VJ.CalculateTrajectory(self, enemy, "Curve", self:GetPos() + self:OBBCenter(), enemy:GetPos() + enemy:OBBCenter(), 25) + self:GetForward() * 80
	end
end