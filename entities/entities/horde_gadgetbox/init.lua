AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()

    self:SetColor(Color(255, 0, 0))
    self:SetModel("models/items/boxmrounds.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetModelScale(1.5)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)

    self.Removing = false
    self:PhysWake()
end

function ENT:StartTouch(entity)
    if !self.Removing
    and entity:IsPlayer()
    and entity:Alive()
    and !entity:IsBot()
    and entity:Horde_GetGadget() == nil
    and self.Horde_Gadget then
        local weight = HORDE.items[self.Horde_Gadget].weight
        if entity:Horde_GetWeight() < weight then return end
        
        local given_ammo = false
        entity:Horde_SetGadget(self.Horde_Gadget)
        entity:Horde_SyncEconomy()
        given_ammo = true

        if given_ammo then
            self.Removing = true
            self:Remove()
        end
    end
end