ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "Biological Capsule"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/weapons/w_bugbait.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0
ENT.BaseDamage = 25
ENT.BaseSplashDamage = 10

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    if SERVER then
    self:SetModel(self.Model)
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    
    self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    self.ExplodeTimer = CurTime() + 2
    self.StartTime = CurTime()

    self.BaseDamage = self.BaseDamage + 3 * self.properties.level
    self.BaseSplashDamage = self.BaseSplashDamage + 4 * self.properties.level
    end

    ParticleEffectAttach("vj_acid_idle", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Charged" )
end

function ENT:Detonate(hitpos, ent)
    if !self:IsValid() or self.Removing then return end

    local attacker = self

    if self.Owner:IsValid() then
        attacker = self.Owner
    end

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    local pos = colData.HitPos

	--ParticleEffect("antlion_gib_02_floaters", pos, Angle(0,0,0), nil)
	--ParticleEffect("antlion_gib_01_juice", pos, Angle(0,0,0), nil)
    sound.Play("weapons/bugbait/bugbait_impact1.wav", pos, 100, math.random(90, 110))

    if HORDE.player_drop_entities[self.Owner:SteamID()] then
        for id, ent in pairs(HORDE.player_drop_entities[self.Owner:SteamID()]) do
            if ent:IsNPC() and ent:GetClass() == "npc_vj_horde_antlion" then
                ent:RangeAttackLocation(pos)
            end
        end
    end

    for _,ent in pairs(ents.FindInSphere(self:GetPos(), 150)) do
        if ent:GetClass() == "npc_vj_horde_antlion" then
            local healinfo = HealInfo:New({amount=0.05 * ent:GetMaxHealth(), healer=self.Owner})
            HORDE:OnAntlionHeal(ent, healinfo)
        end
    end

    self:Detonate(pos, colData.HitEntity)
end

function ENT:Draw()
    self:DrawModel()
end