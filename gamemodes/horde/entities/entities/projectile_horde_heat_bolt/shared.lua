ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "Heat Bolt"
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

if SERVER then

function ENT:Initialize()
    local pb_vert = 2
    local pb_hor = 2
    self:SetModel(self.Model)
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(false)
    end

    self.SpawnTime = CurTime()

    timer.Simple(0.1, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

function ENT:Detonate(hitpos)
    if !self:IsValid() or self.Removing then return end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    self:FireBullets({
        Attacker = attacker,
        Damage = 150,
        Tracer = 0,
        Distance = 20000,
        HullSize = 2,
        Dir = (hitpos - self:GetPos()),
        Src = self:GetPos(),
        Callback = function(att, tr, dmg)
            if self.Inflictor:GetCurrentFiremode().Mode == 2 then
                dmg:SetDamageType(DMG_BULLET)
            else
                dmg:SetDamageType(DMG_BURN)
            end
            
            dmg:SetAttacker(self.Owner)
            dmg:SetInflictor(self)

            if tr.HitGroup == HITGROUP_HEAD then
                sound.Play("weapons/crossbow/bolt_skewer1.wav", hitpos)
                dmg:ScaleDamage(1.5)
            end

            util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
        end
    })
    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    self:Detonate(colData.HitPos)
end

end

function ENT:Draw()
    self:DrawModel()
end