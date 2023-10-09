AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()

    if IsMounted("cstrike") then
        self:SetModel("models/props/cs_assault/Money.mdl")
        self:PhysicsInitBox(Vector(-1, -1, -1), Vector(1, 1, 1))
    else
        self:SetColor(Color(0, 255, 0))
        self:SetModel("models/items/flare.mdl")
        self:PhysicsInitBox(Vector(-1, -1, -1), Vector(1, 1, 1))
    end

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetModelScale(2)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)

    self.Removing = false
    self:PhysWake()

    timer.Simple(10, function ()
        if self:IsValid() then
            self:Remove()
        end
    end)
end

function ENT:SetMoney(money)
    self.Horde_Money = money
end

function ENT:StartTouch(entity)
    if not self.Removing and entity:IsPlayer() and entity:Alive() and entity ~= self:GetOwner() and (not entity:IsBot()) then
        self.Removing = true
        entity:Horde_AddMoney(self.Horde_Money or 50)
        entity:Horde_SyncEconomy()
        entity:EmitSound("horde/dosh/dosh_" .. math.random(1, 4) .. ".ogg", 70, 100, 0.25)
        self:Remove()
    end
end
