AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {
    "models/vj_zombies/slow1.mdl",
    "models/vj_zombies/slow2.mdl",
    "models/vj_zombies/slow3.mdl",
    "models/vj_zombies/slow4.mdl",
    "models/vj_zombies/slow5.mdl",
    "models/vj_zombies/slow6.mdl",
    "models/vj_zombies/slow7.mdl",
    "models/vj_zombies/slow8.mdl",
    "models/vj_zombies/slow9.mdl",
    "models/vj_zombies/slow10.mdl",
    "models/vj_zombies/slow11.mdl",
    "models/vj_zombies/slow12.mdl",} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 75
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 65 -- How far does the damage go?
ENT.MeleeAttackDamage = 15
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/zombie/foot1.wav", "npc/zombie/foot2.wav", "npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"vj_zombies/slow/zombie_idle1.wav", "vj_zombies/slow/zombie_idle2.wav", "vj_zombies/slow/zombie_idle3.wav", "vj_zombies/slow/zombie_idle4.wav", "vj_zombies/slow/zombie_idle5.wav", "vj_zombies/slow/zombie_idle6.wav"}
ENT.SoundTbl_Alert = {"vj_zombies/slow/zombie_alert1.wav", "vj_zombies/slow/zombie_alert2.wav", "vj_zombies/slow/zombie_alert3.wav", "vj_zombies/slow/zombie_alert4.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_zombies/slow/zombie_attack_1.wav", "vj_zombies/slow/zombie_attack_2.wav", "vj_zombies/slow/zombie_attack_3.wav", "vj_zombies/slow/zombie_attack_4.wav", "vj_zombies/slow/zombie_attack_5.wav", "vj_zombies/slow/zombie_attack_6.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_zombies/slow/miss1.wav", "vj_zombies/slow/miss2.wav", "vj_zombies/slow/miss3.wav", "vj_zombies/slow/miss4.wav"}
ENT.SoundTbl_Pain = {"vj_zombies/slow/zombie_pain1.wav", "vj_zombies/slow/zombie_pain2.wav", "vj_zombies/slow/zombie_pain3.wav", "vj_zombies/slow/zombie_pain4.wav", "vj_zombies/slow/zombie_pain5.wav", "vj_zombies/slow/zombie_pain6.wav", "vj_zombies/slow/zombie_pain7.wav", "vj_zombies/slow/zombie_pain8.wav"}
ENT.SoundTbl_Death = {"vj_zombies/slow/zombie_die1.wav", "vj_zombies/slow/zombie_die2.wav", "vj_zombies/slow/zombie_die3.wav", "vj_zombies/slow/zombie_die4.wav", "vj_zombies/slow/zombie_die5.wav", "vj_zombies/slow/zombie_die6.wav"}

local sdFootScuff = {"npc/zombie/foot_slide1.wav", "npc/zombie/foot_slide2.wav", "npc/zombie/foot_slide3.wav"}

-- Custom
ENT.Zombie_LastAnimSet = 0 -- 0 = Regular | 1 = On fire

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self:IsOnFire() then
		if self.Zombie_LastAnimSet == 0 then
			self.Zombie_LastAnimSet = 1
			self.AnimTbl_Walk = {ACT_WALK_ON_FIRE}
			self.AnimTbl_Run = {ACT_WALK_ON_FIRE}
			self.AnimTbl_IdleStand = {ACT_IDLE_ON_FIRE}
		end
	elseif self.Zombie_LastAnimSet == 1 then
		self.Zombie_LastAnimSet = 0
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.AnimTbl_IdleStand = {ACT_IDLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attacka","vjseq_attackb","vjseq_attackc","vjseq_attackd"}
		self.TimeUntilMeleeAttackDamage = 1
		self.MeleeAttackDamage = 20
	else
		self.AnimTbl_MeleeAttack = {"vjseq_attacke","vjseq_attackf"}
		self.TimeUntilMeleeAttackDamage = 1
		self.MeleeAttackDamage = 30
	end
end

VJ.AddNPC("Walker","npc_vj_horde_walker", "Zombies")