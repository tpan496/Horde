include('shared.lua')

language.Add("obj_vj_horde_homing_lightning", "Xen Psychic Unit")
local mat = Material("sprites/orangeflare1")
local col = Color(255, 141, 15, 255)
function ENT:Draw()
	local scale = self:GetNetworkedInt("scale") * math.random(20, 50)
	self:DrawModel()
	local pos = self:GetPos()
	render.SetMaterial(mat)
	
	local color = render.GetLightColor(pos) *2
	color.x = col.r * math.Clamp(color.x, 0, 1)
	color.y = col.g * math.Clamp(color.y, 0, 1)
	color.z = col.b * math.Clamp(color.z, 0, 1)
	
	render.DrawSprite(pos, scale, scale, color)
end
