AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.gib_models = {
    "models/vj_base/gibs/human/gib1.mdl",
    "models/vj_base/gibs/human/gib2.mdl", 
    "models/vj_base/gibs/human/gib3.mdl", 
    "models/vj_base/gibs/human/gib4.mdl", 
    "models/vj_base/gibs/human/gib5.mdl",
    "models/vj_base/gibs/human/gib6.mdl",
    "models/vj_base/gibs/human/gib7.mdl",
    "models/vj_base/gibs/human/brain.mdl", 
    "models/vj_base/gibs/human/heart.mdl", 
    "models/vj_base/gibs/human/lung.mdl", 
    "models/vj_base/gibs/human/liver.mdl",
    }

function ENT:Initialize()
    self:SetModel(self.gib_models[math.random(#self.gib_models)])
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)
    self:PhysWake()
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    timer.Simple(15, function ()
        if self:IsValid() then
            self:Remove()
        end
    end)
end

function ENT:StartTouch(ent)
    if ent:IsPlayer() then
        if ent:Health() >= ent:GetMaxHealth() then return end
        local healinfo = HealInfo:New({amount=5, healer=self.Owner})
        HORDE:OnPlayerHeal(ent, healinfo)
        sound.Play("horde/gadgets/yummy.ogg", self:GetPos())
        self:Remove()
    end
end