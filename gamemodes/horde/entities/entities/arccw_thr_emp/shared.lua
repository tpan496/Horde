ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "EMP Grenade"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/weapons/arccw_go/w_eq_incendiarygrenade_thrown.mdl"
ENT.FuseTime = 1.5
ENT.ArmTime = 0
ENT.ImpactFuse = false
ENT.Armed = true
ENT.CollisionGroup = COLLISION_GROUP_PLAYER_MOVEMENT

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
        self:SetColor(Color(100, 100, 200))

        if self.FuseTime <= 0 then
            self:Detonate()
        end
    end
end

function ENT:PhysicsCollide(data, physobj)
    if SERVER then
        self:GetPhysicsObject():SetDamping(2, 2)
        if data.Speed > 75 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard" .. math.random(1,3) .. ".wav"))
        elseif data.Speed > 25 then
            self:EmitSound(Sound("physics/metal/metal_grenade_impact_soft" .. math.random(1,3) .. ".wav"))
        end
    end
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

function ENT:Explode()
    if not self:IsValid() then return end
    self:EmitSound("ambient/levels/labs/electric_explosion1.wav", 100, 100, 1, CHAN_ITEM)

    local attacker = self

    if self:GetOwner():IsValid() then
        attacker = self:GetOwner()
    end

    for _, e in pairs(ents.FindInSphere(self:GetPos(), 200)) do
        if IsValid(e) and HORDE:IsEnemy(e) then
            for i = 1, 15 do
                local dmg = DamageInfo()
                dmg:SetDamage(10)
                dmg:SetDamageType(DMG_SHOCK)
                dmg:SetAttacker(attacker)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(e:GetPos())
                e:TakeDamageInfo(dmg)
                e:Horde_AddDebuffBuildup(HORDE.Status_Shock, dmg:GetDamage(), attacker, self:GetPos())
            end
        end
    end

    local ed = EffectData()
    ed:SetOrigin(self:GetPos())
    util.Effect("horde_emp_grenade_explosion", ed, true, true)
end

function ENT:Detonate()
    if not self:IsValid() or self.Detonated or not self.Armed then return end

    self.Armed = false
    self.Detonated = true

    self:Explode()

    timer.Simple(1.1, function ()
        self:Remove()
    end)
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    self:DrawModel()
end