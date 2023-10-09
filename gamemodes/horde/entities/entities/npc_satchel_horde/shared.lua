AddCSLuaFile()

ENT.Type = "anim"
ENT.NextGlow = CurTime()

function ENT:Initialize()
    if CLIENT then return end
    self:SetModel("models/weapons/w_slam.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self:SetUseType(SIMPLE_USE)
    self:SetBodygroup(0, 1)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(true)
    end
end

function ENT:GetHordeOwner()
    return self.HordeOwner
end