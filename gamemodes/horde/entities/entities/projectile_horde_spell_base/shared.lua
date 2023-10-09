ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.Spawnable 			= false


AddCSLuaFile()

ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.Model)
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:PhysicsInitSphere(1)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:EnableGravity(false)
            phys:SetMass(1)
        end
    end

    if self.CustomOnInitialize then
        self:CustomOnInitialize()
    end
end

function ENT:SetSpellBaseDamages(damages)
    local bonus = {increase = 0, more = 1}
	hook.Run("Horde_OnPlayerSpellDamage", self.Owner, bonus)
    self.SpellBaseDamages = {}
    for i = 1, #damages do
        self.SpellBaseDamages[i] = damages[i] * (bonus.increase + 1) * bonus.more
    end
end

function ENT:GetSpellBaseDamage(i)
    return self.SpellBaseDamages[i]
end

function ENT:SetSpellLevel(level)
    self.Horde_SpellLevel = level
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Charged")
end

function ENT:Draw()
    self:DrawModel()
end