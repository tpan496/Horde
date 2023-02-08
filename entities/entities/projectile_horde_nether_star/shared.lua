ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_WORLD
ENT.CollisionGroupType = COLLISION_GROUP_WORLD
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0
ENT.BaseDamage = 10
ENT.DamageTimer = 0

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:Initialize()
    if SERVER then
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInitSphere( 1 )
    self:DrawShadow(false)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(false)
        phys:SetMass(1)
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    self.SearchTimer = CurTime() + 0.2

    self:SetCollisionGroup(COLLISION_GROUP_WORLD)

    self.ExplodeTimer = CurTime() + 10
    if self:GetCharged() > 0 then
        self.ExplodeTimer = CurTime() + 9999
    end

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime()
    self.AttachedToTarget = nil
    self:SetSilent(0)

    self.BaseDamage = self.BaseDamage + 2 * self.properties.level

    if self.properties.target and self.properties.target:IsValid() then
        if self.properties.target:IsNPC() then
            self.Target = self.properties.target
        elseif self.properties.target:IsPlayer() and self.properties.target:Alive() then
            if self.properties.celestial_bond == true then
                self.Target = self.properties.target
                self.HumanTarget = true
            end
        elseif self.properties.target:GetClass() == "projectile_horde_nether_mine" then
            if self.properties.coalesce == true then
                self.Target = self.properties.target
                self.MineTarget = self.Target
            end
        end
    end
    end

    --if CLIENT then
    timer.Simple(0, function ()
        if not self:IsValid() then return end
        local charged = self:GetCharged()
        if charged >= 1 then
            ParticleEffectAttach("nether_star", PATTACH_ABSORIGIN_FOLLOW, self, 0)
        else
            ParticleEffectAttach("nether_star", PATTACH_ABSORIGIN_FOLLOW, self, 0)
        end
    end)
    --end
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Charged" )
    self:NetworkVar( "Int", 1, "Silent" )
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end
    if SERVER and self.ExplodeTimer <= CurTime() then
        --[[local dmg_splash = DamageInfo()
        dmg_splash:SetAttacker(self.Owner)
        dmg_splash:SetInflictor(self)
        dmg_splash:SetDamageType(DMG_GENERIC)
        dmg_splash:SetDamage(self.BaseDamage * 2)
        dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
        util.BlastDamageInfo(dmg_splash, self:GetPos(), 200)

        ParticleEffect("nether_star_explode", self:GetPos(), Angle(0,0,0), self.Owner)
        sound.Play("horde/weapons/nether_relic/nether_star_explode.ogg", self:GetPos(), 100, math.random(90, 110))]]--
        self:Remove()
        return
    end

    if SERVER then
        if self.Target and self.Target:IsValid() then--[[and self.Target:Health() > 0]]--
            local ang = self:GetAngles()
            local desired = ((self.Target:GetPos() + self.Target:OBBCenter()) - self:GetPos()):Angle()
			ang = LerpAngle(0.8, ang, desired)
            self:SetAngles(desired)

            local phys = self:GetPhysicsObject()
            if (!IsValid( phys )) then self:Remove() return end
            if (not self.AttachedToTarget) and self.Target:GetPos():DistToSqr(self:GetPos()) < 4000 then
                if self.properties.magnetar == true then
                    self.ExplodeTimer = math.max(self.ExplodeTimer, CurTime() + 5)
                end

                if self.MineTarget == self.Target and self.MineTarget and self.MineTarget:IsValid() then
                    self.MineTarget:SetPos(self:GetPos())
                    self.MineTarget:SetParent(self)
                    self.MineTarget:PhysicsDestroy()
                    self.MineTarget:SetCollisionGroup(COLLISION_GROUP_WORLD)
                    self.Target = nil
                else
                    self.AttachedToTarget = true
                end
            end
            if self.AttachedToTarget then
                self:SetPos(self.Target:GetPos()+ self.Target:OBBCenter())
                if self.MineTarget and self.MineTarget:IsValid() then
                    self.MineTarget:Detonate()
                end
            else
                phys:ApplyForceCenter(self:GetForward() * 500)
            end
        else
            self.Target = nil
            self.AttachedToTarget = nil
        end

        if not self.Target and self.SearchTimer <= CurTime() then
            self.SearchTimer = CurTime() + 0.5
            local targets = ents.FindInSphere(self:GetPos(), 600)
            if not targets then return end
            for _, e in pairs(targets) do
                if e:IsNPC() and e:Health() > 0 and (not e:GetNWEntity("HordeOwner"):IsValid()) then
                    self.Target = e
                    return
                end
            end
        end

        if self.AttachedToTarget and self.DamageTimer <= CurTime() then
            local dmg_splash = DamageInfo()
            dmg_splash:SetAttacker(self.Owner)
            dmg_splash:SetInflictor(self)
            dmg_splash:SetDamageType(DMG_GENERIC)
            dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
            dmg_splash:SetDamagePosition(self.Target:GetPos())
            if self.Target:GetVar("is_elite") and self.Owner:Horde_GetPerk("warlock_starscourge") then
                dmg_splash:SetDamage(self.BaseDamage * 1.25)
            else
                dmg_splash:SetDamage(self.BaseDamage)
            end
            if self.HumanTarget then
                util.BlastDamageInfo(dmg_splash, self:GetPos(), 150)
            else
                self.Target:TakeDamageInfo(dmg_splash)
            end
            self.DamageTimer = CurTime() + 0.5
        end
    end
end

function ENT:Detonate(forced)
    if !self:IsValid() or self.Removing then return end

    local dmg_mult = 2
    local radius_mult = 1

    if forced == true then
        dmg_mult = 3
        radius_mult = 1.5
    end

    self.ForcedDetonate = true

    local dmg_splash = DamageInfo()
    dmg_splash:SetAttacker(self.Owner)
    dmg_splash:SetInflictor(self)
    dmg_splash:SetDamageType(DMG_GENERIC)
    dmg_splash:SetDamage(self.BaseDamage * dmg_mult)
    dmg_splash:SetDamageCustom(HORDE.DMG_SPLASH)
    util.BlastDamageInfo(dmg_splash, self:GetPos(), 200 * radius_mult)

    if self.MineTarget and self.MineTarget:IsValid() then
        self.MineTarget:Detonate()
    end

    self.Removing = true
    self:Remove()
end

function ENT:SilentRemove()
    self:SetSilent(1)
    self:Remove()
end

function ENT:OnRemove()
    local pos = self:GetPos()
    local owner = self.Owner

    if SERVER and owner:IsValid() and owner.Horde_Nether_Stars then
        local p = 0
        local n = table.Count(owner.Horde_Nether_Stars)
        for i = 1, n do
            if owner.Horde_Nether_Stars[i]:EntIndex() == self:EntIndex() then
                p = i
                break
            end
        end
        if p ~= 0 then
            table.remove(owner.Horde_Nether_Stars, p)
            net.Start("Horde_SyncStatus")
                net.WriteUInt(HORDE.Status_Nether_Star, 8)
                net.WriteUInt(math.max(0,n-1), 8)
            net.Send(owner)
        end
    end
    if self:GetSilent() == 1 then return end
    ParticleEffect("nether_star_explode", pos, Angle(0,0,0), owner)
    sound.Play("horde/weapons/nether_relic/nether_star_explode.ogg", self:GetPos(), 100, math.random(90, 110))
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
end

function ENT:Draw()
    self:DrawModel()
end