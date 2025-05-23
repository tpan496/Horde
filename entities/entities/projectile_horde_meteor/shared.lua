ENT.Type 				= "anim"
ENT.Base 				= "projectile_horde_spell_base"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

--ENT.Model = "models/props_lab/bigrock.mdl"
ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Models = {"models/props_wasteland/rockgranite03b.mdl"}
ENT.Ticks = 0
ENT.FuseTime = 5
ENT.CollisionGroup = COLLISION_GROUP_PLAYER
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER
ENT.Removing = nil

if SERVER then

function ENT:CustomOnInitialize()
    --self:SetModel(self.Models[math.random(#self.Models)])
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
    self:DrawShadow( false )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:SetBuoyancyRatio(0)
        phys:EnableDrag(false)
        phys:SetMass(1)
        phys:EnableGravity(false)
    end
    
    self:SetModel(self.Models[math.random(#self.Models)])
    local a = Angle(0,0,0)
    a:Random()
    self:SetAngles(a)
    
    local ply = self:GetOwner()
    timer.Simple(0, function ()
        if not self:IsValid() then return end
        if self:GetCharged() >= 2 then
            self:Ignite(999)
            if self:GetCharged() == 2 then
                HORDE:SimpleParticleSystem("vj_rocket_idle1", self:GetPos(), ply:EyeAngles(), self)
            else
                HORDE:SimpleParticleSystem("vj_rocket_idle2", self:GetPos(), ply:EyeAngles(), self)
            end
        end
    end)

    self.SpawnTime = CurTime()
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
        smoke:SetColor( 20, 20, 20 )
        smoke:SetAirResistance( 5 )
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( false )
        emitter:Finish()
    end

    self.Ticks = self.Ticks + 1
end

end

local function Shrapnel_Effect(hitpos)
    for i = 1, math.random(5,10) do
		local debris = ents.Create("base_gmodentity")
		
		debris:SetPos(hitpos)
		debris:SetAngles(VectorRand():Angle())
		debris:SetModel("models/props_junk/rock001a.mdl")
		debris:PhysicsInit(SOLID_VPHYSICS)
        debris:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        --[[
        if self:GetCharged() == 3 then
            debris:Ignite(999)
        end
        ]]
		
		local physobj = debris:GetPhysicsObject()
		local force = 1000
		
		physobj:AddVelocity(Vector(math.random(-force, force), math.random(-force, force), math.random(-force, force)))
		physobj:AddAngleVelocity(Vector(math.random(-force, force), math.random(-force, force), math.random(-force, force)))
		
		timer.Simple(3, function()
			if IsValid(debris) then
				local effect = EffectData()
				local debrisPos = debris:GetPos()
				effect:SetStart(debrisPos)
				effect:SetOrigin(debrisPos)
				effect:SetEntity(debris)
				util.Effect("entity_remove", effect)
				debris:Remove()
			end
		end)
    end
end

function ENT:Detonate()
    if !self:IsValid() then return end
    self:EmitSound("horde/spells/meteor_explode.ogg", 125, 100, 1, CHAN_AUTO)

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end
    --[[
    local dmg = DamageInfo()
	dmg:SetAttacker(self.Owner)
	dmg:SetInflictor(self)
	dmg:SetDamageType(DMG_CLUB)
	dmg:SetDamage(self:GetSpellBaseDamage(1) * (1 + 0.5 * (self:GetCharged() - 1)))
	util.BlastDamageInfo(dmg, self:GetPos(), 200)

    if self:GetCharged() == 3 then
        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())
        effectdata:SetScale(2)
        util.Effect("horde_blaster_flame_explosion", effectdata, true ,true)

        local d2 = DamageInfo()
        d2:SetAttacker(self.Owner)
        d2:SetInflictor(self)
        d2:SetDamageType(DMG_BLAST)
        d2:SetDamage(self:GetSpellBaseDamage(1) / 1.5)
        util.BlastDamageInfo(d2, self:GetPos(), 200)
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
    ]]
    
    local spell_dmg = self:GetSpellBaseDamage(1) * (1 + 0.5 * (self:GetCharged() - 1))
    HORDE.RadiusDamageExtra({
        attacker = attacker,
        inflictor = self,
        radius = 200,
        falloffradius = 100,
        falloff_cap = 0,
        damage = spell_dmg,
        basedamagemul = 0,
        fallofftype = "linear",
        falloff_speed = 1,
        ignoreattacker = false,
        origin = self:GetPos(),
        damagetype = DMG_BLAST,
        --damagecustomtype = HORDE.DMG_SPLASH,
        --antishotgun = true,
    })

    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end
    local spell_dmg = self:GetSpellBaseDamage(1) * (1 + 0.5 * (self:GetCharged() - 1))
    self:FireBullets({
		Attacker = attacker,
		Damage = spell_dmg,
		Tracer = 0,
		Distance = 400,
		Dir = (colData.HitPos - self:GetPos()),
		Src = self:GetPos(),
		Callback = function(att, tr, dmg)
			--if tr.HitGroup == HITGROUP_HEAD then
				dmg:SetDamageType(DMG_CLUB)
				dmg:SetAttacker(attacker)
				dmg:SetInflictor(self)
				--dmg:SetDamage(spell_dmg)
                --hook.Run("Horde_OnExplosiveProjectileHeadshot", attacker, dmg)
			--end
            util.Decal("Scorch", tr.StartPos, tr.HitPos - (tr.HitNormal * 16), self)
		end
	})
    
    Shrapnel_Effect(colData.HitPos)
    
    self.Removing = true
    self:Detonate()
end

function ENT:Draw()
    self:DrawModel()
end