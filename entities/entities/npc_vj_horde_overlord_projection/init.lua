AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/combine_soldier_prisonguard.mdl" -- Leave empty if using more than one model
ENT.StartHealth = 125
ENT.VJ_NPC_Class = { "CLASS_COMBINE", "CLASS_PLAYER_ALLY" }
ENT.MeleeAttackDamage = 30
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 10000                         -- How far it can see
ENT.SightAngle = 180                               -- The sight angle | Example: 180 would make the it see all around it | Measured in degrees and then converted to radians
ENT.TurningSpeed = 20                             -- How fast it can turn
ENT.Bleeds = true                                 -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor =
"Red"                                             -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasBloodParticle = true                       -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true                          -- Does it spawn a decal when damaged?
ENT.HasBloodPool = false                          -- Does it have a blood pool?
ENT.Flinches = 0                                  -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
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
ENT.HasMeleeAttack = false                         -- Should the SNPC have a melee attack?
ENT.HasGrenadeAttack = false                       -- Should the SNPC have a grenade attack?
ENT.NextThrowGrenadeTime1 = 10                    -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = 15                    -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1                        -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 500             -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 0         -- How close until it stops throwing grenades
ENT.AnimTbl_GrenadeAttack = { "grenThrow" }       -- Grenade Attack Animations
ENT.GrenadeAttackAnimationDelay = 0               -- It will wait certain amount of time before playing the animation
ENT.GrenadeAttackAnimationStopAttacks = false      -- Should it stop attacks for a certain amount of time?
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
ENT.CanShootWhenMoving = true
ENT.ConstantlyFaceEnemy = true

    -- ====== Item Drops On Death Variables ====== --
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.DropWeaponOnDeath = false -- Should it drop its weapon on death?

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
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    if self.Is_Reinforcements then
        self:SetMaxHealth(self.StartHealth * 0.5)
		self:SetHealth(self:GetMaxHealth())
    end
    local ply = self:GetOwner()
    if ply:Horde_GetGadget() == "gadget_shotgun_surgeon" then
        self:SetSkin(1)
    end
    self:Give("weapon_vj_horde_projection_shotgun")
    self:AddRelationship("player D_LI 99")
    self:AddRelationship("ally D_LI 99")
    self:AddRelationship("npc_turret_floor D_LI 99")
    self:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
    self:AddRelationship("npc_manhack D_LI 99")
    self:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
    self:AddRelationship("npc_vj_horde_rocket_turret D_LI 99")
    self:AddRelationship("npc_vj_horde_spectre D_LI 99")
    self:AddRelationship("npc_vj_horde_antlion D_LI 99")
    self:SetNPCState(NPC_STATE_COMBAT)
    self:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
    self.Horde_Immune_Status_All = true
    self:Horde_AddOverlordPresence()
    
    timer.Simple(15, function()
        if not self:IsValid() then return end
        self:NextThink(CurTime() + 2)
        --self:Remove()
        self:DankRemove()
    end)
end

-- This is here for VJank base to not error out when it removes the entity the same frame the target targets something
function ENT:DankRemove()
    --self:SetSchedule(SCHED_NPC_FREEZE)
    self:NextThink(CurTime() + 2)
    timer.Simple(1, function()
        if not self:IsValid() then return end
        self:Remove()
    end)
end
--[[
function ENT:OnRemove()
end

function ENT:RangeAttackCode()
end
]]
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

VJ.AddNPC("Projection", "npc_vj_horde_overlord_projection", "Zombies")
