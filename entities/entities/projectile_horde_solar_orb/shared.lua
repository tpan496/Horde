ENT.Type 				= "anim"
ENT.Base 				= "projectile_horde_spell_base"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:LSS(pos, radius)
    if CLIENT then return end
    local LT = ents.Create("info_target")
    LT:SetKeyValue("targetname","solar_orb_target_" .. LT:EntIndex())
    LT:SetPos(pos)
    LT:Fire("kill","",0.5)
    LT:Spawn()
    local idx = LT:EntIndex()
    timer.Simple(0.1, function ()
        for i = 1,10 do
            local LA = ents.Create("env_laser")
            LA:SetKeyValue("lasertarget", "solar_orb_target_" .. idx)
            LA:SetKeyValue("rendercolor", "200 50 0")
            LA:SetKeyValue("texture", "sprites/laserbeam.spr")
            LA:SetKeyValue("dissolvetype", "1")
            LA:SetKeyValue("width", "2")
            LA:SetKeyValue("damage", "0")
            --LA:SetKeyValue("spawnflags", "32")
            LA:SetKeyValue("noiseamplitude", "10")
            LA:SetOwner(self)
            LA:Spawn()
            LA:Fire("Kill","",0.25)
            local p = VectorRand() * radius
            --p.z = 0
            LA:SetPos(pos + p)
        end
    end)
end

