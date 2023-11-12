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
	rings.SetColor(col)
	for ent,bool in pairs( auras ) do
		if not IsValid(ent) then continue end
		rings.Add(ent, ( ent:GetRadius() or 160 ), 5, 30)
	end
end)

function ENT:Draw()
end
