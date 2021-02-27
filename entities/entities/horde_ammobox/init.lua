AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()

    self:SetColor(Color(0, 255, 0))
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
    if not self.Removing and entity:IsPlayer() and entity:Alive() and not entity:IsBot() then
        local given_ammo = false
        for _, wpn in pairs(entity:GetWeapons()) do
            local given = HORDE.GiveAmmo(entity, wpn, 1)
            given_ammo = given_ammo or given
        end

        if given_ammo then
            self.Removing = true
            self:Remove()
        end
    end
end