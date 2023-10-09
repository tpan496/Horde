function EFFECT:Think()
    if not self.emitter then
        self.emitter = ParticleEmitter()
    end

    if self.emitter then
        local particle = self.emitter:Add("sprites/glow04_noz")
        particle:SetDieTime(0.1)
        particle:SetColor(255,0,0)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(255)
        particle:SetStartSize(10)
        particle:SetEndSize(10)
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