function EFFECT:Init(data)
    local radius = data:GetRadius()

    local emitter = ParticleEmitter(data:GetOrigin())
    local smoke = emitter:Add("particles/smokey", data:GetOrigin())
    smoke:SetGravity( Vector(0, 0, 1500) )
    smoke:SetDieTime(0.5)
    smoke:SetStartAlpha(150)
    smoke:SetEndAlpha(0)
    smoke:SetStartSize(10)
    smoke:SetEndSize(radius)
    smoke:SetRoll( math.Rand(-180, 180) )
    smoke:SetRollDelta( math.Rand(-0.2,0.2) )
    smoke:SetColor(200, 50, 50)
    smoke:SetAirResistance(1000)
    smoke:SetPos( data:GetOrigin() )
    smoke:SetLighting( false )
    smoke:SetCollide(true)
    smoke:SetBounce(0)
    emitter:Finish()
end

function EFFECT:Think()
return false
end

function EFFECT:Render()
end