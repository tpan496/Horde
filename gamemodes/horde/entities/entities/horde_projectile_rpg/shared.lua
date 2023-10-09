ENT.Base 				= "horde_explosive_projectile_base"
ENT.PrintName 			= "RPG Round"
ENT.Model = "models/weapons/w_missile_launch.mdl"
ENT.LifeTime = 10 -- Time to removal
ENT.EnableGravity = false
ENT.ProjectileDamage = 750 -- Projectile/explosion damage
ENT.ProjectileUnarmedDamageType = DMG_CLUB -- Damage type when hitting something unarmed
ENT.ProjectileExplosionDamageType = DMG_BLAST -- Explosion damage type
ENT.ProjectileDamageRadius = 250 -- Explosion radius
ENT.ArmDistance = 150 -- Safety distance
ENT.Decal = "Scorch"

ENT.Ticks = 0

AddCSLuaFile()

function ENT:CustomInitialize()
    if CLIENT then
    	ParticleEffectAttach("vj_rpg1_fulltrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		ParticleEffectAttach("vj_rpg2_fulltrail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		return
	end
	self.StartLight1 = ents.Create("light_dynamic")
	self.StartLight1:SetKeyValue("brightness", "1")
	self.StartLight1:SetKeyValue("distance", "200")
	self.StartLight1:SetLocalPos(self:GetPos())
	self.StartLight1:SetLocalAngles( self:GetAngles() )
	self.StartLight1:Fire("Color", "255 150 0")
	self.StartLight1:SetParent(self)
	self.StartLight1:Spawn()
	self.StartLight1:Activate()
	self.StartLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.StartLight1)
end

function ENT:CustomOnExplode()
    ParticleEffect("vj_explosion2", self:GetPos(), Angle(0,0,0), nil)
	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "4")
	expLight:SetKeyValue("distance", "300")
	expLight:SetLocalPos(self:GetPos())
	expLight:SetLocalAngles(self:GetAngles())
	expLight:Fire("Color", "255 150 0")
	expLight:SetParent(self)
	expLight:Spawn()
	expLight:Activate()
	expLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(expLight)

    util.ScreenShake(self:GetPos(), 16, 200, 1, 2000)
end