if CLIENT then
    killicon.AddAlias("projectile_horde_antlion_bile", "npc_vj_horde_antlion")
end
ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "Antlion Bile"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/vj_base/projectiles/spit_acid_medium.mdl"
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_PLAYER
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0

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
        phys:SetBuoyancyRatio(0)
        phys:EnableDrag(false)
        phys:SetMass(0)
    end

    self.SpawnTime = CurTime()
    self.PlaySoundTimer = CurTime()
    self.StartPos = self:GetPos()
    
    --self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
    self.ExplodeTimer = CurTime() + 2
    self.StartTime = CurTime()
    end

    ParticleEffectAttach("vj_acid_idle", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Charged" )
end

function ENT:Detonate(hitpos, ent)
    if !self:IsValid() or self.Removing then return end

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    if !self:IsValid() or self.Removing then return end
    if not self.Owner:IsValid() then 
        self.Removing = true
        self:Remove()
        return 
    end
    local pos = colData.HitPos

    local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	effectdata:SetScale( 1 )
    effectdata:SetDamageType(0)
	util.Effect("horde_virus_mist",effectdata)
	--ParticleEffect("antlion_gib_02_floaters", pos, Angle(0,0,0), nil)
    sound.Play("horde/antlion/bile.ogg", pos, 100, math.random(90, 110))

    --[[
    if not self.Owner then self.Owner = self end
    
    local dmg = DamageInfo()
    dmg:SetDamage(self.BaseDamage)
    dmg:SetDamageType(DMG_NERVEGAS)
    if self.Owner:IsValid() then
        dmg:SetAttacker(self.Owner)
    else
        dmg:SetAttacker(Entity(0))
    end
    
    dmg:SetInflictor(self)
    dmg:SetDamagePosition(pos)
    dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
    util.BlastDamageInfo(dmg, pos, 150)
    ]]
    
    HORDE.RadiusDamageExtra({
        attacker = self.Owner, 
        inflictor = self,
        radius = 150,
        falloffradius = 50,
        falloff_cap = 0,
        damage = self.BaseDamage,
        basedamagemul = 0,
        fallofftype = "linear",
        falloff_speed = 1,
        ignoreattacker = true,
        origin = pos,
        damagetype = 65536, -- DMG_NERVEGAS
    })
    
    local healer = self.Owner
    if self.Owner:GetNWEntity("HordeOwner"):IsValid() then
        healer = self.Owner:GetNWEntity("HordeOwner")
    end
    for _, ent in pairs(ents.FindInSphere(self:GetPos(), 150)) do
        if ent:IsPlayer() then
            local healinfo = HealInfo:New({amount=ent:GetMaxHealth() * 0.05, healer=healer})
            HORDE:OnPlayerHeal(ent, healinfo)
        elseif ent:GetClass() == "npc_vj_horde_antlion" then
            ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + ent:GetMaxHealth() * 0.05))
            --local healinfo = HealInfo:New({amount=ent:GetMaxHealth() * 0.05, healer=healer})
            --HORDE:OnAntlionHeal(ent, healinfo)
        end
    end

    self:Detonate(pos, colData.HitEntity)
end

function ENT:Draw()
    self:DrawModel()
end