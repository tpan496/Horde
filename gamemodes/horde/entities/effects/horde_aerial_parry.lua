function EFFECT:Init(data)
    local emitter2 = ParticleEmitter(data:GetOrigin())
    emitter2:SetNearClip(24, 32)
    local ringstart = data:GetOrigin()
    local particle
    for i=1, 2 do
        particle = emitter2:Add("effects/select_ring", ringstart)
        particle:SetDieTime(0.25 + i * 0.2)
        particle:SetColor(255, 255, 0)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(0)
        particle:SetStartSize(0)
        particle:SetEndSize(50)
    end
    emitter2:Finish()
end

function EFFECT:Think()
return false
end

function EFFECT:Render()
end