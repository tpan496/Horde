AddCSLuaFile("shared.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.TouchedEntities = {}
ENT.Removing = nil

function ENT:Horde_SetAuraRadius(radius)
    
end

function ENT:Initialize()
    self.Horde_AuraRadius = 100
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
        if self.Removing then return end
        if not ent:IsPlayer() then return end
        if self.TouchedEntities[ent:GetCreationID()] and ent.Horde_InteractionAuraProvider then return end
        self.TouchedEntities[ent:GetCreationID()] = ent
        ent:Horde_AddInteractionAuraEffects(self:GetParent())
    end
end

function ENT:EndTouch(ent)
    if SERVER then
        if self.Removing then return end
        if not ent:IsPlayer() or not ent:IsValid() then return end
        self.TouchedEntities[ent:GetCreationID()] = nil
        ent:Horde_RemoveInteractionAuraEffects()
        if ent.Horde_InteractionAura then
            ent:Horde_AddInteractionAura()
        end
    end
end

function ENT:OnRemove()
    self.Removing = true
    if not self.TouchedEntities then return end
    for _, ent in pairs(self.TouchedEntities) do
        ent:Horde_RemoveInteractionAuraEffects()
    end
end