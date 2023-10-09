function EFFECT:Init(effect_data)
    local pos = effect_data:GetOrigin()
    local radius = effect_data:GetRadius() or 300
    local emitter = ParticleEmitter(pos)
    local smoke = emitter:Add("effects/electrical_arc", pos)
    smoke:SetGravity( Vector(0, 0, 0) )
    smoke:SetDieTime( math.Rand(0.25, 0.5) )
    smoke:SetStartAlpha(255)
    smoke:SetEndAlpha(200)
    smoke:SetStartSize(25)
    smoke:SetEndSize(20)
    smoke:SetRoll( math.Rand(-180, 180) )
    smoke:SetRollDelta( math.Rand(250, 350) )
    smoke:SetColor(255, 255, 100)
    --smoke:SetAirResistance(1000)
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