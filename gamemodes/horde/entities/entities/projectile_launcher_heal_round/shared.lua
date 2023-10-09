ENT.Type 				= "anim"
ENT.Base 				= "base_entity"
ENT.PrintName 			= "HE Round"
ENT.Author 				= ""
ENT.Information 		= ""

ENT.Spawnable 			= false


AddCSLuaFile()

ENT.Model = "models/items/ar2_grenade.mdl"
ENT.Ticks = 0
ENT.FuseTime = 10
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CollisionGroupType = COLLISION_GROUP_PROJECTILE
ENT.Removing = nil

if SERVER then

function ENT:Initialize()
    local pb_vert = 1
    local pb_hor = 1
    self:SetModel(self.Model)
    self:PhysicsInitBox( Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor) )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.SpawnTime = CurTime()

    timer.Simple(0.1, function()
        if !IsValid(self) then return end
        self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
    end)
end

function ENT:Think()
    if SERVER and CurTime() - self.SpawnTime >= self.FuseTime then
        self:Detonate()
    end
end

else

function ENT:Think()
end

end

function ENT:Detonate()
    if !self:IsValid() or self.Removing then return end
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos())
    effectdata:SetRadius(225)
    util.Effect("horde_heal_mist", effectdata)
    self:EmitSound("horde/player/life_diffuser.ogg", 90, 100, 1, CHAN_AUTO)

    for _, ent in pairs(ents.FindInSphere(self:GetPos(), 200)) do
        if ent:IsPlayer() then
            local healinfo = HealInfo:New({amount=25, healer=self.Owner})
            HORDE:OnPlayerHeal(ent, healinfo)
        elseif ent:GetClass() == "npc_vj_horde_antlion" then
            local healinfo = HealInfo:New({amount=25, healer=self.Owner})
            HORDE:OnAntlionHeal(ent, healinfo)
        elseif ent:IsNPC() then
            local dmg = DamageInfo()
            dmg:SetDamage(75)
            dmg:SetDamageType(DMG_NERVEGAS)
            dmg:SetAttacker(self.Owner)
            dmg:SetInflictor(self)
            dmg:SetDamagePosition(self:GetPos())
            ent:TakeDamageInfo(dmg)
        end
    end

    self.Removing = true
    self:Remove()
end

function ENT:PhysicsCollide(colData, collider)
    self:Detonate()
end

function ENT:Draw()
    self:DrawModel()
end