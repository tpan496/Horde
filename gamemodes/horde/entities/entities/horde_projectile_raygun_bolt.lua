AddCSLuaFile()

ENT.Base 				= "horde_explosive_projectile_base"
ENT.PrintName 			= "Raygun Bolt"
ENT.Model = "models/props_phx/gibs/flakgib1.mdl"
ENT.LifeTime = 10 -- Time to removal
ENT.ProjectileDamage = 200 -- Projectile/explosion damage
ENT.ProjectileDamageRadius = 125 -- Explosion radius
ENT.ArmDistance = 0.00001 -- Safety distance

ENT.ProjectileUnarmedDamageType = DMG_SHOCK -- Damage type when hitting something unarmed
ENT.ProjectileExplosionDamageType = DMG_SHOCK -- Explosion damage type
ENT.EnableGravity = false

ENT.Ticks = 0

ENT.RaygunEffect = "raygun_splash"
ENT.RaygunSound = "ArcCW_BO1.RayGun_Splash"

DEFINE_BASECLASS( ENT.Base )

if SERVER then
--copy over the base projectile code to get the laser trail / explosion effect aaa

    function ENT:Initialize()
        BaseClass.Initialize(self)
		self:CustomInitialize()
    self:SetModel(self.Model)
    self:PhysicsInitSphere(0.5)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        if !self.EnableGravity then
            phys:EnableGravity(false)
        end
    end

    self.SpawnTime = CurTime()

    self:SetCollisionGroup(COLLISION_GROUP_PLAYER_MOVEMENT)
    self.StartPos = self:GetPos()
    self.ArmDistanceSqr = self.ArmDistance * self.ArmDistance
--start laser trail
        if self:GetClass() == "horde_projectile_raygun_bolt" then
            util.SpriteTrail(self, 0, Color( 66 , 255 , 0 ), false, 3, 6, 0.1, 1, "effects/laser1.vmt")
        end
--end laser trail
    end

    function ENT:Detonate(data)
        if !self:IsValid() then return end
        if self.Defused then return end

		if !self:IsValid() or self.Removing then return end
    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    local nodetonate = self:CustomOnPreDetonate(data)
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

--start explosion effect
	local effectdata = EffectData()
    local dir = (self.HitVelocity or self:GetVelocity()):GetNormalized()
    local pos = (self.HitPos or self:GetPos()) - dir * 4
    effectdata:SetOrigin(pos)
    effectdata:SetNormal(dir)
    ParticleEffect(self.RaygunEffect, pos, Angle(0,0,0))
    self:EmitSound(self.RaygunSound)
--end explosion effect

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
    self.Removing = true
    self:Remove()

    end

end

function ENT:Draw()
    self:DrawModel()

    cam.Start3D()
        render.SetMaterial( Material("effects/blueflare1") )
        render.DrawSprite( self:GetPos(), math.random(30, 45), math.random(30, 45), Color(0, 255, 66) )
        render.SetMaterial( Material("particles/bo1/raygun_ring.vmt") )
        render.DrawSprite( self:GetPos(), 10, 10, Color(0, 255, 66) )
    cam.End3D()
end
