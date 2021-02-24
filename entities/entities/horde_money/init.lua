AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetColor(IsMounted("cstrike") and Color(255, 255, 255) or Color(0, 255, 0))
    self:SetModel(IsMounted("cstrike") and "models/props/cs_assault/Money.mdl" or "models/items/flare.mdl")
    self:SetModelScale(2)
    self:PhysicsInitBox(Vector(-4, -4, -1), Vector(4, 4, 1))
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)

    self.Removing = false
    self:PhysWake()
end

function ENT:StartTouch(entity)
    if not self.Removing and entity:IsPlayer() and entity:Alive() and entity ~= self:GetOwner() then
        self.Removing = true
        entity:AddMoney(50)
        entity:SyncEconomy()
        entity:EmitSound("physics/metal/metal_computer_impact_soft2.wav", 70, 200, 0.1)
        self:Remove()
    end
end