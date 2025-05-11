ENT.Base 				= "horde_explosive_projectile_base"
ENT.PrintName 			= "Incendiary Round"
ENT.Model = "models/items/ar2_grenade.mdl"
ENT.LifeTime = 10 -- Time to removal
ENT.ProjectileDamage = 230 -- Projectile/explosion damage
ENT.ProjectileDamageRadius = 200 -- Explosion radius
ENT.ArmDistance = 150 -- Safety distance
ENT.Decal = "Scorch"
ENT.ProjectileExplosionDamageType = DMG_SHOCK

ENT.Ticks = 0

AddCSLuaFile()



function ENT:CustomInitialize()
if SERVER then
	self:SetColor(Color(255,255,0))
end
end

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
        util.Effect( "horde_emp_grenade_explosion", effectdata)
        self:EmitSound("ambient/levels/labs/electric_explosion1.wav", 125, 100, 1, CHAN_AUTO)
    end
end

function ENT:Detonate(data)
    if !self:IsValid() or self.Removing then return end
    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    local nodetonate = self:CustomOnPreDetonate(data)
    local hitEnt = data.HitEntity
    if nodetonate then self:Remove() return end

    if (self.StartPos:DistToSqr(self:GetPos()) <= self.ArmDistanceSqr) or self.ProjectileSabotRound then
        if self.ProjectileSabotRound then
            self.ProjectileDamage = self.ProjectileDamage * 1.25
        end
        self:FireBullets({
            Attacker = self.Owner,
            Damage = self.ProjectileDamage * 0.85,
            Tracer = 0,
            Distance = 400,
            Dir = (data.HitPos - self:GetPos()),
            Src = self:GetPos(),
            Callback = function(att, tr, dmg)
                dmg:SetDamageType(self.ProjectileUnarmedDamageType)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)

                hook.Run("Horde_OnExplosiveProjectileHeadshot", self.Owner, dmg)
            end
        })
        self.Removing = true
        self:Remove()
        return
    end

    self:CustomOnExplode()

    if self.Horde_Armor_Piercing then
        self.ProjectileDamage = self.ProjectileDamage * 1.15
        self.ProjectileDamageRadius = self.ProjectileDamageRadius * 0.7
    end

    self:FireBullets({
		Attacker = self.Owner,
		Damage = 0,
		Tracer = 0,
		Distance = 400,
		Dir = (data.HitPos - self:GetPos()),
		Src = self:GetPos(),
		Callback = function(att, tr, dmg)
			if tr.HitGroup == HITGROUP_HEAD then
				dmg:SetDamageType(self.ProjectileExplosionDamageType)
				dmg:SetAttacker(self.Owner)
				dmg:SetInflictor(self)
				dmg:SetDamage(self.ProjectileDamage / 2)
                hook.Run("Horde_OnExplosiveProjectileHeadshot", self.Owner, dmg)
			end

            if self.Decal then
                util.Decal(self.Decal, tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
            end
		end
	})
    local dmg2 = DamageInfo()
    dmg2:SetDamageType(self.ProjectileExplosionDamageType)
    dmg2:SetAttacker(attacker)
    dmg2:SetInflictor(self)
    dmg2:SetDamage(self.ProjectileDamage)
    util.BlastDamageInfo(dmg2, self:GetPos(), self.ProjectileDamageRadius)
    hook.Run("Horde_PostExplosiveProjectileExplosion", self.Owner, self, dmg2, self.ProjectileDamageRadius)
    hitEnt:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg2:GetDamage() * 0.75, attacker, dmg2:GetDamagePosition())
    self.Removing = true
    self:Remove()
end
