function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    local pos = effect_data:GetOrigin()
    local scale = effect_data:GetScale() or 1
    local normal = VectorRand()
    self.emitter = ParticleEmitter(pos, true)
    local ringstart = pos
    local particle
	for i=1, 2 do
		particle = self.emitter:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.5 + i * 0.1)
		particle:SetColor(255, 200, 200)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(150)
		particle:SetAngles(normal:Angle())
	end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end