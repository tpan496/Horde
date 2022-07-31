function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.entity = effect_data:GetEntity()
    self.radius = effect_data:GetRadius()
    self.height = effect_data:GetMagnitude()
end

-- Instable pulse
function EFFECT:Think()
    if not self.entity or not self.entity:IsValid() then return true end
    if not self.entity.Horde_Mutation_Nemesis then return false end
    local pos = self.entity:GetPos()
    pos.z = pos.z + self.height / 2

    if not self.emitter then
        self.emitter = ParticleEmitter(pos)
    end

    if self.emitter then
        local particle = self.emitter:Add("sprites/glow04_noz", pos)
        particle:SetDieTime(0.1)
        particle:SetColor(200,50,200)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(255)
        particle:SetStartSize(self.radius)
        particle:SetEndSize(self.radius)
        particle:SetVelocity(Vector(0,0,0))
        particle:SetGravity(Vector(0,0,0))
        particle:SetCollide(false)
        particle:SetBounce(0)
        particle:SetAirResistance(0)
    end

    return true
end

function EFFECT:Render()
end