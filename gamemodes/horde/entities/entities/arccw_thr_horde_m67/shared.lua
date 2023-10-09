ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Frag Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_fraggrenade_thrown.mdl"
ENT.FuseTime = 3.5
ENT.ArmTime = 0
ENT.ImpactFuse = false
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE

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
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        self:GetPhysicsObject():SetDamping(2, 2)
        if self.Detonated then return end
        if data.Speed > 75 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_soft" .. math.random(1,3) .. ".wav"))
        end

        if IsValid(self.Owner) then
            if self.Owner:Horde_GetPerk("demolition_frag_impact") and (not HORDE:IsPlayerMinion(data.HitEntity)) then
                self:Detonate(impact)
                for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
                    if HORDE:IsEnemy(ent) then
                        ent:Horde_AddDebuffBuildup(HORDE.Status_Stun, 500, self.Owner, ent:GetPos())
                    end
                end
            end
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

function ENT:Detonate(impact)
    if SERVER then
        if !self:IsValid() then return end
        self.Detonated = true
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

        if impact then
            util.BlastDamage(self, attacker, self:GetPos(), 200, 280)
        else
            util.BlastDamage(self, attacker, self:GetPos(), 200, 225)
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