ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Fire Particle"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/Items/AR2_Grenade.mdl"

ENT.FireTime = 2

ENT.Armed = false

ENT.NextDamageTick = 0

ENT.Ticks = 0
ENT.DamageTime = CurTime()

ENT.ArcCW_Killable = false

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_NONE )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit(SOLID_VPHYSICS)
        self:DrawShadow( false )
        self:SetCollisionBounds(Vector(-150,-150,-100), Vector(150,150,100))
        self:SetTrigger(true)
        self:UseTriggerBounds(true, 24)
        self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
            phys:EnableGravity(false)
        end

        self.SpawnTime = CurTime()
        self:Detonate()

        if not self.BaseDamage then self.BaseDamage = 10 end
        self.BaseDamage = self.BaseDamage / 4
        self:SetRadiusScale(self.BaseDamage * 1.25)

        self.FireTime = 1.5 + self.BaseDamage / 100
    end
end

local fired = {
    "particle/smokesprites_0001",
    "particle/smokesprites_0002",
    "particle/smokesprites_0003",
    "particle/smokesprites_0004",
    "particle/smokesprites_0005",
}
local function GetFireParticle()
    return fired[math.random(#fired)]
end

function ENT:SetupDataTables()
    self:NetworkVar( "Float", 1, "RadiusScale" )
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if SERVER and self.DamageTime <= CurTime() then
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), self:GetRadiusScale())) do
            if ent:IsPlayer() then
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage(self.BaseDamage)
                dmg:SetDamageType(DMG_GENERIC)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(self:GetPos())
                ent:TakeDamageInfo(dmg)
            end
        end
        self.DamageTime = CurTime() + 0.5
    end

    if CLIENT then
        local emitter = ParticleEmitter(self:GetPos())

        if !self:IsValid() or self:WaterLevel() > 2 then return end
        if !IsValid(emitter) then return end

        for i = 1, math.max(10, self:GetRadiusScale() / 5) do
            local fire = emitter:Add(GetFireParticle(), self:GetPos())
            --fire:SetVelocity( VectorRand() * self:GetRadiusScale() )
            fire:SetGravity( Vector(0, 0, 0) )
            fire:SetDieTime( math.Rand(0.2, 0.5) )
            fire:SetStartAlpha( 200 )
            fire:SetEndAlpha( 0 )
            fire:SetStartSize( 0 )
            fire:SetEndSize( 10 )
            fire:SetRoll( math.Rand(-180, 180) )
            fire:SetRollDelta( math.Rand(-0.2,0.2) )
            fire:SetColor( 100, 255, 0 )
            local pos = VectorRand() * self:GetRadiusScale()
            fire:SetPos( self:GetPos() + pos )
            fire:SetLighting( false )
            fire:SetCollide(true)
            fire:SetBounce(0.75)
            fire:SetNextThink( CurTime() + FrameTime() )
            fire:SetThinkFunction( function(pa)
                if !pa then return end
                local col1 = Color(50, 255, 0)
                local col2 = Color(0, 0, 0)

                local col3 = col1
                local d = pa:GetLifeTime() / pa:GetDieTime()
                col3.r = Lerp(d, col1.r, col2.r)
                col3.g = Lerp(d, col1.g, col2.g)
                col3.b = Lerp(d, col1.b, col2.b)

                pa:SetColor(col3.r, col3.g, col3.b)
                pa:SetNextThink( CurTime() + FrameTime() )
            end )
        end

        emitter:Finish()

        self.Ticks = self.Ticks + 1
    else

        if self:GetVelocity():LengthSqr() <= 32 then
            self:SetMoveType( MOVETYPE_NONE )
        end

        if self.NextDamageTick > CurTime() then return end

        if self:WaterLevel() > 2 then self:Remove() return end

        self.NextDamageTick = CurTime() + 0.25

        if self.SpawnTime + self.FireTime <= CurTime() then self:Remove() return end
    end
end

function ENT:OnRemove()
    if !self.FireSound then return end
    self.FireSound:Stop()
end

function ENT:Detonate()
    if !self:IsValid() then return end

    self.Armed = true

    if self.Order and self.Order != 1 then return end

    self.FireSound = CreateSound(self, "arccw_go/molotov/fire_loop_1.wav")
    self.FireSound:Play()

    self.FireSound:ChangePitch(80, self.FireTime)

    timer.Simple(self.FireTime - 1, function()
        if !IsValid(self) then return end

        self.FireSound:ChangeVolume(0, 1)
    end)

    timer.Simple(self.FireTime, function()
        if !IsValid(self) then return end

        self:Remove()
    end)
end

function ENT:Draw()
    -- cam.Start3D() -- Start the 3D function so we can draw onto the screen.
    --     render.SetMaterial( GetFireParticle() ) -- Tell render what material we want, in this case the flash from the gravgun
    --     render.DrawSprite( self:GetPos(), math.random(200, 250), math.random(200, 250), Color(255, 255, 255) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
    -- cam.End3D()
end