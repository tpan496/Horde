AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/vj_base/projectiles/spit_acid_medium.mdl"} -- The models it should spawn with | Picks a random one from the table
-- ====== Shake World On Death Variables ====== --
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 4 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 500 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathDuration = 1 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 200 -- The frequency
-- ====== Radius Damage Variables ====== --
ENT.DoesRadiusDamage = false -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 250  -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamageUseRealisticRadius = false -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamage = 20  -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageType = DMG_ACID -- Damage type
ENT.RadiusDamageForce = 200 -- Put the force amount it should apply | false = Don't apply any force
ENT.RadiusDamageForce_Up = false -- How much up force should it have? | false = Let the base automatically decide the force using RadiusDamageForce value
ENT.RadiusDamageDisableVisibilityCheck = false -- Should it disable the visibility check? | true = Disables the visibility check
    -----------------------------------------------------
ENT.DecalTbl_DeathDecals = {"VJ_AcidSlime1"}
ENT.SoundTbl_Idle = {"vj_base/ambience/acid_idle.wav"}
ENT.SoundTbl_OnCollide = {"vj_base/ambience/acid_splat.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetNoDraw(true)
	self:DrawShadow(false)

	ParticleEffect("xen_host_spit_spawn", self:GetPos(), Angle(0,0,0), nil)
	ParticleEffectAttach("xen_host_spit", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
--[[
function ENT:DeathEffects(data, phys)
	ParticleEffect("xen_host_spit_impact", data.HitPos, Angle(0,0,0), nil)
end
]]

function ENT:CustomOnPhysicsCollide(data, phys)
    if self.Dead then return end
    self.Dead = true
    local dmg = DamageInfo()
    if self.Owner:IsValid() then
        dmg:SetAttacker(self.Owner)
    else
        dmg:SetAttacker(self)
    end
    dmg:SetInflictor(self)
    dmg:SetDamageType(self.RadiusDamageType)
    dmg:SetDamage(self.RadiusDamage)
    util.BlastDamageInfo(dmg, self:GetPos(), self.RadiusDamageRadius)
    
    self:Remove()
end
