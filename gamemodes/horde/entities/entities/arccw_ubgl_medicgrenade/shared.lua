if not ArcCWInstalled then return end
-- Referenced From GSO
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Medic Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.FuseTime = 2
ENT.ArmTime = 0
ENT.Duration = 7.5
ENT.ImpactFuse = false

ENT.Armed = false

ENT.NextDamageTick = 0
ENT.TouchDamageTick = 0

ENT.Ticks = 0
ENT.TouchedEntities = {}

AddCSLuaFile()

local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddEffect_MedicGrenade(ent)
    if self.horde_effect_medicgrenade then return end
    self.horde_effect_medicgrenade = true
    local id = self:GetCreationID()
    timer.Create("Horde_MedicGrenadeEffect" .. id, 0.5, 0, function ()
        if not self:IsValid() then timer.Remove("Horde_MedicGrenadeEffect" .. id) return end
        if self:IsPlayer() then
            local healinfo = HealInfo:New({amount=4, healer=ent.Owner})
            HORDE:OnPlayerHeal(self, healinfo)
        elseif ent:GetClass() == "npc_vj_horde_antlion" then
            local healinfo = HealInfo:New({amount=4, healer=self.Owner})
            HORDE:OnAntlionHeal(ent, healinfo)
        elseif ent:IsValid() and ent.Owner:IsValid() and ent.Inflictor:IsValid() and self:IsNPC() and (not self:GetNWEntity("HordeOwner"):IsValid()) then
            local d = DamageInfo()
            d:SetDamage(25)
            d:SetAttacker(ent.Owner)
            d:SetInflictor(ent.Inflictor)
            d:SetDamageType(DMG_NERVEGAS)
            d:SetDamagePosition(self:GetPos())
            self:TakeDamageInfo(d)
        end
    end)
end

function entmeta:Horde_RemoveEffect_MedicGrenade()
    if self.horde_effect_medicgrenade then
        timer.Remove("Horde_MedicGrenadeEffect" .. self:GetCreationID())
        self.horde_effect_medicgrenade = nil
    end
end

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
        self:SetCollisionBounds(Vector(-100,-100,-100), Vector(100,100,100))
        self:SetTrigger(true)
        self:UseTriggerBounds(true, 24)
        self:SetColor(Color(0,255,0))

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.SpawnTime = CurTime()

        timer.Simple(0, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        if data.Speed > 75 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_soft" .. math.random(1,3) .. ".wav"))
        end

        self:Detonate()
    end
end

function ENT:Touch(ent)
    if SERVER then
        if self.TouchedEntities[ent:GetCreationID()] and ent.horde_effect_medicgrenade then return end
        if self:GetArmed() and (ent:IsPlayer() or ent:IsNPC()) then
            self.TouchedEntities[ent:GetCreationID()] = ent
            ent:Horde_AddEffect_MedicGrenade(self)
        end
    end
end

function ENT:EndTouch(ent)
    if SERVER then
        if not (ent:IsNPC() or ent:IsPlayer()) then return end
        self.TouchedEntities[ent:GetCreationID()] = nil
        ent:Horde_RemoveEffect_MedicGrenade()
    end
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if self:GetArmed() == true then
        if SERVER then
            if self.NextDamageTick > CurTime() then return end
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
                smoke:SetEndSize(200)
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
                    local col1 = Color(105, 255, 50)
                    local col2 = Color(50, 200, 50)

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
        for _, ent in pairs(self.TouchedEntities) do
            if ent:IsValid() then ent:Horde_RemoveEffect_MedicGrenade() end
        end
    end
end

function ENT:Detonate()
    if !self:IsValid() then return end
    if self:GetArmed() == true then return end
    self:SetArmed(true)

    self.Armed = true
    self:EmitSound("arccw_go/smokegrenade/smoke_emit.wav", 90, 100, 1, CHAN_AUTO)

    timer.Simple(self.Duration, function()
        if !IsValid(self) then return end

        self:Remove()
    end)

    self:SetMoveType(MOVETYPE_NONE)
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