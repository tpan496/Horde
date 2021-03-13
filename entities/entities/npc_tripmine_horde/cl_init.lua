include("shared.lua")
killicon.AddAlias("npc_tripmine_horde", "npc_tripmine")
killicon.AddAlias("weapon_slam", "npc_tripmine")

local lmat = Material("trails/laser")
local color_armed, color_enemy = Color(0, 200, 200), Color(255, 0, 0)

function ENT:DrawLaser()
    if not self.Armed or not self.TraceEnd then return end
    render.SetMaterial(lmat)
    if self:GetTriggered() then
        render.DrawBeam(self.TraceStart, self.TraceEnd, 7, 1, 1, color_enemy)
    else
        render.DrawBeam(self.TraceStart, self.TraceEnd, 7, 1, 1, color_armed)
    end
end