AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    self:SetModel("models/props_lab/crematorcase.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetModelScale(1)
    self:PhysWake()
end

function ENT:Use(activator)
    if not self.Horde_Payload_Spawn then return end
    if activator:IsPlayer() then
        if activator:Horde_HasPayload() then
            HORDE:SendNotification("You are already carrying something.", 1, self)
            return
        end
        activator:Horde_SetPayloadSpawn(self.Horde_Payload_Spawn)
        self:Remove()
    end
end

