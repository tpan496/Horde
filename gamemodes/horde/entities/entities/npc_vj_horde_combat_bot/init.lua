AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/dog.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1400
ENT.SightDistance = 8000
ENT.HullType = HULL_HUMAN
ENT.MovementType = VJ_MOVETYPE_GROUND
ENT.DropWeaponOnDeath = false -- Should it drop its weapon on death?
ENT.SightAngle = 180 -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.LastSeenEnemyTimeUntilReset = 60 -- Time until it resets its enemy if its current enemy is not visible
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Oil" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodDecal = true
ENT.PlayerFriendly = true -- Makes the SNPC friendly to the player and HL2 Resistance
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.DamageByPlayerDispositionLevel = 1 -- 0 = Run it every time | 1 = Run it only when friendly to player | 2 = Run it only when enemy to player
-- Melee Attack ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = math.random(180,215)
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the melee attack animation?
ENT.MeleeAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackAngleRadius = 120 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.MeleeAttackDamageDistance = 82 -- How far does the damage go?
ENT.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1.10 -- How much time until it can use any attack again? | Counted in Seconds
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 190 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 390 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 0 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- How much chance there is that the enemy will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 5 -- How many reps?
ENT.MeleeAttackDamageType = DMG_CLUB
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 130 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 250 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 260 -- How far it will push you up | Second in math.random
-- Miscellaneous ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_MeleeAttack = {"throw"} -- Melee Attack Animations
-- ====== Other Variables ====== --
ENT.RunAwayOnUnknownDamage = false -- Should run away on damage
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_horde_boulder" -- The entity that is spawned when range attacking
	-- ====== Animation Variables ====== --
ENT.AnimTbl_RangeAttack = {"apc_throw"} -- Range Attack Animations
-- ====== Distance Variables ====== --
ENT.TimeUntilRangeAttackProjectileRelease = 3.8 -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 47
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.HasFootStepSound = true
ENT.SoundTbl_FootStep = {"npc/dog/dog_footstep_run1.wav","npc/dog/dog_footstep_run2.wav","npc/dog/dog_footstep_run3.wav","npc/dog/dog_footstep_run4.wav","npc/dog/dog_footstep_run5.wav","npc/dog/dog_footstep_run6.wav","npc/dog/dog_footstep_run7.wav","npc/dog/dog_footstep_run8.wav"}

-- ====== Sounds ====== --
ENT.SoundTbl_MeleeAttackSlowPlayer = {}
ENT.SoundTbl_MeleeAttack = {
"npc/dog/dog_angry1.wav",
"npc/dog/dog_angry2.wav",
"npc/dog/dog_angry3.wav",
}
ENT.SoundTbl_MeleeAttackMiss = {
"npc/dog/dog_laugh1.wav",
}
ENT.SoundTbl_CallForHelp = {

}
ENT.SoundTbl_CombatIdle = {
"npc/dog/dog_combatmode_loop1.wav",
"npc/dog/dog_pneumatic1.wav",
"npc/dog/dog_pneumatic2.wav",
}
ENT.SoundTbl_Idle = {
"npc/dog/dog_disappointed.wav",
"npc/dog/dog_idle1.wav",
"npc/dog/dog_idle2.wav",
"npc/dog/dog_idle3.wav",
"npc/dog/dog_idle4.wav",
"npc/dog/dog_idle5.wav",
"npc/dog/dog_playfull1.wav",
"npc/dog/dog_playfull2.wav",
"npc/dog/dog_playfull3.wav",
"npc/dog/dog_playfull4.wav",
"npc/dog/dog_playfull5.wav",

}
ENT.SoundTbl_Pain = {
"npc/dog/dog_growl2.wav",
"npc/dog/dog_growl3.wav",
}

ENT.SoundTbl_Death = {
"npc/dog/dog_scared1.wav",
"npc/dog/dog_on_dropship.wav",
}

ENT.SoundTbl_Alert = {
"npc/dog/dog_alarmed1.wav",
"npc/dog/dog_alarmed3.wav",
}
ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.RangeAttackPitch1 = 100
ENT.RangeAttackPitch2 = 100
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation

local extraSounds = {"physics/concrete/concrete_block_impact_hard1.wav", "physics/concrete/concrete_block_impact_hard2.wav", "physics/concrete/concrete_block_impact_hard3.wav"}

function ENT:CustomOnInitialize()
	self:SetColor(Color(0,150,255))
end

function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	self:EmitSound(extraSounds[ math.random( #extraSounds ) ], 125, 100, 1, CHAN_AUTO)
	return false
end

function ENT:DoRelationshipCheck(ent)
    if ent:IsPlayer() or ent:GetNWEntity("HordeOwner"):IsValid() then return false end
    return true
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Combat Bot","npc_vj_horde_combat_bot", "Horde")
