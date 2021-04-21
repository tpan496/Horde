AddCSLuaFile("shared.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.TouchedEntities = {}

function ENT:Horde_SetAuraRadius(radius)
    self.Horde_AuraRadius = radius or 160
end

function ENT:Initialize()
    self:PhysicsInitSphere(self.Horde_AuraRadius)
	self:SetCollisionBounds(Vector(-self.Horde_AuraRadius, -self.Horde_AuraRadius, -self.Horde_AuraRadius), Vector(self.Horde_AuraRadius, self.Horde_AuraRadius, self.Horde_AuraRadius))
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)
    self:PhysWake()
    self:SetRenderMode(RENDERMODE_ENVIROMENTAL)
    self:SetColor(Color(0, 0, 0, 0))
end

function ENT:Touch(ent)
    if SERVER then
        if not ent:IsPlayer() then return end
        if self.TouchedEntities[ent:GetCreationID()] then return end
        self.TouchedEntities[ent:GetCreationID()] = ent
        ent:Horde_AddWardenAuraEffects(self:GetParent())
    end
end

function ENT:EndTouch(ent)
    if SERVER then
        if not ent:IsPlayer() then return end
        self.TouchedEntities[ent:GetCreationID()] = nil
        if ent.Horde_WardenAura then
            ent:Horde_AddWardenAura()
        else
            ent:Horde_RemoveWardenAuraEffects()
        end
    end
end