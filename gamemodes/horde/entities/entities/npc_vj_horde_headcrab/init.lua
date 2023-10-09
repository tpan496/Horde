AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/headcrabclassic.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"}
ENT.TurningSpeed = 60 -- How fast it can turn
ENT.StartHealth = 1
ENT.LeapDistance = 100 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.NoChaseAfterCertainRange_FarDistance = 150 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 150 -- How much upward force should it apply?
ENT.NextLeapAttackTime = 5 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.PlayerFriendly = true -- Makes the SNPC friendly to the player and HL2 Resistance
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = false
ENT.MeleeAttackDamage = 1
ENT.HasLeapAttack = true
ENT.LeapAttackDamage = 1

ENT.GeneralSoundPitch1 = 120
ENT.GeneralSoundPitch2 = 120

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20, 20), Vector(-20, -20, 0))
    self.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"}
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
    self:AddRelationship("npc_vj_horde_spectre D_LI 99")
	self:AddRelationship("npc_vj_horde_antlion D_LI 99")
end

VJ.AddNPC("Headcrab","npc_vj_horde_headcrab", "Horde")