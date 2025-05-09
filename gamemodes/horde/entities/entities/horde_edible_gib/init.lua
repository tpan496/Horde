AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.gib_models = {"models/gibs/humans/mgib_01.mdl","models/gibs/humans/mgib_02.mdl", "models/gibs/humans/mgib_03.mdl", "models/gibs/humans/mgib_04.mdl", "models/gibs/humans/brain_gib.mdl", "models/gibs/humans/heart_gib.mdl", "models/gibs/humans/lung_gib.mdl", "models/gibs/humans/liver_gib.mdl"}

function ENT:Initialize()
    self:SetModel(self.gib_models[math.random(#self.gib_models)])
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)
    self:PhysWake()
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    timer.Simple(5, function ()
        if self:IsValid() then
            self:Remove()
        end
    end)
end

function ENT:StartTouch(ent)
    if ent:IsPlayer() then
        local healinfo = HealInfo:New({amount=ent:GetMaxHealth() * 0.1, healer=self.Owner})
        HORDE:OnPlayerHeal(ent, healinfo)
        sound.Play("horde/gadgets/yummy.ogg", self:GetPos())
        self:Remove()
    end
end