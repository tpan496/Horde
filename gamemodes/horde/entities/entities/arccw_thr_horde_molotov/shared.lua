ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Molotov Cocktail"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_molotov_thrown.mdl"
ENT.FuseTime = 5
ENT.ArmTime = 0
ENT.FireTime = 15
ENT.ImpactFuse = true

ENT.Armed = false

ENT.NextDamageTick = 0

ENT.Ticks = 0

AddCSLuaFile()

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
            self:SetCollisionGroup(COLLISION_GROUP_PLAYER_MOVEMENT)
        end)
    end

    local owner = self:GetOwner()
    self.has_burner = nil
    if owner and owner:Horde_GetGadget() == "gadget_hydrogen_burner" then
        self.has_burner = true
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        self:Detonate()
    end
end

function ENT:Think()
    if !self.SpawnTime then self.SpawnTime = CurTime() end

    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime and !self.Armed then
        self:Detonate()
    end

    if CLIENT then
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
            fire:SetEndSize( 50 )
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
                if self.has_burner then
                    col1 = Color(0, 135, 255)
                end
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

        emitter:Finish()

        self.Ticks = self.Ticks + 1
    end
end

function ENT:Detonate()
    if self.Exploded then return end
    self.Exploded = true
    self:EmitSound("arccw_go/molotov/molotov_detonate_1.wav", 75, 100, 1, CHAN_ITEM)
    self:EmitSound("arccw_go/molotov/molotov_detonate_1_distant.wav", 100, 100, 1, CHAN_WEAPON)

    local cloud = ents.Create("arccw_horde_fire")

    if !IsValid(cloud) then return end

    local vel = Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * 1500

    cloud:SetPos(self:GetPos() - (self:GetVelocity() * FrameTime()))
    cloud:SetAbsVelocity(vel + self:GetVelocity())
    cloud:SetOwner(self:GetOwner())
    cloud:Spawn()

    self:Remove()
end

function ENT:DrawTranslucent()
    self:Draw()
end

local mat = Material("sprites/orangeflare1")
function ENT:Draw()
    self:DrawModel()

    cam.Start3D() -- Start the 3D function so we can draw onto the screen.
        render.SetMaterial( mat ) -- Tell render what material we want, in this case the flash from the gravgun
        render.DrawSprite( self:GetPos(), math.random(75, 100), math.random(75, 100), Color(255, 255, 255) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
    cam.End3D()
end
