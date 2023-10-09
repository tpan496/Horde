ENT.Base 				= "horde_explosive_projectile_base"
ENT.PrintName 			= "HE Round"
ENT.Model = "models/items/ar2_grenade.mdl"
ENT.LifeTime = 10 -- Time to removal
ENT.ProjectileDamage = 230 -- Projectile/explosion damage
ENT.ProjectileDamageRadius = 200 -- Explosion radius
ENT.ArmDistance = 150 -- Safety distance
ENT.Decal = "Scorch"

ENT.Ticks = 0

AddCSLuaFile()
function ENT:CustomOnThink()
    if CLIENT and self.Ticks % 5 == 0 then
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
        smoke:SetColor( 20, 20, 20 )
        smoke:SetAirResistance( 5 )
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( false )
        emitter:Finish()
    end

    self.Ticks = self.Ticks + 1
end

function ENT:CustomOnExplode()
    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )

    if self:WaterLevel() >= 1 then
        util.Effect( "WaterSurfaceExplosion", effectdata )
        self:EmitSound("weapons/underwater_explode3.wav", 125, 100, 1, CHAN_AUTO)
    else
        util.Effect( "Explosion", effectdata)
        self:EmitSound("phx/kaboom.wav", 125, 100, 1, CHAN_AUTO)
    end
end