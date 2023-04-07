AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/infected_stalker/infected_stalker.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 20
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.3 -- Next foot step sound when it is walking
ENT.AnimTbl_Run = {ACT_WALK}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/stalker/stalker_footstep_left1.wav", "npc/stalker/stalker_footstep_left2.wav", "npc/stalker/stalker_footstep_right1.wav", "npc/stalker/stalker_footstep_right2.wav"}
ENT.SoundTbl_Idle = {"npc/stalker/breathing3.wav"}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"zsszombies/zmisc_pain1.wav","zsszombies/zmisc_pain2.wav","zsszombies/zmisc_pain3.wav","zsszombies/zmisc_pain4.wav","zsszombies/zmisc_pain5.wav","zsszombies/zmisc_pain6.wav"}
ENT.SoundTbl_Death = {"zsszombies/zmisc_die1.wav","zsszombies/zmisc_die2.wav","zsszombies/zmisc_die3.wav"}

ENT.FootStepSoundLevel = 55
ENT.NextBlastTime = CurTime()
ENT.NextBlastCooldown = 8
ENT.AnimTbl_MeleeAttack = {}
ENT.Critical = nil
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(12, 12, 65), Vector(-12, -12, 0))
	--self:SetModelScale(1.25, 0)
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if HORDE:IsLightningDamage(dmginfo) then
		dmginfo:ScaleDamage(0.5)
    elseif HORDE:IsBlastDamage(dmginfo) then
        dmginfo:ScaleDamage(1.25)
    end
end

function ENT:ShockAttack(delay)
	if self.Horde_Stunned then return end
	timer.Simple(delay, function()
		if not self:IsValid() then return end
		local dmg = DamageInfo()
		dmg:SetAttacker(self)
		dmg:SetInflictor(self)
		dmg:SetDamageType(DMG_SHOCK)
		dmg:SetDamage(12)
		util.BlastDamageInfo(dmg, self:GetPos(), 300)

		for _, ent in pairs(ents.FindInSphere(self:GetPos(), 300)) do
			if ent:IsPlayer() then
				ent:Horde_AddDebuffBuildup(HORDE.Status_Shock, 4, self)
			end
		end
		
		local e = EffectData()
			e:SetOrigin(self:GetPos())
			e:SetNormal(Vector(0,0,1))
		util.Effect("screecher_blast", e, true, true)
	end)
end

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
		self.AnimTbl_Run = {ACT_RUN}
    end
end

function ENT:CustomOnThink()
	if not self:GetEnemy() then return end
	local EnemyDistance = self.NearestPointToEnemyDistance
	if EnemyDistance < 250 then
		if CurTime() > self.NextBlastTime then
			sound.Play("npc/stalker/go_alert2.wav", self:GetPos())
			self:VJ_ACT_PLAYACTIVITY("podconvulse", true, 1.5, false)
			self:ShockAttack(1.5)
			self:ShockAttack(1.7)
			self:ShockAttack(1.9)
			self:ShockAttack(2.1)
			self:ShockAttack(2.3)
			self.NextBlastTime = CurTime() + self.NextBlastCooldown
			timer.Simple(2.5, function ()
				if not self:IsValid() then return end
				self:VJ_ACT_PLAYACTIVITY("walk")
			end)
		end
	end
end

VJ.AddNPC("Screecher","npc_vj_horde_screecher", "Zombies")