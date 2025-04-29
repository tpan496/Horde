include("shared.lua")

local auras = auras or {}

function ENT:Initialize()
	-- Display only one sphere for local client. Sphere renders are extremely dank and costly
    if self:GetParent() == LocalPlayer() then
        auras[self] = true
    end
end

function ENT:OnRemove()
	auras[self] = nil
end

hook.Add( "PreDraw_ImmersionBreakingCircles", "Draw_PresenceCircle", function()
	if next(auras) == nil then return end
	for aura in pairs(auras) do
        --if not aura:GetParent() == LocalPlayer() then continue end
        HORDE.MaskedSphereRing(aura:GetPos(), aura:GetCircleRadius() + 20, 16, 4, Color(32, 0, 56, 100))
    end
end)
