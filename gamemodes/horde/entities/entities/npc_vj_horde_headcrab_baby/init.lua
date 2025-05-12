AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/horde/gonarch/headcrab_baby.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.TurningSpeed = 60 -- How fast it can turn
ENT.EntitiesToNoCollide = {"npc_vj_horde_xen_host_unit"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
ENT.StartHealth = 1
ENT.LeapDistance = 100 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.NoChaseAfterCertainRange_FarDistance = 150 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 150 -- How much upward force should it apply?
ENT.NextLeapAttackTime = 5 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = false
ENT.MeleeAttackDamage = 1
ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 1

ENT.GeneralSoundPitch1 = 120
ENT.GeneralSoundPitch2 = 120

-- Custom
ENT.BabH_Mother = NULL
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(5, 5, 10), Vector(-5, -5, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	-- Override the regular headcrab because we don't want it to play an alert animation
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	if IsValid(self.BabH_Mother) then
		self.BabH_Mother:Gonarch_BabyDeath()
	end
end

function ENT:BecomeFriendlyToPlayers()
	self.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
	self:AddRelationship("player D_LI 99")
    self:AddRelationship("ally D_LI 99")
	if HORDE.items["npc_vj_horde_vortigaunt"] then
        self:AddRelationship("npc_vj_horde_vortigaunt D_LI 99")
    end
    if HORDE.items["npc_vj_horde_combat_bot"] then
        self:AddRelationship("npc_vj_horde_combat_bot D_LI 99")
    end
    if HORDE.items["npc_turret_floor"] then
        self:AddRelationship("npc_turret_floor D_LI 99")
    end
    if HORDE.items["npc_manhack"] then
        self:AddRelationship("npc_manhack D_LI 99")
    end
    if HORDE.items["npc_vj_horde_class_survivor"] then
        self:AddRelationship("npc_vj_horde_class_survivor D_LI 99")
    end
    if HORDE.items["npc_vj_horde_class_assault"] then
        self:AddRelationship("npc_vj_horde_class_assault D_LI 99")
    end
    self:AddRelationship("npc_vj_horde_spectre D_LI 99")
end

VJ.AddNPC("Headcrab Baby","npc_vj_horde_headcrab_baby", "Horde")