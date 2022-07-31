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

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit(SOLID_VPHYSICS)
        self:DrawShadow( false )
        self:SetCollisionBounds(Vector(-150,-150,-100), Vector(150,150,100))
        self:SetTrigger(true)
        self:UseTriggerBounds(true, 24)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
        end

        self.FireTime = 30
        self.BaseDamage = 10
        self.DamageRadius = 150

        self:Detonate()

        timer.Simple(0.1, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
        end)
    end

    local owner = self:GetOwner()
end

local fired = {
    "sprites/flamelet1",
    "sprites/flamelet2",
    "sprites/flamelet3",
    "sprites/flamelet4",
    "sprites/flamelet5",
}
local function GetFireParticle()
    return fired[math.random(#fired)]
end

function ENT:Think()
    if SERVER and self.DamageTime <= CurTime() then
        for _, ent in pairs(ents.FindInSphere(self:GetPos(), self.DamageRadius)) do
            if HORDE:IsPlayerOrMinion(ent) then
                local dmg = DamageInfo()
                dmg:SetDamage(self.BaseDamage)
                dmg:SetDamageType(DMG_BURN)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(self:GetPos())
                ent:TakeDamageInfo(dmg)
            end
        end
        self.DamageTime = CurTime() + 0.2
    end

    if CLIENT then
        local emitter = ParticleEmitter(self:GetPos())

        if !self:IsValid() or self:WaterLevel() > 2 then return end
        if !IsValid(emitter) then return end

        for i = 1,10 do
            local fire = emitter:Add(GetFireParticle(), self:GetPos() + (VectorRand() * 30 ))
            fire:SetVelocity( VectorRand() * 130 )
            fire:SetGravity( Vector(0, 0, 1000) )
            fire:SetDieTime( math.Rand(0.2, 0.5) )
            fire:SetStartAlpha( 255 )
            fire:SetEndAlpha( 0 )
            fire:SetStartSize( 0 )
            fire:SetEndSize( 30 )
            fire:SetRoll( math.Rand(-180, 180) )
            fire:SetRollDelta( math.Rand(-0.2,0.2) )
            fire:SetColor( 100, 120, 255 )
            fire:SetAirResistance( 500 )
            local pos = VectorRand() * math.random(0,150)
            pos.z = 0
            fire:SetPos( self:GetPos() + pos )
            fire:SetLighting( false )
            fire:SetCollide(true)
            fire:SetBounce(0.75)
            fire:SetNextThink( CurTime() + FrameTime() )
            fire:SetThinkFunction( function(pa)
                if !pa then return end
                local col1 = Color(100, 120, 255)
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
    else

        if self:GetVelocity():LengthSqr() <= 32 then
            self:SetMoveType( MOVETYPE_NONE )
        end

        if self:WaterLevel() > 2 then self:Remove() return end
    end
end

function ENT:OnRemove()
    if !self.FireSound then return end
    self.FireSound:Stop()
end

function ENT:Detonate()
    if !self:IsValid() then return end

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