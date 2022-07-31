ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_WORLD
ENT.CollisionGroupType = COLLISION_GROUP_WORLD
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0
ENT.BaseDamage = 10
ENT.DamageTimer = 0

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:Initialize()
    if SERVER then
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInitSphere( 64 )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:EnableGravity(false)
        phys:SetMass(1)
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    self.SearchTimer = CurTime() + 0.2

    self:SetCollisionGroup(COLLISION_GROUP_WORLD)

    self.ExplodeTimer = CurTime() + 5

    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetColor(Color(0,0,0,0))
    self.StartTime = CurTime()
    self.AttachedToTarget = nil

    self.BaseDamage = self.BaseDamage

    timer.Simple(0.5, function ()
        if not self:IsValid() then return end
        self.Active = true
        if (!IsValid( phys )) then self:Remove() return end
        phys:SetVelocity(Vector(0,0,0))
        self:SetCollisionGroup(COLLISION_GROUP_WORLD)
        self:SetMoveType(MOVETYPE_NONE)
    end)
    end

    if CLIENT then
    timer.Simple(0, function ()
        if not self:IsValid() then return end
        ParticleEffectAttach("dirac_star", PATTACH_ABSORIGIN_FOLLOW, self, 0)
    end)
    end
end

function ENT:Think()
    if SERVER and self.PlaySoundTimer <= CurTime() then
        self.PlaySoundTimer = CurTime() + 0.1
    end

    if SERVER then
        if self.ExplodeTimer <= CurTime() then
            self:Remove()
            return
        end
        if self.Active and self.DamageTimer <= CurTime() then
            self.DamageTimer = CurTime() + 0.5

            ParticleEffect("dirac_star_attract", self:GetPos(), Angle(0,0,0))
	        sound.Play("horde/weapons/nether_relic/dirac_sea.ogg", self:GetPos(), 100, math.random(50, 70))

            for _, ent in pairs(ents.FindInSphere(self:GetPos(), 300)) do
                if ent:IsNPC() and HORDE:IsPlayerOrMinion(ent) ~= true then
                    --ent:TakeDamageInfo(dmginfo)
                    --dmginfo:SetDamagePosition(ent:GetPos())
                    --callback(ent)
                    local dir = self:GetPos() - ent:GetPos()
                    dir:Normalize()
                    dir.z = 0
                    local v = math.min(300, self:GetPos():Distance(ent:GetPos()))
                    ent:SetVelocity(dir * v * 20)
                end
            end
        end
    end
end

function ENT:OnRemove()
end

--[[function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end

    self:Detonate()
end]]--

function ENT:Draw()
    self:DrawModel()
end