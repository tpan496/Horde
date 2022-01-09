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

if SERVER then

function ENT:Initialize()
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.SpawnTime = CurTime()

    timer.Simple(0.1, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)

    ParticleEffectAttach("ice_tracer_smoke", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

else

function ENT:Think()
    if self.Ticks % 5 == 0 then
        local emitter = ParticleEmitter(self:GetPos())

        if !self:IsValid() or self:WaterLevel() > 2 then return end
        if !IsValid(emitter) then return end

        local smoke = emitter:Add("particle/particle_smokegrenade", self:GetPos())
        smoke:SetVelocity( VectorRand() * 25 )
        smoke:SetGravity( Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-20, -25)) )
        smoke:SetDieTime( math.Rand(1.5, 2.0) )
        smoke:SetStartAlpha( 255 )
        smoke:SetEndAlpha( 0 )
        smoke:SetStartSize( 0 )
        smoke:SetEndSize( 100 )
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor( 173, 216, 230 )
        smoke:SetAirResistance( 5 )
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( false )
        emitter:Finish()
    end

    self.Ticks = self.Ticks + 1
end

end

function ENT:Detonate()
    if !self:IsValid() or self.Removing then return end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    self:FireBullets({
        Attacker = attacker,
        Damage = 0,
        Tracer = 0,
        Distance = 20000,
        Dir = self:GetVelocity(),
        Src = self:GetPos(),
        Callback = function(att, tr, dmg)
            util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
        end
    })
    
    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local pos = colData.HitPos
    local dmg = DamageInfo()
    dmg:SetAttacker(self.Owner)
    dmg:SetInflictor(self)
    dmg:SetDamageType(DMG_REMOVENORAGDOLL)
    dmg:SetDamage(150)
    dmg:SetDamagePosition(self:GetPos())
    util.BlastDamageInfo(dmg, pos, 200)
    if colData.HitEntity:IsNPC() then
        colData.HitEntity:Horde_AddFrostbite(5, 1)
    end
    ParticleEffect("cryo_explosion_large", pos, Angle(0,0,0), self.Owner)
    sound.Play("horde/status/cold_explosion.ogg", pos, 80, math.random(70, 90))
    self:Detonate()
end

function ENT:Draw()
    self:DrawModel()
end