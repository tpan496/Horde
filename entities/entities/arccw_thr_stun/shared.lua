ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Flash Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_flashbang_thrown.mdl"
ENT.FuseTime = 2.5
ENT.ArmTime = 0
ENT.ImpactFuse = false
ENT.Armed = true

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

        if self.FuseTime <= 0 then
            self:Detonate()
        end

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

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

function ENT:FlashBang()
    if !self:IsValid() then return end
    self:EmitSound("arccw_go/flashbang/flashbang_explode1.wav", 100, 100, 1, CHAN_ITEM)
    self:EmitSound("arccw_go/flashbang/flashbang_explode1_distant.wav", 140, 100, 1, CHAN_WEAPON)

    local attacker = self

    if self:GetOwner():IsValid() then
        attacker = self:GetOwner()
    end

    util.BlastDamage(self, attacker, self:GetPos(), 150, 80)

    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )

    util.Effect("stun_flash", effectdata)

    local flashorigin = self:GetPos()

    local flashpower = 256
    local targets = ents.FindInSphere(flashorigin, flashpower)
    if not targets then return end
    for _, k in pairs(targets) do
        if k:IsPlayer() then
            local dist = k:EyePos():Distance(flashorigin)
            local dp = (k:EyePos() - flashorigin):Dot(k:EyeAngles():Forward())

            local time = Lerp( dp, 2.5, 0.25 )

            time = Lerp( dist / flashpower, time, 0 )

            if k:VisibleVec( flashorigin ) then
                k:ScreenFade( SCREENFADE.IN, Color( 255, 255, 255, 100 ), 2.5, time )
            end

            k:SetDSP( 37, false )

        elseif k:IsNPC() then
            k:Horde_AddDebuffBuildup(HORDE.Status_Stun, 200, attacker, k:GetPos())
        end
    end
end

function ENT:Detonate()
    if !self:IsValid() or self:WaterLevel() > 2 then return end
    if !self.Armed then return end

    self.Armed = false

    self:FlashBang()

    self:Remove()
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end