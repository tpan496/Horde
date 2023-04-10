function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.entity = effect_data:GetEntity()
    self.radius = effect_data:GetRadius()
end

-- Bubbles
function EFFECT:Think()
    if not self.entity or not self.entity:IsValid() then return true end
    if not self.entity.Horde_Mutation_Regenerator  and IsValid(self.emitter) then self.emitter:Finish() return false end
    local pos = self.entity:GetPos()
    if not self.emitter then
        self.emitter = ParticleEmitter(pos)
    end
    if self.emitter then
        local disp = VectorRand()
        disp.z = 0
        local particle = self.emitter:Add("particle/sparkles", pos + disp * self.radius)
        particle:SetDieTime(1)
        particle:SetColor(200,50,50)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(0)
        particle:SetStartSize(1)
        particle:SetEndSize(1)
        particle:SetVelocity(Vector(0,0,1) * 100)
        particle:SetGravity(Vector(0,0,0))
        particle:SetCollide(false)
        particle:SetBounce(0)
        particle:SetAirResistance(0)
    end

    return true
end

function EFFECT:Render()
end