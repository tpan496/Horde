ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_WORLD
ENT.CollisionGroupType = COLLISION_GROUP_WORLD

function ENT:Initialize()
if SERVER then
    self:SetModel(self.Model)
    self:SetMoveType(MOVETYPE_NONE)
    self:PhysicsInitSphere( 1 )
    self:DrawShadow(false)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(false)
        phys:SetMass(1)
    end

    self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

if CLIENT then
    ParticleEffectAttach("horde_mutation_nemesis", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
end

function ENT:Draw()
    self:DrawModel()
end