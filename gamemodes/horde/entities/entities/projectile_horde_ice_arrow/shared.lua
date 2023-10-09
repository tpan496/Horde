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
    self:SetModel(self.Model)
    self:SetModelScale(1.5)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInitSphere(1)

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
    self.ExplodeTimer = CurTime() + 2

    if self:GetCharged() == 1 then
        self.ExplodeTimer = self.ExplodeTimer + 0.5
    elseif self:GetCharged() == 2 then
        self.ExplodeTimer = self.ExplodeTimer + 0.6
    end
    
    self:SetMaterial("spells/effects/frozen")
    self:SetModelScale(3)
    self.StartTime = CurTime()
    end
    
    ParticleEffectAttach("ice_arrow_trail_3", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end
    if SERVER and self.ExplodeTimer <= CurTime() then
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
    if self:GetCharged() == 1 then
        dmg_mult = 1.5
    elseif self:GetCharged() == 2 then
        dmg_mult = 2
    end

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
        end
    })

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local pos = colData.HitPos
    ParticleEffect("ice_arrow_hit", self:GetPos(), Angle(0,0,0), nil)
    sound.Play("horde/weapons/void_projector/void_spear_hit.ogg", pos, 100, math.random(70, 90))
    --ParticleEffect("ice_impact_swave", pos, Angle(0,0,0), self.Owner)
    self:Detonate(pos, colData.HitEntity)
end

function ENT:Draw()
    self:DrawModel()
end