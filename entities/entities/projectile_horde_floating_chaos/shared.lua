ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:Initialize()
    if SERVER then
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(false)
        phys:SetMass(1)
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    
    self:SetCollisionGroup(COLLISION_GROUP_WORLD)

    self.ExplodeTimer = CurTime() + 3 + self.Horde_Spell_Level

    self.Owner.Horde_Floating_Chaos = self

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime()

    sound.Play("horde/weapons/solar_seal/floating_chaos_launch.ogg", self.Owner:GetPos(), 100, math.random(90, 110))
    end

    --ParticleEffectAttach("floating_chaos", PATTACH_ABSORIGIN_FOLLOW, self, 0)
    ParticleEffectAttach("solar_orb_charged_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end
    if SERVER and self.ExplodeTimer <= CurTime() then
        self:Remove()
    end
end

function ENT:Draw()
    self:DrawModel()
end

function ENT:OnRemove()
    if self.Owner:IsValid() then
        self.Owner.Horde_Floating_Chaos = nil
    end
end