AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetColor(IsMounted("cstrike") and Color(255, 255, 255) or Color(0, 255, 0))
    self:SetModel(IsMounted("cstrike") and "models/props/cs_assault/Money.mdl" or "models/items/flare.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    --self:PhysicsInitBox(Vector(-4, -4, -1), Vector(4, 4, 1))
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetModelScale(2)
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
        entity:EmitSound("horde/dosh_" .. math.random(1, 4) .. ".ogg", 70, 100, 0.25)
        self:Remove()
    end
end