if not ArcCWInstalled then return end
-- Referenced From GSO
ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Medic Dart"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = "models/shells/shell_9mm.mdl"
ENT.IsRemoving = false

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetModel(self.Model)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInitBox(Vector(-0.5, -0.5, -0.5), Vector(0.5,0.5,0.5))
        self:PhysicsInit(SOLID_VPHYSICS)

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
        local ent = data.HitEntity
        print(ent)
        if ent:IsValid() then
            if ent == self.Owner then return end
            if ent:IsPlayer() then
                HORDE:OnPlayerHeal(ent, HealInfo:New({amount=50, healer=self.Owner}))
            elseif (not ent:GetNWEntity("HordeOwner")) then
                local dmginfo = DamageInfo()
                dmginfo:SetAttacker(self.Owner)
                dmginfo:SetInflictor(self.Inflictor)
                dmginfo:SetDamageType(DMG_NERVEGAS)
                dmginfo:SetDamage(50)
                ent:TakeDamageInfo(dmginfo)
            end
        end
        self:Remove()
        self.IsRemoving = true
    end
end

function ENT:OnRemove()
    if CLIENT then
        local emitter = ParticleEmitter(self:GetPos())
        local smoke = emitter:Add("particles/smokey", self:GetPos())
        smoke:SetGravity( Vector(0, 0, 1500) )
        smoke:SetDieTime( math.Rand(0.5, 1) )
        smoke:SetStartAlpha(75)
        smoke:SetEndAlpha(0)
        smoke:SetStartSize(10)
        smoke:SetEndSize(50)
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor(50, 200, 50)
        smoke:SetAirResistance(1000)
        smoke:SetPos( self:GetPos() )
        smoke:SetLighting( false )
        smoke:SetCollide(true)
        smoke:SetBounce(0)
    end
end

function ENT:DrawTranslucent()
    self:Draw()
end

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
    end
end