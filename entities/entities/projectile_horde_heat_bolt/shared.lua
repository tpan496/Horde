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
    self.HitEntitites = {}
    self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

function ENT:Detonate(hitpos, hitent)
    if !self:IsValid() or self.Removing then return end
    if self.HitEntitites[hitent] then return end
    self.HitEntitites[hitent] = true

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    if self.Inflictor:GetCurrentFiremode().Mode == 2 then
        self:FireBullets({
            Attacker = attacker,
            Inflictor = attacker,
            Damage = 300,
            Tracer = 0,
            Distance = 400,
            HullSize = 2,
            Dir = (hitpos - self:GetPos()),
            Src = self:GetPos(),
            Callback = function(att, tr, dmg)
                dmg:SetAttacker(attacker)
                dmg:SetInflictor(attacker)
    
                if tr.HitGroup == HITGROUP_HEAD then
                    sound.Play("weapons/crossbow/bolt_skewer1.wav", hitpos)
                    dmg:ScaleDamage(1.5)
                end
    
                util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
            end
        })
        self.Removing = true
        self:Remove()
    else
        if HORDE:IsEnemy(hitent) then
            local dmg = DamageInfo()
            dmg:SetDamage(300)
            dmg:SetAttacker(attacker)
            dmg:SetInflictor(attacker)
            dmg:SetDamagePosition(self:GetPos())
            dmg:SetDamageType(DMG_GENERIC)
            hitent:TakeDamageInfo(dmg)
        end
        self.Removing = true
        self:Remove()
    end
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    self:Detonate(colData.HitPos, colData.HitEntity)
end

end

function ENT:Draw()
    self:DrawModel()
end