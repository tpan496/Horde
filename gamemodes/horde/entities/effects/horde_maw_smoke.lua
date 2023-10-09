function EFFECT:Init(effect_data)
    local pos = effect_data:GetOrigin()
    local radius = 100
    local emitter = ParticleEmitter(pos)
    local smoke = emitter:Add("particles/smokey", pos)
    smoke:SetGravity( Vector(0, 0, 0) )
    smoke:SetDieTime( math.Rand(0.5, 1) )
    smoke:SetStartAlpha(255)
    smoke:SetEndAlpha(0)
    smoke:SetStartSize(10)
    smoke:SetEndSize(radius)
    smoke:SetRoll( math.Rand(-180, 180) )
    smoke:SetRollDelta( math.Rand(-0.2,0.2) )
    smoke:SetColor(100, 100, 100)
    smoke:SetAirResistance(1000)
    smoke:SetPos(self:GetPos())
    smoke:SetLighting(false)
    smoke:SetCollide(true)
    smoke:SetBounce(0)
    emitter:Finish()
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end