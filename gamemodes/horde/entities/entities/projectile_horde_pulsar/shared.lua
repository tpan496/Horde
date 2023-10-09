ENT.Base 				= "projectile_horde_spell_base"
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
ENT.DamageTimer = 0

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:CustomOnInitialize()
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

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime()
    self.AttachedToTarget = nil

    if not (self.Target and HORDE:IsEnemy(self.Target)) then
        self.Target = nil
    end

    self.TotalBounce = 25 + (self.Horde_SpellLevel or 0) * 10
    end

    --if CLIENT then
    timer.Simple(0, function ()
        if not self:IsValid() then return end
        ParticleEffectAttach("nether_star_charged", PATTACH_ABSORIGIN_FOLLOW, self, 0)
    end)
    --end
end

local function shuffle(tbl)
for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
end
return tbl
end

function ENT:Bounce(prev_target)
    if self.TotalBounce <= 0 then
        self:Remove()
    else
        self.Target = nil
        self.AttachedToTarget = nil
        local targets = ents.FindInSphere(self:GetPos(), 600)
        for _, e in pairs(shuffle(targets)) do
            if e ~= prev_target and e:IsNPC() and e:Health() > 0 and (not e:GetNWEntity("HordeOwner"):IsValid()) then
                self.Target = e
                self.TotalBounce = self.TotalBounce - 1
                return
            end
        end
    end
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end
    if SERVER and self.ExplodeTimer <= CurTime() then
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
            if (not self.AttachedToTarget) and (self.Target:GetPos() + self.Target:OBBCenter()):DistToSqr(self:GetPos()) < 4000 then
                self.ExplodeTimer = CurTime() + 5
                self.AttachedToTarget = true
            end
            if self.AttachedToTarget then
                self:SetPos(self.Target:GetPos() + self.Target:OBBCenter())
                local dmg_splash = DamageInfo()
                dmg_splash:SetAttacker(self.Owner)
                dmg_splash:SetInflictor(self)
                dmg_splash:SetDamageType(DMG_SHOCK)
                dmg_splash:SetDamagePosition(self.Target:GetPos())
                dmg_splash:SetDamage(self:GetSpellBaseDamage(1))
                self.Target:TakeDamageInfo(dmg_splash)
                self.PrevTarget = self.Target
                self:Bounce(self.Target)

                ParticleEffect("nether_star_explode", self:GetPos(), Angle(0,0,0), nil)
                sound.Play("horde/weapons/nether_relic/nether_star_explode.ogg", self:GetPos(), 100, math.random(90, 110))
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
            for _, e in pairs(shuffle(targets)) do
                if e ~= self.PrevTarget and e:IsNPC() and e:Health() > 0 and (not e:GetNWEntity("HordeOwner"):IsValid()) then
                    self.Target = e
                    return
                end
            end
        end
    end
end

function ENT:OnRemove()
    local pos = self:GetPos()
    local owner = self.Owner
    ParticleEffect("nether_star_explode", pos, Angle(0,0,0), owner)
    sound.Play("horde/weapons/nether_relic/nether_star_explode.ogg", self:GetPos(), 100, math.random(90, 110))
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
end

function ENT:Draw()
    self:DrawModel()
end