function EFFECT:Init(effect_data)
    local pos = effect_data:GetOrigin()
    local radius = 5
    local emitter = ParticleEmitter(pos)
    local smoke

    for i = 1, math.random(1,50) do
        smoke = emitter:Add("effects/slime1", pos)
        smoke:SetPos(pos + VectorRand() * 10)
        smoke:SetGravity( Vector(0, 0, math.random(1000, 1500) ))
        smoke:SetVelocity(VectorRand() * 50)
        smoke:SetDieTime( math.Rand(0.5, 1) )
        smoke:SetStartAlpha(math.random(100, 200))
        smoke:SetEndAlpha(0)
        smoke:SetStartSize(5)
        smoke:SetEndSize(radius)
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor(200, 50, 200)
        smoke:SetAirResistance(1000)
        smoke:SetLighting(false)
        smoke:SetCollide(true)
        smoke:SetBounce(0)
    end

    emitter:Finish()
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end