ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Frag Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_fraggrenade_thrown.mdl"
ENT.FuseTime = 1.5
ENT.ArmTime = 0
ENT.ImpactFuse = false

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
            phys:SetMass(1)
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

function ENT:Detonate()
    if SERVER then
        if !self:IsValid() then return end
        local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )

        if self:WaterLevel() >= 1 then
            util.Effect("WaterSurfaceExplosion", effectdata)
            self:EmitSound("weapons/underwater_explode3.wav", 120, 100, 1, CHAN_AUTO)
        else
            util.Effect("Explosion", effectdata)
            self:EmitSound("arccw_go/hegrenade/hegrenade_detonate_01.wav", 125, 100, 1, CHAN_AUTO)
        end

        local attacker = self

        if self.Owner:IsValid() then
            attacker = self.Owner
        end
        util.BlastDamage(self, attacker, self:GetPos(), 150, 100)
        local dmg = 50
        local rad = 200
        for i = 1, 3 do
            local prop = ents.Create("prop_physics")
            prop:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
            prop:SetModelScale(0.25, 0)
            prop:SetPos(self:GetPos() + VectorRand() * 4 + Vector(0, 0, 8))
            prop:SetAngles(AngleRand())
            prop:SetCollisionGroup(COLLISION_GROUP_WEAPON)
            prop:Spawn()
            prop:Activate()
            timer.Simple(0, function() prop:GetPhysicsObject():AddVelocity(VectorRand() * 300 + Vector(0, 0, 200)) end)
            timer.Simple(0.5 + i * 0.1, function() if IsValid(prop) then
                local e = EffectData()
                e:SetOrigin(prop:GetPos())
                util.Effect("Explosion", e)
                util.BlastDamage(prop, attacker, prop:GetPos(), rad, dmg)
                prop:Remove()
            end end)
        end

        self:Remove()

    end
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end