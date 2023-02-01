AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2

function ENT:Initialize()
    timer.Simple(20, function ()
        if self:IsValid() then
            self:Remove()
        end
    end)
end