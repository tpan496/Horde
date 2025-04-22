AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/bloodsquid/bloodsquid.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 125
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"bite"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 30
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_WALK} -- Set the running animations | Put multiple to let the base pick a random animation when it moves

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"range"} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_vomitter_projectile" -- The entity that is spawned when range attacking
ENT.RangeDistance = 850 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "attach_mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.5 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 10 -- How much time until it can use a range attack?

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
--ENT.SoundTbl_Breath = {"npc/zombie_poison/pz_breathe_loop1.ogg"}
ENT.SoundTbl_Alert = {"horde/bloodsquid/bc_attackgrowl1.ogg","horde/bloodsquid/bc_attackgrowl2.ogg","horde/bloodsquid/bc_attackgrowl3.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"horde/bloodsquid/bc_pain1.ogg","horde/bloodsquid/bc_pain2.ogg","horde/bloodsquid/bc_pain3.ogg"}
ENT.SoundTbl_Death = {"horde/bloodsquid/bc_die1.ogg","horde/bloodsquid/bc_die2.ogg"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	--self:SetCollisionBounds(Vector(15, 15, 50), Vector(-15, -15, 0))
	--self:SetModelScale(1.5, 0)
	self:SetColor(Color(200, 100, 100))
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	if HORDE:IsPoisonDamage(dmginfo) then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.25)
	end
end

function ENT:TranslateActivity(act)
    -- throw1 idle, throw2 walk, throw3 run
    if (act == ACT_WALK or act == ACT_RUN) then
		if self:Health() <= self:GetMaxHealth() * 0.5 then
			return ACT_RUN
		end
        return ACT_WALK
    end
    return self.BaseClass.TranslateActivity(self, act)
end

local attackTimers = {
	[VJ.ATTACK_TYPE_MELEE] = function(self, skipStopAttacks)
		if !skipStopAttacks then
			timer.Create("attack_melee_reset" .. self:EntIndex(), self:GetAttackTimer(self.NextAnyAttackTime_Melee, self.TimeUntilMeleeAttackDamage, self.AttackAnimDuration), 1, function()
				self:StopAttacks()
				self:MaintainAlertBehavior()
			end)
		end
		timer.Create("attack_melee_reset_able" .. self:EntIndex(), self:GetAttackTimer(self.NextMeleeAttackTime), 1, function()
			self.IsAbleToMeleeAttack = true
		end)
	end,
	[VJ.ATTACK_TYPE_RANGE] = function(self, skipStopAttacks)
		if !skipStopAttacks then
			timer.Create("attack_range_reset" .. self:EntIndex(), self:GetAttackTimer(self.NextAnyAttackTime_Range, self.TimeUntilRangeAttackProjectileRelease, self.AttackAnimDuration), 1, function()
				self:StopAttacks()
				self:MaintainAlertBehavior()
			end)
		end
		timer.Create("attack_range_reset_able" .. self:EntIndex(), self:GetAttackTimer(self.NextRangeAttackTime), 1, function()
			self.IsAbleToRangeAttack = true
		end)
	end,
	[VJ.ATTACK_TYPE_LEAP] = function(self, skipStopAttacks)
		if !skipStopAttacks then
			timer.Create("attack_leap_reset" .. self:EntIndex(), self:GetAttackTimer(self.NextAnyAttackTime_Leap, self.TimeUntilLeapAttackDamage, self.AttackAnimDuration), 1, function()
				self:StopAttacks()
				self:MaintainAlertBehavior()
			end)
		end
		timer.Create("attack_leap_reset_able" .. self:EntIndex(), self:GetAttackTimer(self.NextLeapAttackTime), 1, function()
			self.IsAbleToLeapAttack = true
		end)
	end
}

function ENT:ExecuteRangeAttack()
	local selfData = self:GetTable()
	if selfData.Dead or selfData.PauseAttacks or selfData.Flinching or selfData.AttackType == VJ.ATTACK_TYPE_MELEE then return end
	local ene = self:GetEnemy()
	local eneValid = IsValid(ene)
	if eneValid then
		selfData.AttackType = VJ.ATTACK_TYPE_RANGE
		//self:PointAtEntity(ene)
		-- Create projectile
		if !self:OnRangeAttackExecute("Init", ene) then
			local projectile = ents.Create(self.RangeAttackEntityToSpawn)
			local target_pos = self:GetEnemy():GetPos()
			projectile:SetPos(self:GetAttachment(1).Pos)
			projectile:SetAngles((target_pos - projectile:GetPos()):Angle())
			projectile:SetOwner(self)
			projectile:SetPhysicsAttacker(self)
			projectile:Spawn()
			projectile:Activate()
			//constraint.NoCollide(self, projectile, 0, 0)
			local phys = projectile:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
				--local vel = self:RangeAttackProjVel(projectile)
				local vel = (target_pos - self:GetAttachment(1).Pos) * 1.5
				phys:SetVelocity(vel)
				projectile:SetAngles(vel:GetNormal():Angle())
			else
				local vel = self:RangeAttackProjVel(projectile)
				projectile:SetVelocity(vel)
				projectile:SetAngles(vel:GetNormal():Angle())
			end
			self:OnRangeAttackExecute("PostSpawn", ene, projectile)
		end
	end
	if selfData.AttackState < VJ.ATTACK_STATE_EXECUTED then
		if eneValid then -- Play range attack only once, otherwise it will spam it for every projectile!
			self:PlaySoundSystem("RangeAttack")
		end
		selfData.AttackState = VJ.ATTACK_STATE_EXECUTED
		if selfData.TimeUntilRangeAttackProjectileRelease then
			attackTimers[VJ.ATTACK_TYPE_RANGE](self)
		end
	end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Vomitter","npc_vj_horde_vomitter", "Zombies")