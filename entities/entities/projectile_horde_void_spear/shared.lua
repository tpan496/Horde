ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/crossbow_bolt.mdl"
ENT.Ticks = 0
ENT.FuseTime = 10
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil
ENT.StartPos = nil

if SERVER then

function ENT:Initialize()
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:SetMass(1)
        phys:EnableGravity(false)
    end

    self.SpawnTime = CurTime()
    self.StartPos = self:GetPos()

    timer.Simple(0.1, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)

    timer.Simple(0.5, function ()
        if not self:IsValid() then return end
        self.Removing = true
        self:Remove()
    end)

    ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
    ParticleEffectAttach("ice_freezing_halo", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
    end
end

else

end

function ENT:Detonate(hitpos)
    if !self:IsValid() or self.Removing then return end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    self:FireBullets({
        Attacker = attacker,
        Damage = 30,
        Tracer = 0,
        Distance = 4000,
        Dir = (hitpos - self:GetPos()),
        Src = self:GetPos(),
        Callback = function(att, tr, dmg)
            dmg:SetDamageType(DMG_REMOVENORAGDOLL)
            dmg:SetAttacker(self.Owner)
            dmg:SetInflictor(self)
        end
    })
    
    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local pos = colData.HitPos
    if colData.HitEntity:IsNPC() then
        colData.HitEntity:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 10, self.Owner)
    end
    ParticleEffect("ice_impact_heavy", pos, Angle(0,0,0), self.Owner)
    --ParticleEffect("ice_impact_swave", pos, Angle(0,0,0), self.Owner)
    sound.Play("horde/status/cold_explosion.ogg", pos, 80, math.random(70, 90))
    self:Detonate(pos)
end

function ENT:Draw()
    self:DrawModel()
end