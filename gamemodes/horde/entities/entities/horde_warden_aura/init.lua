AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.TouchedEntities = {}
ENT.Removing = nil

function ENT:Horde_SetAuraRadius(radius)
    self.Horde_AuraRadius = radius or 160
    self:SetRadius( radius )
end

function ENT:Initialize()
    self:PhysicsInitSphere(self.Horde_AuraRadius)
    self:SetCollisionBounds(Vector(-self.Horde_AuraRadius, -self.Horde_AuraRadius, -self.Horde_AuraRadius), Vector(self.Horde_AuraRadius, self.Horde_AuraRadius, self.Horde_AuraRadius))
    self:SetSolid(SOLID_NONE)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)
    self:PhysWake()
    self:SetRenderMode(RENDERMODE_ENVIROMENTAL)
    self:SetColor(Color(0, 0, 0, 0))
    self:DrawShadow(false)
end

function ENT:Touch(ent)
    if SERVER then
        if self.Removing then return end
        if not ent:IsPlayer() then return end
        if self.TouchedEntities[ent:GetCreationID()] and ent.Horde_WardenAuraProvider then return end
        self.TouchedEntities[ent:GetCreationID()] = ent
        ent:Horde_AddWardenAuraEffects(self:GetParent())
    end
end

function ENT:EndTouch(ent)
    if SERVER then
        if self.Removing then return end
        if not ent:IsPlayer() or not ent:IsValid() then return end
        self.TouchedEntities[ent:GetCreationID()] = nil
        ent:Horde_RemoveWardenAuraEffects()
        if ent.Horde_WardenAura then
            ent:Horde_AddWardenAura()
        end
    end
end

function ENT:OnRemove()
    self.Removing = true
    if not self.TouchedEntities then return end
    for _, ent in pairs(self.TouchedEntities) do
        ent:Horde_RemoveWardenAuraEffects()
    end
end
