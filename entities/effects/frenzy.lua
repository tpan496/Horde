function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.entity = effect_data:GetEntity()
    self.ticks = 0
end

-- Bubbles
function EFFECT:Think()
    if not self.entity or not self.entity:IsValid() then return true end
    local pos = self.entity:GetPos()
    if not self.emitter then
        self.emitter = ParticleEmitter(pos)
    end

    if self.emitter then
        local particle = self.emitter:Add("effects/splash2", pos)
        particle:SetDieTime(0.25)
        particle:SetColor(200, 50, 50)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(0)
        particle:SetStartSize(6)
        particle:SetEndSize(6)
        particle:SetStartLength(0)
        particle:SetEndLength(45)
        particle:SetVelocity(VectorRand():GetNormal() * 220)
    end

    return true
end

function EFFECT:Render()
end