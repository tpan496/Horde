function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.entity = effect_data:GetEntity()
	self.radius = effect_data:GetRadius()
	self.height = effect_data:GetMagnitude()
end

-- Bubbles
function EFFECT:Think()
    if not self.entity or not self.entity:IsValid() then return true end
	if self.entity:GetNWBool("HasShield") == false then return true end
    
	local pos = self.entity:GetPos()
    pos.z = pos.z + self.height / 2
    if not self.emitter then
        self.emitter = ParticleEmitter(pos, true)
    end

    if self.emitter then
		local normal = Vector(0,0,1)
        local particle = self.emitter:Add("effects/select_ring", pos)
		particle:SetVelocity(Vector(0,0,0))
		particle:SetDieTime(0.1)
		particle:SetStartAlpha(50)
		particle:SetStartSize(self.radius + 5)
		particle:SetEndSize(self.radius + 5)
		particle:SetColor(200,200,200)
		particle:SetAngles(normal:Angle())
    end

    return true
end

function EFFECT:Render()
end