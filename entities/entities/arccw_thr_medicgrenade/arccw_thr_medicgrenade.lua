ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Medic Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_smokegrenade_thrown.mdl"
ENT.FuseTime = 5
ENT.ArmTime = 0
ENT.FireTime = 15
ENT.ImpactFuse = false

ENT.Armed = false

ENT.NextDamageTick = 0

ENT.Ticks = 0

AddCSLuaFile()

function ENT:SetupDataTables()
    self:NetworkVar( "Bool", 0, "Armed" )

    if SERVER then
        self:SetArmed(false)
    end
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

        if (CurTime() - self.SpawnTime >= self.ArmTime) and self.ImpactFuse then
            self:Detonate()
        end
    end
end

local fired = {
    "effects/fire_embers1",
    "effects/fire_embers2",
    "effects/fire_embers3",
}
local function GetFireParticle()
    return fired[math.random(#fired)]
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime and !self.Armed then
        self:Detonate()
        self:SetArmed(true)
    end

    if self:GetArmed() then

        if SERVER then
            if self.NextDamageTick > CurTime() then return end

            local dmg = DamageInfo()
            dmg:SetDamageType(DMG_BURN)
            dmg:SetDamage(75)
            dmg:SetInflictor(self)
            dmg:SetAttacker(self.Owner)
            util.BlastDamageInfo(dmg, self:GetPos(), 256)

            self.NextDamageTick = CurTime() + 0.25

            self.ArcCW_Killable = false
        else

            if !self.Light then
                self.Light = DynamicLight(self:EntIndex())
                if (self.Light) then
                    self.Light.Pos = self:GetPos()
                    self.Light.r = 255
                    self.Light.g = 135
                    self.Light.b = 0
                    self.Light.Brightness = 8
                    self.Light.Size = 256
                    self.Light.DieTime = CurTime() + self.FireTime
                end
            else
                self.Light.Pos = self:GetPos()
            end

            local emitter = ParticleEmitter(self:GetPos())

            if !self:IsValid() or self:WaterLevel() > 2 then return end
            if !IsValid(emitter) then return end

            if self.Ticks % 5 == 0 then
                local fire = emitter:Add("particles/smokey", self:GetPos())
                fire:SetVelocity( (VectorRand() * 25) + (self:GetAngles():Up() * 300) )
                fire:SetGravity( Vector(0, 0, 1500) )
                fire:SetDieTime( math.Rand(0.5, 1) )
                fire:SetStartAlpha( 255 )
                fire:SetEndAlpha( 0 )
                fire:SetStartSize( 10 )
                fire:SetEndSize( 150 )
                fire:SetRoll( math.Rand(-180, 180) )
                fire:SetRollDelta( math.Rand(-0.2,0.2) )
                fire:SetColor( 255, 255, 255 )
                fire:SetAirResistance( 150 )
                fire:SetPos( self:GetPos() )
                fire:SetLighting( false )
                fire:SetCollide(true)
                fire:SetBounce(0.75)
                fire:SetNextThink( CurTime() + FrameTime() )
                fire:SetThinkFunction( function(pa)
                    if !pa then return end
                    local col1 = Color(255, 135, 0)
                    local col2 = Color(255, 255, 255)

                    local col3 = col1
                    local d = pa:GetLifeTime() / pa:GetDieTime()
                    col3.r = Lerp(d, col1.r, col2.r)
                    col3.g = Lerp(d, col1.g, col2.g)
                    col3.b = Lerp(d, col1.b, col2.b)

                    pa:SetColor(col3.r, col3.g, col3.b)
                    pa:SetNextThink( CurTime() + FrameTime() )
                end )
            end

            if self.Ticks % 10 == 0 then
                local fire = emitter:Add("effects/spark", self:GetPos())
                fire:SetVelocity( VectorRand() * 750 )
                fire:SetGravity( Vector(math.Rand(-5, 5), math.Rand(-5, 5), -2000) )
                fire:SetDieTime( math.Rand(0.5, 1) )
                fire:SetStartAlpha( 255 )
                fire:SetEndAlpha( 0 )
                fire:SetStartSize( 5 )
                fire:SetEndSize( 0 )
                fire:SetRoll( math.Rand(-180, 180) )
                fire:SetRollDelta( math.Rand(-0.2,0.2) )
                fire:SetColor( 255, 255, 255 )
                fire:SetAirResistance( 50 )
                fire:SetPos( self:GetPos() )
                fire:SetLighting( false )
                fire:SetCollide(true)
                fire:SetBounce(0.8)
                fire.Ticks = 0
            end

            self.NextFlareTime = self.NextFlareTime or CurTime()

            if self.NextFlareTime <= CurTime() then
                self.NextFlareTime = CurTime() + math.Rand(0.1, 0.5)
                local fire = emitter:Add("sprites/orangeflare1", self:GetPos())
                fire:SetVelocity( VectorRand() * 750 )
                fire:SetGravity( Vector(math.Rand(-5, 5), math.Rand(-5, 5), -2000) )
                fire:SetDieTime( math.Rand(1, 2) )
                fire:SetStartAlpha( 255 )
                fire:SetEndAlpha( 0 )
                fire:SetStartSize( 50 )
                fire:SetEndSize( 0 )
                fire:SetRoll( math.Rand(-180, 180) )
                fire:SetRollDelta( math.Rand(-0.2,0.2) )
                fire:SetColor( 255, 255, 255 )
                fire:SetAirResistance( 50 )
                fire:SetPos( self:GetPos() )
                fire:SetLighting( false )
                fire:SetCollide(true)
                fire:SetBounce(0.8)
                fire.Ticks = 0
                fire:SetNextThink( CurTime() + FrameTime() )
                fire:SetThinkFunction( function(pa)
                    if !pa then return end

                    local aemitter = ParticleEmitter(pa:GetPos())

                    local d = pa:GetLifeTime() / pa:GetDieTime()

                    if !IsValid(aemitter) then return end

                    if pa.Ticks % 5 == 0 then
                        local afire = aemitter:Add("particles/smokey", pa:GetPos())
                        afire:SetVelocity( VectorRand() * 5 )
                        afire:SetGravity( Vector(0, 0, 1500) )
                        afire:SetDieTime( math.Rand(0.25, 0.5) * d )
                        afire:SetStartAlpha( 255 )
                        afire:SetEndAlpha( 0 )
                        afire:SetStartSize( 5 * d )
                        afire:SetEndSize( 20 )
                        afire:SetRoll( math.Rand(-180, 180) )
                        afire:SetRollDelta( math.Rand(-0.2,0.2) )
                        afire:SetColor( 255, 255, 255 )
                        afire:SetAirResistance( 150 )
                        afire:SetPos( pa:GetPos() )
                        afire:SetLighting( false )
                        afire:SetCollide(true)
                        afire:SetBounce(0.9)
                        afire:SetNextThink( CurTime() + FrameTime() )
                        afire:SetThinkFunction( function(apa)
                            if !apa then return end
                            local col1 = Color(255, 135, 0)
                            local col2 = Color(255, 255, 255)

                            local col3 = col1
                            local d = apa:GetLifeTime() / apa:GetDieTime()
                            col3.r = Lerp(d, col1.r, col2.r)
                            col3.g = Lerp(d, col1.g, col2.g)
                            col3.b = Lerp(d, col1.b, col2.b)

                            apa:SetColor(col3.r, col3.g, col3.b)
                            apa:SetNextThink( CurTime() + FrameTime() )
                        end )
                    end

                    aemitter:Finish()

                    pa.Ticks = pa.Ticks + 1

                    pa:SetNextThink( CurTime() + FrameTime() )
                end )
            end

            emitter:Finish()

            self.Ticks = self.Ticks + 1
        end

    end
end

function ENT:OnRemove()
    if !self.FireSound then return end
    self.FireSound:Stop()
end

function ENT:Detonate()
    if !self:IsValid() then return end

    self.Armed = true

    self.FireSound = CreateSound(self, "weapons/flaregun/burn.wav")
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

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()

        if !self:GetArmed() then return end

        cam.Start3D() -- Start the 3D function so we can draw onto the screen.
            render.SetMaterial( Material("sprites/orangeflare1") ) -- Tell render what material we want, in this case the flash from the gravgun
            render.DrawSprite( self:GetPos(), math.random(400, 500), math.random(400, 500), Color(255, 255, 255) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
        cam.End3D()
    end
end