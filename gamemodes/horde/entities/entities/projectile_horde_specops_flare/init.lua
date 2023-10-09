AddCSLuaFile("shared.lua")
include('shared.lua')
ENT.Model = "models/crossbow_bolt.mdl"
ENT.Ticks = 0
ENT.FuseTime = 1.5
ENT.ArmTime = 0
ENT.Armed = false
ENT.ImpactFuse = false
ENT.ColorModulation = Color(1, 0, 0)
ENT.IdleSound1 = Sound("weapons/flaregun/burn.wav")
ENT.StartHealth = 100000
ENT.HullType = HULL_TINY
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.VJ_NPC_Class = {CLASS_PLAYER_ALLY}

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end

function ENT:CustomOnInitialize()
    if SERVER then
        self:SetModel( self.Model )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:DrawShadow( true )
        self:SetRenderMode(RENDERMODE_TRANSCOLOR)
        self:SetColor(Color(0,0,0,0))
        self:DropToFloor()

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetBuoyancyRatio(0)
            phys:EnableGravity(true)
        end

        self.SpawnTime = CurTime()

        self:Detonate()

        timer.Simple(0, function()
            if !IsValid(self) then return end
            self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
        end)
    else
        self:SetColor(Color(255, 0, 0))
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

    self.ENVFlare = ents.Create("env_flare")
	self.ENVFlare:SetPos(self:GetPos())
	self.ENVFlare:SetAngles(self:GetAngles())
	self.ENVFlare:SetParent(self)
	self.ENVFlare:SetKeyValue("Scale","5")
	self.ENVFlare:SetKeyValue("spawnflags","4")
	self.ENVFlare:Spawn()

	self:EmitSound(self.IdleSound1, 75)

    timer.Simple(3, function()
        if !IsValid(self) then return end
        self:StopSound(self.IdleSound1)
        self:Remove()
    end)
end