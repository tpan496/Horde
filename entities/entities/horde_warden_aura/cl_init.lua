include("shared.lua")

local auras = auras or {}

function ENT:Initialize()
	-- Display only one sphere for local client. Sphere renders are extremely dank and costly
    if self:GetParent() == LocalPlayer() or self:GetParent():GetNWEntity("HordeOwner") == LocalPlayer() then
        auras[self] = true
    end
end

function ENT:OnRemove()
	auras[self] = nil
end

hook.Add( "PreDraw_ImmersionBreakingCircles", "Draw_WardenAuraCircle", function()
	if next(auras) == nil then return end
	for aura in pairs(auras) do
        --if not aura:GetParent() == LocalPlayer() or not aura:GetParent():GetNWEntity("HordeOwner") == LocalPlayer() then continue end
        if aura:GetIsDisplayingCircleRadius() == 1 then
            HORDE.MaskedSphereRing(aura:GetPos(), aura:GetCircleRadius() + 20, 16, 4, Color(0, 0, 100, 100))
            --print(aura:GetParent():GetNWEntity("HordeOwner") == LocalPlayer())
        end
    end
end)
