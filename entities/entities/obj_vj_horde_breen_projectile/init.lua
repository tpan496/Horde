AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"effects/combineball.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 140 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 60 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BLAST -- Damage type
ENT.RadiusDamageForce = 90 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 16 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 3000 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathtDuration = 1 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 200 -- The frequency
ENT.SoundTbl_Idle = {"weapons/physcannon/energy_sing_flyby1.wav","weapons/physcannon/energy_sing_flyby2.wav"}
ENT.SoundTbl_OnCollide = {"weapons/physcannon/energy_sing_explosion2.wav"}

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/dav0r/hoverball.mdl")
	self:SetMaterial("models/props_combine/portalball001_sheet")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetMoveCollide(COLLISION_GROUP_PROJECTILE)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self:SetSolid(SOLID_CUSTOM)
	self:SetOwner(self:GetOwner())
	self:SetNoDraw(true)

	-- Physics Functions
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1)
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end

	-- Misc Functions
	//ParticleEffectAttach("smoke_burning_engine_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	//ParticleEffectAttach("fire_jet_01_flame", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	
	//self.Entity:Ignite( 120, 40 )
	self.StartGlow1 = ents.Create( "env_sprite" )
	self.StartGlow1:SetKeyValue( "rendercolor","255 255 255" )
	self.StartGlow1:SetKeyValue( "GlowProxySize","2.0" )
	self.StartGlow1:SetKeyValue( "HDRColorScale","1.0" )
	self.StartGlow1:SetKeyValue( "renderfx","14" )
	self.StartGlow1:SetKeyValue( "rendermode","3" )
	self.StartGlow1:SetKeyValue( "renderamt","255" )
	self.StartGlow1:SetKeyValue( "disablereceiveshadows","0" )
	self.StartGlow1:SetKeyValue( "mindxlevel","0" )
	self.StartGlow1:SetKeyValue( "maxdxlevel","0" )
	self.StartGlow1:SetKeyValue( "framerate","10.0" )
	self.StartGlow1:SetKeyValue( "model","sprites/blueflare1.spr" )
	self.StartGlow1:SetKeyValue( "spawnflags","0" )
	self.StartGlow1:SetKeyValue( "scale","0.75" )
	self.StartGlow1:SetPos( self.Entity:GetPos() )
	self.StartGlow1:Spawn()
	self.StartGlow1:SetParent( self.Entity )
	self:DeleteOnRemove(self.StartGlow1)

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

	timer.Simple(10, function ()
		if !IsValid(self) then return end
		self:Remove()
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	local effectdata = EffectData()
	effectdata:SetOrigin(data.HitPos)
	//effectdata:SetScale( 500 )
	util.Effect( "HelicopterMegaBomb", effectdata )
	util.Effect( "ThumperDust", effectdata )
	util.Effect( "Explosion", effectdata )
	util.Effect( "energy_explosion", effectdata )

	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "4")
	self.ExplosionLight1:SetKeyValue("distance", "300")
	self.ExplosionLight1:SetLocalPos(data.HitPos)
	self.ExplosionLight1:SetLocalAngles(self:GetAngles())
	self.ExplosionLight1:Fire("Color", "255 150 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)
end

function ENT:CustomOnPhysicsCollide(data, phys)
	self.Dead = true
	local dmg = DamageInfo()
	dmg:SetAttacker(self.Owner)
	dmg:SetInflictor(self)
	dmg:SetDamageType(DMG_BLAST)
	dmg:SetDamage(40)
	util.BlastDamageInfo(dmg, self:GetPos(), 150)
	dmg = DamageInfo()
	dmg:SetAttacker(self.Owner)
	dmg:SetInflictor(self)
	dmg:SetDamageType(DMG_RADIATION)
	dmg:SetDamage(40)
	util.BlastDamageInfo(dmg, self:GetPos(), 150)

	local self_pos = self:GetPos()
	if self.OwnerCritical then
		for i =0,10 do
            timer.Simple(0.5 + i * 0.2, function ()
                local rand = VectorRand()
                if rand.z < 0 then rand.z = -rand.z end
                local pos = self_pos + rand * math.Rand(10, 50)
                for _, e1 in pairs(ents.FindInSphere(pos, 150)) do
                    if (HORDE:IsPlayerOrMinion(e1) == true) then
                        local dmginfo = DamageInfo()
                        dmginfo:SetDamage(math.max(10, 0.1 * e1:GetMaxHealth()))
                        dmginfo:SetAttacker(Entity(0))
                        dmginfo:SetInflictor(Entity(0))
                        dmginfo:SetDamagePosition(pos)
                        dmginfo:SetDamageType(DMG_BLAST)
                        e1:TakeDamageInfo(dmginfo)
                    end
                end
                local e = EffectData()
                    e:SetOrigin(pos)
                util.Effect("explosion", e, true, true)
                --sound.Play("ambient/levels/canals/toxic_slime_sizzle2.wav", pos)
            end)
        end
    end
	self:OnCollideSoundCode()
	if self.PaintDecalOnDeath == true && VJ_PICK(self.DecalTbl_DeathDecals) != false && self.AlreadyPaintedDeathDecal == false then 
		self.AlreadyPaintedDeathDecal = true 
		util.Decal(VJ_PICK(self.DecalTbl_DeathDecals), data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
	end
	if self.ShakeWorldOnDeath == true then util.ScreenShake(data.HitPos, self.ShakeWorldOnDeathAmplitude, self.ShakeWorldOnDeathFrequency, 1, self.ShakeWorldOnDeathRadius) end
	self:SetDeathVariablesTrue(data, phys, true)
	if self.DelayedRemove > 0 then
		self:SetNoDraw(true)
		self:SetMoveType(MOVETYPE_NONE)
		self:AddSolidFlags(FSOLID_NOT_SOLID)
		self:SetLocalVelocity(Vector())
		SafeRemoveEntityDelayed(self, self.DelayedRemove)
		self:OnRemove()
	else
		self:Remove()
	end
	return false
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/