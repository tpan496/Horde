ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false

AddCSLuaFile()

ENT.Model = "models/weapons/arccw_go/w_eq_smokegrenade_thrown.mdl"
ENT.Ticks = 0
ENT.FuseTime = 0.5
ENT.ArmTime = 0
ENT.Armed = false
ENT.ImpactFuse = false
ENT.SmokeRadius = 100
ENT.SmokeColor = Color(150, 150, 150)
ENT.BillowTime = 1
ENT.Life = 15
ENT.ColorModulation = Color(0.25, 1, 0.25)


function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end

local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004", "particle/smokesprites_0005", "particle/smokesprites_0006", "particle/smokesprites_0007", "particle/smokesprites_0008", "particle/smokesprites_0009", "particle/smokesprites_0010", "particle/smokesprites_0011", "particle/smokesprites_0012", "particle/smokesprites_0013", "particle/smokesprites_0014", "particle/smokesprites_0015", "particle/smokesprites_0016"}

local function GetSmokeImage()
    return smokeimages[math.random(#smokeimages)]
end

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:DrawShadow( true )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.SpawnTime = CurTime()

        if self.FuseTime <= 0 then
            self:Detonate()
        end

        timer.Simple(0, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
    else
        self:SetColor(Color(0, 0, 0))
    end
end

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Armed" )

    if SERVER then
        self:SetArmed(false)
    end
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime and !self.Armed then
        self:Detonate()
        self:SetArmed(true)
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
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

function ENT:Detonate()
    if !self:IsValid() then return end

    self.Armed = true

    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect("horde_smokescreen", effectdata)

    self:EmitSound("arccw_go/smokegrenade/smoke_emit.wav", 90, 100, 1, CHAN_AUTO)

    for _, e in pairs(ents.FindInSphere(self:GetPos(), 200)) do
        if e:IsPlayer() then
            e:Horde_AddSmokescreen()
        end
    end

    timer.Simple(2, function()
        if !IsValid(self) then return end
        self:Remove()
    end)
end