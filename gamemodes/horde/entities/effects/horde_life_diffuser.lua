function EFFECT:Init(data)
    local radius = data:GetRadius()

    local emitter = ParticleEmitter(data:GetOrigin())
    local emitter2 = ParticleEmitter(data:GetOrigin(), true)
    emitter2:SetNearClip(24, 32)
    for i = 1,10 do
        local smoke = emitter:Add("particles/smokey", data:GetOrigin())
        smoke:SetGravity(Vector(0,0,-800))
        smoke:SetDieTime(radius/225)
        smoke:SetStartAlpha(150)
        smoke:SetEndAlpha(0)
        smoke:SetStartSize(10)
        smoke:SetEndSize(radius * math.random(0.5,1))
        smoke:SetRoll( math.Rand(-180, 180) )
        smoke:SetRollDelta( math.Rand(-0.2,0.2) )
        smoke:SetColor(50, 200, 50)
        smoke:SetAirResistance(0)
        local p = VectorRand() * 50
        p.z = 0
        smoke:SetPos( data:GetOrigin() + p)
        smoke:SetLighting( false )
        smoke:SetCollide(true)
        smoke:SetBounce(0)
    end
    emitter:Finish()

    local normal = Vector(0,0,1)
    local ringstart = data:GetOrigin() + normal * 10
    local particle
    for i=1, 2 do
        particle = emitter2:Add("effects/select_ring", ringstart)
        particle:SetDieTime(0.5 + i * 0.2)
        particle:SetColor(50, 200, 50)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(0)
        particle:SetStartSize(0)
        particle:SetEndSize(radius)
        particle:SetAngles(normal:Angle())
    end
    emitter2:Finish()
end

function EFFECT:Think()
return false
end

function EFFECT:Render()
end