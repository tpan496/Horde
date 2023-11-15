include("shared.lua")

local auras = auras or {}

function ENT:Initialize()
	auras[self] = true
end

function ENT:OnRemove()
	auras[self] = nil
end

local col = Color(0,255,100,100)
hook.Add( "PreDrawRings", "DrawWardenRings", function()
	if next( auras ) == nil then return end
	local set = {}
	for aura in pairs(auras) do
		table.insert(set,{aura, aura:GetRadius() or 160, 5, 30})
	end
	rings.AddSet( set , col)
end)

function ENT:Draw()
end
