ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.Model = "models/dav0r/hoverball.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PASSABLE_DOOR
ENT.CollisionGroupType = COLLISION_GROUP_PASSABLE_DOOR
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0
ENT.BaseDamage = 25
ENT.BaseSplashDamage = 10
ENT.DirectDamage = 60 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_CRUSH -- Damage type

function ENT:Draw()
	self:DrawModel()
	self:SetAngles((LocalPlayer():EyePos() - self:GetPos()):Angle())
end

if !SERVER then return end

function ENT:Initialize()
	--self:SetModel("models/dav0r/hoverball.mdl")
	self:SetMaterial("models/props_combine/portalball001_sheet")

	self.StartGlow1 = ents.Create( "env_sprite" )
	self.StartGlow1:SetKeyValue( "rendercolor","255 165 0" )
	self.StartGlow1:SetKeyValue( "GlowProxySize","2.0" )
	self.StartGlow1:SetKeyValue( "HDRColorScale","1.0" )
	self.StartGlow1:SetKeyValue( "renderfx","14" )
	self.StartGlow1:SetKeyValue( "rendermode","3" )
	self.StartGlow1:SetKeyValue( "renderamt","255" )
	self.StartGlow1:SetKeyValue( "disablereceiveshadows","0" )
	self.StartGlow1:SetKeyValue( "mindxlevel","0" )
	self.StartGlow1:SetKeyValue( "maxdxlevel","0" )
	self.StartGlow1:SetKeyValue( "framerate","10.0" )
	self.StartGlow1:SetKeyValue( "model","sprites/orangeflare1.spr" )
	self.StartGlow1:SetKeyValue( "spawnflags","0" )
	self.StartGlow1:SetKeyValue( "scale","0.25" )
	self.StartGlow1:SetPos( self.Entity:GetPos() )
	self.StartGlow1:Spawn()
	self.StartGlow1:SetParent( self.Entity )
	self:DeleteOnRemove(self.StartGlow1)

	self.StartLight1 = ents.Create("light_dynamic")
	self.StartLight1:SetKeyValue("brightness", "1")
	self.StartLight1:SetKeyValue("distance", "200")
	self.StartLight1:SetLocalPos(self:GetPos())
	self.StartLight1:SetLocalAngles( self:GetAngles() )
	self.StartLight1:Fire("Color", "255 255 255")
	self.StartLight1:SetParent(self)
	self.StartLight1:Spawn()
	self.StartLight1:Activate()
	self.StartLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.StartLight1)
	self:SetModelScale(0.5)
    self:PhysicsInitSphere(1, "metal_bouncy")
	construct.SetPhysProp(self:GetOwner(), self, 0, self:GetPhysicsObject(), {GravityToggle = false, Material = "metal_bouncy"})
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:SetMass(1)
        phys:SetBuoyancyRatio(0)
        phys:EnableDrag(false)
        phys:EnableGravity(false)
    end

    timer.Simple(2, function() if IsValid(self) then self:DeathEffects() end end)

	self:DrawShadow(false)
	self:ResetSequence("idle")

	--util.SpriteTrail(self, 0, colorWhite, true, 15, 0, 0.1, 1 / 6 * 0.5, "sprites/combineball_trail_black_1.vmt")
end

function ENT:SetCoreType(capture)
	if capture then
		self:SetSubMaterial(0, "models/effects/comball_glow1")
	else
		self:SetSubMaterial(0, "vj_base/effects/comball_glow2")
	end
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Charged" )
end

function ENT:PhysicsCollide(data, phys)
	local owner = self:GetOwner()
	local hitEnt = data.HitEntity
	if IsValid(owner) then
		local dmg = DamageInfo()
		dmg:SetDamageType(DMG_BURN)
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self)
		dmg:SetDamage(50)
		dmg:SetDamagePosition(self:GetPos())
		

		self:FireBullets({
			Attacker = owner,
			Inflitor = self,
			Damage = 50,
			Tracer = 0,
			Distance = 4000,
			Dir = data.HitPos - self:GetPos(),
			Src = self:GetPos(),
			Callback = function(att, tr, dmginfo)
				dmginfo:SetDamageType(DMG_BURN)

				if (not tr.Entity:IsValid()) or (not tr.Entity:IsNPC()) then
					hitEnt:TakeDamageInfo(dmg)
				end
			end
		})
    end

	--local dataF = EffectData()
	--dataF:SetOrigin(data.HitPos)
	--util.Effect("cball_bounce", dataF)

	dataF = EffectData()
	dataF:SetOrigin(data.HitPos)
	dataF:SetNormal(data.HitNormal)
	dataF:SetScale(50)
	util.Effect("AR2Impact", dataF)

	self:Remove()
end

local color1 = Color(255, 255, 225, 32)
local color2 = Color(255, 255, 225, 64)
--
function ENT:DeathEffects(data, phys)
	self:Remove()
	return
	--[[local myPos = self:GetPos()
	effects.BeamRingPoint(myPos, 0.2, 12, 1024, 64, 0, color1, {material="sprites/lgtning.vmt", framerate=2, flags=0, speed=0, delay=0, spread=0})
	effects.BeamRingPoint(myPos, 0.5, 12, 1024, 64, 0, color2, {material="sprites/lgtning.vmt", framerate=2, flags=0, speed=0, delay=0, spread=0})

	local effectData = EffectData()
	effectData:SetOrigin(myPos)
	util.Effect("cball_explode", effectData)

	VJ_EmitSound(self, "weapons/physcannon/energy_sing_explosion2.wav", 150)
	util.ScreenShake(myPos, 20, 150, 1, 1250)
	util.VJ_SphereDamage(self, self, myPos, 400, 25, bit.bor(DMG_SONIC, DMG_BLAST), true, true, {DisableVisibilityCheck=true, Force=80})

	self:Remove()]]--
end

function ENT:Draw()
    self:DrawModel()
end