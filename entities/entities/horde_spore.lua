AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
self.Entity:DrawModel()
end

function ENT:Initialize()
self.Entity:SetModel( "models/horde/spore/spore.mdl" )
self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
self.Entity:SetSolid( SOLID_VPHYSICS )
self.Entity:PhysicsInit( SOLID_VPHYSICS )
self.Entity:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
self.Entity:DrawShadow( false )
self.ExplodeTimer = CurTime() + 2
ParticleEffectAttach("vj_acid_idle", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()
if SERVER and (self.ExplodeTimer <= CurTime() or self.Entity:WaterLevel() > 0) then
self.Entity:Remove()
end
end

function ENT:PhysicsCollide( data )
if SERVER then
self.Entity:Remove()
end
end

function ENT:OnRemove()
if SERVER then
    ParticleEffect("antlion_gib_01_juice", self:GetPos(), Angle(0,0,0), nil)
    local e = EffectData()
    e:SetOrigin(self:GetPos())
    util.Effect("spore_explosion", e, true, true)
    ParticleEffect("antlion_gib_02_floaters", self:GetPos(), Angle(0,0,0), nil)
end

if SERVER then
    local dmg = DamageInfo()
    dmg:SetAttacker(self.Owner)
    dmg:SetInflictor(self)
    dmg:SetDamageType(DMG_NERVEGAS)
    dmg:SetDamage(150)
    dmg:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
    util.BlastDamageInfo(dmg, self:GetPos(), 150)
    for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
        if ent:IsPlayer() then
            local healinfo = HealInfo:New({amount=20, healer=self.Owner})
            HORDE:OnPlayerHeal(ent, healinfo)
        elseif ent:GetClass() == "npc_vj_horde_antlion" then
            local healinfo = HealInfo:New({amount=20, healer=self.Owner})
            HORDE:OnAntlionHeal(ent, healinfo)
        end
    end
end
self.Entity:EmitSound( "Weapon_HLOF_Spore_Launcher.Impact" )
end