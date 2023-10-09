if not ArcCWInstalled then return end
-- Referenced From GSO
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Medic Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/w_grenade.mdl"
ENT.FuseTime = 2
ENT.ArmTime = 0
ENT.Duration = 7.5
ENT.ImpactFuse = false

ENT.Armed = false

ENT.NextDamageTick = 0
ENT.TouchDamageTick = 0

ENT.Ticks = 0
ENT.TouchedEntities = {}
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE

AddCSLuaFile()

local entmeta = FindMetaTable("Entity")

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Armed" )

    if SERVER then
        self:SetArmed(false)
    end
end

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.Model)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:DrawShadow(true)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.SpawnTime = CurTime()
        self:SetColor(Color(0, 0, 200))
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        self:GetPhysicsObject():SetDamping(2, 2)
        if data.Speed > 75 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_soft" .. math.random(1,3) .. ".wav"))
        end

        if (CurTime() - self.SpawnTime >= self.ArmTime) and self.ImpactFuse then
            self:Detonate()
        end
    end
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime and !self.Armed then
        self:Detonate()
        local owner = self.Owner
        if owner:IsValid() then
            owner:Horde_SetMinionCount(owner:Horde_GetMinionCount() + 1)
        end
        self:SetArmed(true)
    end

    if self:GetArmed() then

        if SERVER then
            if self.NextDamageTick > CurTime() then return end
            for _, e in pairs(ents.FindInSphere(self:GetPos(), 200)) do
                if HORDE:IsPlayerMinion(e) then
                    e:SetHealth(math.min(e:GetMaxHealth(), e:GetMaxHealth() * 0.03 + e:Health()))
                elseif e:IsPlayer() then
                    HORDE:SelfHeal(e, 3)
                end
            end
            self.NextDamageTick = CurTime() + 0.5
            self.ArcCW_Killable = false
        else
            if not self.emitter then self.emitter = ParticleEmitter(self:GetPos()) end
            if self.Ticks % 5 == 0 then
                local smoke = self.emitter:Add("particles/smokey", self:GetPos() + VectorRand() * 50)
                smoke:SetGravity( Vector(0, 0, 1500) )
                smoke:SetDieTime( math.Rand(0.5, 1) )
                smoke:SetStartAlpha(10)
                smoke:SetEndAlpha(0)
                smoke:SetStartSize(10)
                smoke:SetEndSize(250)
                smoke:SetRoll( math.Rand(-180, 180) )
                smoke:SetRollDelta( math.Rand(-0.2,0.2) )
                smoke:SetColor(50, 200, 50)
                smoke:SetAirResistance(1000)
                smoke:SetLighting( false )
                smoke:SetCollide(true)
                smoke:SetBounce(0)
                smoke:SetNextThink(CurTime() + FrameTime())
                smoke:SetThinkFunction( function(pa)
                    if !pa then return end
                    local col1 = Color(105, 50, 255)
                    local col2 = Color(50, 50, 200)

                    local col3 = col1
                    local d = pa:GetLifeTime() / pa:GetDieTime()
                    col3.r = Lerp(d, col1.r, col2.r)
                    col3.g = Lerp(d, col1.g, col2.g)
                    col3.b = Lerp(d, col1.b, col2.b)

                    pa:SetColor(col3.r, col3.g, col3.b)
                    pa:SetNextThink(CurTime() + FrameTime())
                end)
            end

            if !self:IsValid() or self:WaterLevel() > 2 then return end
            if !IsValid(emitter) then return end

            self.Ticks = self.Ticks + 1
        end

    end
end

function ENT:OnRemove()
    if SERVER then
        local owner = self.Owner
        if owner:IsValid() then
            owner:Horde_SetMinionCount(owner:Horde_GetMinionCount() - 1)
        end
    end
end

function ENT:Detonate()
    if !self:IsValid() then return end

    self.Armed = true
    self:EmitSound("arccw_go/smokegrenade/smoke_emit.wav", 90, 100, 1, CHAN_AUTO)

    timer.Simple(self.Duration, function()
        if !IsValid(self) then return end

        self:Remove()
    end)
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()

        if !self:GetArmed() then return end
    end
end