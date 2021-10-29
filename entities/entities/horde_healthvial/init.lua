AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel("models/healthvial.mdl")
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
    if not self.Removing and entity:IsPlayer() and entity:Alive() and not entity:IsBot() and entity:Health() < entity:GetMaxHealth() then
        sound.Play("items/medshot4.wav", entity:GetPos())
        if entity:GetNWEntity("HordeOwner"):IsValid() then
            local healinfo = HealInfo:New({amount=15, healer=self:GetNWEntity("HordeOwner")})
            HORDE:OnPlayerHeal(self:GetNWEntity("HordeOwner"), healinfo)
        else
            local healinfo = HealInfo:New({amount=15, healer=entity})
            HORDE:OnPlayerHeal(entity, healinfo)
        end
        self.Removing = true
        self:Remove()
    end
end