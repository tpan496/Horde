ENT.Type 				= "anim"
ENT.Base 				= "projectile_horde_spell_base"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/crossbow_bolt.mdl"
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
        phys:EnableGravity(false)
        phys:SetMass(1)
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    
    self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    self.ExplodeTimer = CurTime() + 0.4

    if self:GetCharged() == 1 then
        self.ExplodeTimer = self.ExplodeTimer + 0.3
    elseif self:GetCharged() == 2 then
        self.ExplodeTimer = self.ExplodeTimer + 0.6
    end

    if self.VoidCascade == true then
        self.ExplodeTimer = CurTime() + 5
        self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    end
    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime()
    end

    ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
    if CLIENT then
    timer.Simple(0.1, function ()
        if not self:IsValid() then return end
        local charged = self:GetCharged()
        if charged >= 1 then
            ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            if charged >= 2 then
                ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
                ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
                ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
                ParticleEffectAttach("snowcore_small", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            end
        end
    end)
    end
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Charged" )
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self:EmitSound("weapons/physcannon/energy_bounce2.wav", 100, 50)
        if self.VoidCascade then
            self.PlaySoundTimer = CurTime() + 0.25
            local dmg_mult = 1
            --[[if self.properties.siphon == true then
                dmg_mult = dmg_mult * (1 + 0.25 * self.properties.energy / 100)
            end

            if self.properties.field == true then
                dmg_mult = dmg_mult * math.max(1, (1 + math.max(0, (CurTime() - self.StartTime))))
            end]]--

            local e = EffectData()
            e:SetOrigin(self:GetPos())
            e:SetNormal(Vector(0,0,1))
            e:SetScale(0.6)
            util.Effect("cold_explosion", e, true, true)

            local dmg_splash = DamageInfo()
            dmg_splash:SetAttacker(self.Owner)
            dmg_splash:SetInflictor(self)
            dmg_splash:SetDamageType(DMG_REMOVENORAGDOLL)
            dmg_splash:SetDamage(self:GetSpellBaseDamage(1) * dmg_mult)
            dmg_splash:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
            util.BlastDamageInfo(dmg_splash, self:GetPos(), 150)
        else
            self.PlaySoundTimer = CurTime() + 0.1
        end
    end
    if SERVER and self.ExplodeTimer <= CurTime() then
        self:Remove()
    end
end

function ENT:Detonate(hitpos, ent)
    if !self:IsValid() or self.Removing then return end
    if self.VoidCascade == true then return end
    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    local dmg_mult = 1
    local radius_mult = 0.75
    if self:GetCharged() == 1 then
        dmg_mult = 1.5
        radius_mult = 1
    elseif self:GetCharged() == 2 then
        dmg_mult = 2
        radius_mult = 1.5
    end

    --[[if self.properties.field == true then
        dmg_mult = dmg_mult * math.max(1, (1 + math.max(0, (CurTime() - self.StartTime))))
    end

    if self.properties.siphon == true then
        dmg_mult = dmg_mult * (1 + 0.25 * self.properties.energy / 100)
    end]]--

    --[[if self.properties.sphere ~= true then
        self:FireBullets({
            Attacker = attacker,
            Damage = self:GetSpellBaseDamage(1) * dmg_mult,
            Tracer = 0,
            Distance = 4000,
            Dir = (hitpos - self:GetPos()),
            Src = self:GetPos(),
            Callback = function(att, tr, dmg)
                dmg:SetDamageType(DMG_REMOVENORAGDOLL)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)

                if (not tr.Entity:IsValid()) or (not tr.Entity:IsNPC()) then
                    if ent:IsNPC() then
                        ent:TakeDamageInfo(dmg)
                        ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmg:GetDamage()/2, self.Owner)
                    end
                else
                    tr.Entity:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmg:GetDamage()/2, self.Owner)
                end

                if self:GetCharged() >= 1 then
                    local dmg_splash = DamageInfo()
                    dmg_splash:SetAttacker(self.Owner)
                    dmg_splash:SetInflictor(tr.Entity)
                    dmg_splash:SetDamageType(DMG_REMOVENORAGDOLL)
                    dmg_splash:SetDamage(self:GetSpellBaseDamage(2) * dmg_mult)
                    dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
                    util.BlastDamageInfo(dmg_splash, self:GetPos(), 150 * radius_mult)
                end
            end
        })
    else]]--
        self:FireBullets({
            Attacker = attacker,
            Damage = self:GetSpellBaseDamage(1) * dmg_mult,
            Tracer = 0,
            Distance = 4000,
            Dir = (hitpos - self:GetPos()),
            Src = self:GetPos(),
            Callback = function(att, tr, dmg)
                dmg:SetDamageType(DMG_REMOVENORAGDOLL)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)

                if (not tr.Entity:IsValid()) or (not tr.Entity:IsNPC()) then
                    if ent:IsNPC() then
                        ent:TakeDamageInfo(dmg)
                    end
                else
                end

                local dmg_splash = DamageInfo()
                dmg_splash:SetAttacker(self.Owner)
                dmg_splash:SetInflictor(tr.Entity)
                dmg_splash:SetDamageType(DMG_REMOVENORAGDOLL)
                dmg_splash:SetDamage(self:GetSpellBaseDamage(2) * dmg_mult)
                dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
                util.BlastDamageInfo(dmg_splash, self:GetPos(), 150 * radius_mult)
            end
        })
    --end

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local pos = colData.HitPos
    --[[if self.properties.field == true then
        if colData.HitEntity:IsNPC() then
            local buildup_mult = 1
            if self:GetCharged() == 1 then
                buildup_mult = 1.5
            elseif self:GetCharged() == 2 then
                buildup_mult = 2
            end
            colData.HitEntity:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, 20 * buildup_mult, self.Owner)
        end
    end]]--
    ParticleEffect("ice_impact_heavy", pos, Angle(0,0,0), self.Owner)
    sound.Play("horde/weapons/void_projector/void_spear_hit.ogg", pos, 100, math.random(70, 90))

    if self:GetCharged() == 1 then
        local e = EffectData()
            e:SetOrigin(pos)
            e:SetNormal(Vector(0,0,1))
            e:SetScale(0.4)
        util.Effect("cold_explosion", e, true, true)
        sound.Play("horde/weapons/void_projector/void_spear_blast.ogg", pos, 100, math.random(70, 90))
    elseif self:GetCharged() == 2 then
        local e = EffectData()
            e:SetOrigin(pos)
            e:SetNormal(Vector(0,0,1))
            e:SetScale(0.8)
        util.Effect("cold_explosion", e, true, true)
        sound.Play("horde/weapons/void_projector/void_spear_blast.ogg", pos, 100, math.random(70, 90))
    end
    --ParticleEffect("ice_impact_swave", pos, Angle(0,0,0), self.Owner)
    self:Detonate(pos, colData.HitEntity)
end

function ENT:Draw()
    self:DrawModel()
end