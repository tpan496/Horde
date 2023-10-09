function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    local pos = effect_data:GetOrigin()
    local scale = effect_data:GetScale() or 1
    local normal = Vector(0,0,1)
    self.emitter = ParticleEmitter(pos, true)
    local ringstart = pos + Vector(0,0,1) * 10
    local particle
	for i=1, 3 do
		particle = self.emitter:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.5 + i * 0.1)
		particle:SetColor(149, 200, 216)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(250 * scale)
		particle:SetAngles(normal:Angle())
	end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end