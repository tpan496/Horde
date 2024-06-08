AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/combine_soldier.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 1050
ENT.VJ_NPC_Class = { "CLASS_COMBINE", "CLASS_PLAYER_ALLY" }
ENT.MeleeAttackDamage = 30
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 10000                         -- How far it can see
ENT.SightAngle = 80                               -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 20                             -- How fast it can turn
ENT.Bleeds = true                                 -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor =
"Red"                                             -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodParticle = true                       -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true                          -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false                          -- Does it have a blood pool?
ENT.Flinches = 1                                  -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 12                          -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = { SCHED_FLINCH_PHYSICS } -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
ENT.MoveWhenDamagedByEnemy = false                -- Should the SNPC move when being damaged by an enemy?
ENT.MoveWhenDamagedByEnemySCHED1 =
	SCHED_FORCED_GO_RUN                           -- The schedule it runs when MoveWhenDamagedByEnemy code is ran | The first # in math.random
ENT.MoveWhenDamagedByEnemySCHED2 =
	SCHED_FORCED_GO_RUN                           -- The schedule it runs when MoveWhenDamagedByEnemy code is ran | The second # in math.random
ENT.NextMoveWhenDamagedByEnemy1 = 3               -- Next time it moves when getting damaged | The first # in math.random
ENT.NextMoveWhenDamagedByEnemy2 = 3.5             -- Next time it moves when getting damaged | The second # in math.random
ENT.HasAllies = true                              -- Put to false if you want it not to have any allies
ENT.HasMeleeAttack = true                         -- Should the SNPC have a melee attack?
ENT.HasGrenadeAttack = true                       -- Should the SNPC have a grenade attack?
ENT.NextThrowGrenadeTime1 = 10                    -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = 15                    -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1                        -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 1000             -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 500         -- How close until it stops throwing grenades
ENT.AnimTbl_GrenadeAttack = { "grenThrow" }       -- Grenade Attack Animations
ENT.GrenadeAttackAnimationDelay = 0               -- It will wait certain amount of time before playing the animation
ENT.GrenadeAttackAnimationStopAttacks = true      -- Should it stop attacks for a certain amount of time?
ENT.GrenadeAttackEntity =
"npc_grenade_frag"                                -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.FootStepTimeRun = 0.3                         -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5                        -- Next foot step sound when it is walking
ENT.CallForBackUpOnDamage = false                 -- Should the SNPC call for help when damaged? (Only happens if the SNPC hasn't seen a enemy)
ENT.CanDetectDangers = false
ENT.MoveOrHideOnDamageByEnemy = false
ENT.WeaponSpread = 0.5
ENT.CallForHelp = false
ENT.CanInvestigate = false
ENT.PlayerFriendly = true

ENT.SoundTbl_FootStep = {
	"npc/combine_soldier/gear1.wav",
	"npc/combine_soldier/gear2.wav",
	"npc/combine_soldier/gear3.wav",
	"npc/combine_soldier/gear4.wav",
	"npc/combine_soldier/gear5.wav",
	"npc/combine_soldier/gear6.wav" }

-- ====== Sound Pitch ====== --
-- Higher number = Higher pitch | Lower number = Lower pitch
-- Highest number is 254
-- !!! Important variables !!! --
ENT.UseTheSameGeneralSoundPitch = true
-- If set to true, it will make the game decide a number when the SNPC is created and use it for all sound pitches set to "UseGeneralPitch"
-- It picks the number between the two variables below:
ENT.GeneralSoundPitch1 = 75
ENT.GeneralSoundPitch2 = 75

function ENT:CustomOnInitialize()
end

function ENT:RangeAttackCode()
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Projection", "npc_vj_horde_overlord_projection", "Zombies")
