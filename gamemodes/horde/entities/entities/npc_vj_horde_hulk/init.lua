AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/horde/hulk/hulk.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1200
ENT.HullType = HULL_MEDIUM_TALL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 95 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 40
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 130 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 250 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 260 -- How far it will push you up | Second in math.random
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Breath = {"npc/zombie_poison/pz_breathe_loop1.wav"}
ENT.SoundTbl_Idle = {"npc/zombie_poison/pz_idle2.wav","npc/zombie_poison/pz_idle3.wav","npc/zombie_poison/pz_idle4.wav"}
ENT.SoundTbl_Alert = {"npc/zombie_poison/pz_warn1.wav","npc/zombie_poison/pz_warn2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"npc/zombie_poison/pz_pain1.wav","npc/zombie_poison/pz_pain2.wav","npc/zombie_poison/pz_pain3.wav"}
ENT.SoundTbl_Death = {"npc/zombie_poison/pz_die1.wav","npc/zombie_poison/pz_die2.wav"}

ENT.GeneralSoundPitch1 = 60
ENT.GeneralSoundPitch2 = 65

ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.WorldShakeOnMoveAmplitude = 8 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.WorldShakeOnMoveRadius = 200 -- How far the screen shake goes, in world units
ENT.WorldShakeOnMoveDuration = 0.4 -- How long the screen shake will last, in seconds
ENT.WorldShakeOnMoveFrequency = 100 -- Just leave it to 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(18, 18, 90), Vector(-18, -18, 0))
	self:SetSkin(math.random(0,3))
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self:SetMoveVelocity(Vector(0,0,0))

	self:EmitSound("zsszombie/vj_bossz_call.wav", 1500, 90, 1, CHAN_STATIC)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("FireWalk"))}
		self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("FireWalk"))}
	else
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
	end
	if self.Critical and self:IsOnGround() then
		self:SetLocalVelocity(self:GetMoveVelocity() * 1.5)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Critical = false
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
    if not self.Critical and self:Health() < self:GetMaxHealth() / 2 then
        self.Critical = true
        self.AnimationPlaybackRate = 1.5
        self:SetColor(Color(255,0,0))
        self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Hulk","npc_vj_horde_hulk", "Zombies")
