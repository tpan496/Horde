
ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "Explosive Projectile"
ENT.Author 				= "Gorlami"
ENT.Information 		= "An explosive projectile is an entity that has physical collision and creates an explosion on impact. "
ENT.Spawnable 			= false

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil

ENT.LifeTime = 10 -- Time to removal
ENT.EnableGravity = true
ENT.ProjectileDamage = 0 -- Projectile/explosion damage
ENT.ProjectileUnarmedDamageType = DMG_CLUB -- Damage type when hitting something unarmed
ENT.ProjectileExplosionDamageType = DMG_BLAST -- Explosion damage type
ENT.ProjectileDamageRadius = 0 -- Explosion radius
ENT.ArmDistance = 150 -- Safety distance
ENT.Decal = "Scorch"
AddCSLuaFile()


function ENT:CustomInitialize()
    return
end


if SERVER then

function ENT:Initialize()
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

    self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    self.StartPos = self:GetPos()
    self.ArmDistanceSqr = self.ArmDistance * self.ArmDistance
end

else
function ENT:Initialize()
    self:CustomInitialize()
end
end

function ENT:CustomOnThink()
    return
end

function ENT:Think()
    self:CustomOnThink()

    if SERVER and CurTime() - self.SpawnTime >= self.LifeTime then
        self:Remove()
    end
end

function ENT:CustomOnExplode()
    return
end

function ENT:Detonate(data)
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

function ENT:CustomOnPreDetonate()
    return
end

function ENT:PhysicsCollide(colData, collider)
    self:Detonate(colData)
end

function ENT:Draw()
    self:DrawModel()
end