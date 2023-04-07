ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
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
ENT.BaseDamage = 40

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:Initialize()
    if SERVER then
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInitSphere( 16 )
    self:DrawShadow(false)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(false)
        phys:SetMass(1)
    end

    self.Removing = false
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    self.ExplodeTimer = CurTime() + 60

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime() + 0.5
    self.ChargeLevel = self.properties.charged

    self.BaseDamage = self.BaseDamage + 9 * self.properties.level
    self.Active = nil

    self.ParticleLevel = -1

    timer.Simple(0.5, function ()
        if not self:IsValid() then return end
        self.Active = true
        if phys:IsValid() then
            phys:SetVelocity(Vector(0,0,0))
        end
    end)
    end
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Charged" )
    self:NetworkVar( "Bool", 0, "ParticleAttached" )
end

function ENT:Think()
    if CLIENT then
        if self.ParticleLevel ~= self:GetCharged() then
            self:StopParticles()
            local charged = self:GetCharged()
            if charged == 0 then
                ParticleEffectAttach("nether_mine", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            elseif charged == 1 then
                ParticleEffectAttach("nether_mine_charged_1", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            elseif charged == 2 then
                ParticleEffectAttach("nether_mine_charged_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
            end
            self.ParticleLevel = self:GetCharged()
        end
    end
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end
    if SERVER and self.ExplodeTimer <= CurTime() then

        local dmg_splash = DamageInfo()
        dmg_splash:SetAttacker(self.Owner)
        dmg_splash:SetInflictor(self)
        dmg_splash:SetDamageType(DMG_GENERIC)
        dmg_splash:SetDamage(self.BaseDamage)
        dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
        dmg_splash:SetDamagePosition(self:GetPos())
        util.BlastDamageInfo(dmg_splash, self:GetPos(), 150)

        ParticleEffect("nether_mine_explode", self:GetPos(), Angle(0,0,0), self.Owner)
        sound.Play("horde/weapons/nether_relic/nether_mine_explode.ogg", self:GetPos(), 100, math.random(90, 110))
        self:Remove()
        return
    end

    if SERVER then
        if self.Target and self.Target:IsValid() and self.Target:Health() > 0 then
            local ang = self:GetAngles()
            local desired = ((self.Target:GetPos() + self.Target:OBBCenter()) - self:GetPos()):Angle()
			ang = LerpAngle(0.8, ang, desired)
            self:SetAngles(desired)

            local phys = self:GetPhysicsObject()
            if (!IsValid( phys )) then self:Remove() return end
            phys:ApplyForceCenter(self:GetForward() * 500)
        else
            self.Target = nil
            self.AttachedToTarget = nil
        end
    end
end

function ENT:Detonate()
    if !self:IsValid() or self.Removing then return end

    local dmg_mult = 1
    --[[if self.properties.energy_vacuum == true then
        local duration = math.min(5, math.max(0, CurTime() - self.StartTime))
        dmg_mult = dmg_mult * (1 + 0.25 * duration / 5)
    end]]--

    local charged = self:GetCharged()
    local radius_mult = 1
    dmg_mult = dmg_mult * (1 + charged * 0.5)
    radius_mult = radius_mult * (1 + charged * 0.5)

    ParticleEffect("nether_mine_explode", self:GetPos(), Angle(0,0,0), self.Owner)
    sound.Play("horde/weapons/nether_relic/nether_mine_explode.ogg", self:GetPos(), 100, math.random(90, 110))
    local eff = EffectData()
    eff:SetStart(self:GetPos())
    eff:SetOrigin(self:GetPos())
    util.Effect("Explosion", eff)

    if self.properties.dirac_sea == true then
        local dmg_splash = DamageInfo()
        dmg_splash:SetAttacker(self.Owner)
        dmg_splash:SetInflictor(self)
        dmg_splash:SetDamageType(DMG_GENERIC)
        dmg_splash:SetDamage(self.BaseDamage * dmg_mult)
        dmg_splash:SetDamagePosition(self:GetPos())
        HORDE:ApplyDamageInRadius(self:GetPos(), 150 * radius_mult, dmg_splash)
        if charged > 0 then
            self:SetCharged(0)
            self:PhysicsInitSphere( 16 )
            return
        end
    else
        local dmg_splash = DamageInfo()
        dmg_splash:SetAttacker(self.Owner)
        dmg_splash:SetInflictor(self)
        dmg_splash:SetDamageType(DMG_GENERIC)
        dmg_splash:SetDamage(self.BaseDamage * dmg_mult)
        dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
        dmg_splash:SetDamagePosition(self:GetPos())
        util.BlastDamageInfo(dmg_splash, self:GetPos(), 150 * radius_mult)
    end

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local phys = self:GetPhysicsObject()
    if (!IsValid( phys )) then self:Remove() return end
    phys:SetVelocity(Vector(0,0,0))
    if not self.Active then return end
    local pos = colData.HitPos
    if !colData.HitEntity:IsValid() then return end
    if HORDE:IsPlayerOrMinion(colData.HitEntity) then return end
    if colData.HitEntity:GetClass() == "projectile_horde_nether_star" then return end
    if colData.HitEntity:GetClass() == "projectile_horde_nether_mine" then return end
    self:Detonate(pos, colData.HitEntity)
end

function ENT:OnRemove()
    local owner = self.Owner
    local count = 0
    if SERVER and owner:IsValid() and owner.Horde_Nether_Mines then
        local p = 0
        local n = table.Count(owner.Horde_Nether_Mines)
        for i = 1, n do
            if owner.Horde_Nether_Mines[i]:EntIndex() == self:EntIndex() then
                p = i
                break
            end
        end
        if p ~= 0 then
            table.remove(owner.Horde_Nether_Mines, p)
            count = math.max(0,n-1)
        end

        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Nether_Mine, 8)
            net.WriteUInt(count, 8)
        net.Send(owner)
    end
end

function ENT:Draw()
    self:DrawModel()
end