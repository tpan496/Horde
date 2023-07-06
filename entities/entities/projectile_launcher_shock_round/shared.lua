ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.FuseTime = 10
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil

if SERVER then

function ENT:Initialize()
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 24)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.SpawnTime = CurTime()
    self.NextTick = self.SpawnTime + 0.1

    timer.Simple(0.1, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)
end

function ENT:Attack()
    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect("StunstickImpact", effectdata)
    self:EmitSound("weapons/stunstick/stunstick_impact1.wav", 125, 100, 1, CHAN_AUTO)

    local dmg = DamageInfo()
	dmg:SetAttacker(self.Owner)
	dmg:SetInflictor(self)
	dmg:SetDamageType(DMG_SHOCK)
	dmg:SetDamage(125)
	util.BlastDamageInfo(dmg, self:GetPos(), 150)
end

function ENT:Think()
    if CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
        self:FireBullets({
            Attacker = self.Owner,
            Damage = 0,
            Tracer = 0,
            Distance = 20000,
            Dir = self:GetVelocity(),
            Src = self:GetPos(),
            Callback = function(att, tr, dmg)
                util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
            end
        })
    end
end

else

function ENT:Think()
end

end

function ENT:Detonate()
    if !self:IsValid() or self.Removing then return end
    self:Attack()
    self.Removing = true
    self:Remove()
end

function ENT:StartTouch(ent)
    if SERVER then
        if ent:IsNPC() then
            self:Attack()
        end
    end
end

function ENT:PhysicsCollide(colData, collider)
    self:Detonate()
end

function ENT:Draw()
    self:DrawModel()
end