function ENT:CustomOnInitialize()
    if SERVER then
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(true)
        phys:SetMass(1)
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    
    self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    self.ExplodeTimer = CurTime() + 0.4

    if self:GetCharged() == 1 then
        self.ExplodeTimer = self.ExplodeTimer + 0.5
    elseif self:GetCharged() == 2 then
        self.ExplodeTimer = self.ExplodeTimer + 0.6
    elseif self:GetCharged() >= 3 then
        self.ExplodeTimer = self.ExplodeTimer + 0.7
    end

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime()
    end

    if CLIENT then
    timer.Simple(0, function ()
        if not self:IsValid() then return end
        local charged = self:GetCharged()
        if charged >= 3 then
            if charged == 4 then
                ParticleEffectAttach("dark_orb_charged_1", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            elseif charged == 5 then
                ParticleEffectAttach("dark_orb_charged_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            elseif charged == 3 then
                ParticleEffectAttach("dark_orb", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            end
            return
        end
        ParticleEffectAttach("solar_orb", PATTACH_ABSORIGIN_FOLLOW, self, 0)
        if charged >= 1 then
            ParticleEffectAttach("solar_orb_charged_1", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            if charged >= 2 then
                ParticleEffectAttach("solar_orb_charged_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            end
        end
    end)
    end
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end
    if SERVER and self.ExplodeTimer <= CurTime() then
        if self:GetCharged() >= 1 then
            local dmg_mult = 1
            local radius_mult = 0.75
            if self:GetCharged() == 1 then
                dmg_mult = 1.5
                radius_mult = 1
            elseif self:GetCharged() == 2 then
                dmg_mult = 2
                radius_mult = 1.5
            end
            local dmg_splash = DamageInfo()
            dmg_splash:SetAttacker(self.Owner)
            dmg_splash:SetInflictor(self)
            dmg_splash:SetDamageType(DMG_BURN)
            dmg_splash:SetDamage(self:GetSpellBaseDamage(2) * dmg_mult)
            dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
            util.BlastDamageInfo(dmg_splash, self:GetPos(), 150 * radius_mult)

            ParticleEffect("solar_orb_explode", self:GetPos(), Angle(0,0,0), self.Owner)
            sound.Play("horde/weapons/solar_seal/solar_orb_hit.ogg", self:GetPos(), 80, math.random(70, 90))
        end
        self:Remove()
    end
end

function ENT:Detonate(hitpos, ent)
    if !self:IsValid() or self.Removing then return end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    local dmg_mult = 1
    local dmg_mult_direct = 1
    local radius_mult = 0.75
    if self:GetCharged() == 1 then
        dmg_mult = 1.5
        radius_mult = 1
    elseif self:GetCharged() == 2 then
        dmg_mult = 2
        radius_mult = 1.5
    elseif self:GetCharged() >= 3 then
        dmg_mult = 2
        radius_mult = 1.5
        dmg_mult_direct = 1.5
    end

    self:FireBullets({
        Attacker = attacker,
        Damage = self:GetSpellBaseDamage(1) * dmg_mult * dmg_mult_direct,
        Tracer = 0,
        Distance = 4000,
        Dir = (hitpos - self:GetPos()),
        Src = self:GetPos(),
        Callback = function(att, tr, dmg)
            dmg:SetDamageType(DMG_BURN)
            dmg:SetAttacker(self.Owner)
            dmg:SetInflictor(self)

            if self:GetCharged() >= 3 then
                if self:GetCharged() == 3 then
                    if HORDE:IsEnemy(tr.Entity) then
                        tr.Entity:TakeDamageOverTime(self.Owner, self:GetSpellBaseDamage(1) / 8, DMG_GENERIC, 0.2, 1)
                    end
                    
                elseif self:GetCharged() == 4 then
                    for _, e in pairs(ents.FindInSphere(hitpos, 150 * 1.25 * radius_mult)) do
                        e:TakeDamageOverTime(self.Owner, self:GetSpellBaseDamage(1) / 6, DMG_GENERIC, 0.2, 1)
                    end
                elseif self:GetCharged() == 5 then
                    for _, e in pairs(ents.FindInSphere(hitpos, 150 * 1.25 * radius_mult)) do
                        e:TakeDamageOverTime(self.Owner, self:GetSpellBaseDamage(1) / 4, DMG_GENERIC, 0.2, 1)
                    end
                end
            end

            if self.Draconic == true then
                local dmg_splash = DamageInfo()
                dmg_splash:SetAttacker(self.Owner)
                dmg_splash:SetInflictor(tr.Entity)
                dmg_splash:SetDamageType(DMG_SHOCK)
                dmg_splash:SetDamage(self:GetSpellBaseDamage(2) * dmg_mult)
                dmg_splash:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
                util.BlastDamageInfo(dmg_splash, self:GetPos(), 150 * 1.25 * radius_mult)
            else
                local dmg_splash = DamageInfo()
                dmg_splash:SetAttacker(self.Owner)
                dmg_splash:SetInflictor(tr.Entity)
                dmg_splash:SetDamageType(DMG_BURN)
                dmg_splash:SetDamage(self:GetSpellBaseDamage(2) * dmg_mult)
                dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
                util.BlastDamageInfo(dmg_splash, self:GetPos(), 150 * 1.25 * radius_mult)
            end
        end
    })

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local pos = colData.HitPos

    if self:GetCharged() == 0 then
        if self.Draconic == true then
            self:LSS(self:GetPos(), 75)
        else
            ParticleEffect("solar_orb_explode", pos, Angle(0,0,0), self.Owner)
        end
        
        sound.Play("horde/weapons/solar_seal/solar_orb_hit.ogg", pos, 80, math.random(70, 90))
    elseif self:GetCharged() == 1 then
        sound.Play("horde/weapons/solar_seal/solar_orb_charged_1_hit.ogg", pos, 100, math.random(90, 110))
        if self.Draconic == true then
            self:LSS(self:GetPos(), 100)
        else
            ParticleEffect("solar_orb_charged_1_explode", pos, Angle(0,0,0), self.Owner)
        end
    elseif self:GetCharged() == 2 then
        if self.Draconic == true then
            self:LSS(self:GetPos(), 150)
        else
            ParticleEffect("solar_orb_charged_2_explode", pos, Angle(0,0,0), self.Owner)
        end
        
        sound.Play("horde/weapons/solar_seal/solar_orb_charged_2_hit.ogg", pos, 100, math.random(90, 110))
    elseif self:GetCharged() >= 3 then
        if self:GetCharged() == 3 then
            ParticleEffect("dark_orb_explode", pos, Angle(0,0,0), self.Owner)
            sound.Play("horde/weapons/solar_seal/solar_orb_hit.ogg", pos, 80, math.random(70, 90))
        elseif self:GetCharged() == 4 then
            ParticleEffect("dark_orb_explode_charged", pos, Angle(0,0,0), self.Owner)
            sound.Play("horde/weapons/solar_seal/dark_orb_hit.ogg", pos, 100, math.random(90, 110))
        elseif self:GetCharged() == 5 then
            ParticleEffect("dark_orb_explode_charged_2", pos, Angle(0,0,0), self.Owner)
            sound.Play("horde/weapons/solar_seal/dark_orb_hit.ogg", pos, 100, math.random(60, 80))
        end
    end

    self:Detonate(pos, colData.HitEntity)

    if self:GetCharged() == 2 then
        local cloud = ents.Create("horde_solar_orb_fire")
        cloud.BaseDamage = self:GetSpellBaseDamage(1)
        cloud:SetRadiusScale(1)

        if !IsValid(cloud) then return end

        local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500

        cloud:SetPos(self:GetPos() - (self:GetVelocity() * FrameTime()))
        cloud:SetAbsVelocity(vel + self:GetVelocity())
        cloud:SetOwner(self:GetOwner())
        cloud:Spawn()
    end
end

function ENT:Draw()
    self:DrawModel()
end