function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.entity = effect_data:GetEntity()
    self.radius = effect_data:GetRadius()
    self.ticks = 0
end

-- Bubbles
function EFFECT:Think()
	if not self.entity or not self.entity:IsValid() then return true end
	if not self.entity.Horde_Mutation_Decay and IsValid(self.emitter) then self.emitter:Finish() return false end
    local pos = self.entity:GetPos()
    if not self.emitter then
        self.emitter = ParticleEmitter(pos)
        self.emitter:SetNearClip(24, 32)
    end

    if self.emitter then
		local particle = self.emitter:Add("particle/sparkles", pos + VectorRand() * self.radius)
		particle:SetDieTime(0.25)
		particle:SetColor(50,225,50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(2)
		particle:SetEndSize(2)
		particle:SetVelocity(Vector(0,0,0))
		particle:SetGravity(VectorRand(0,0,0))
		particle:SetCollide(true)
		particle:SetBounce(0.75)
        particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-10, 10))
		particle:SetAirResistance(250)
	end

    return true
end

function EFFECT:Render()
end