function EFFECT:Init(ed)

    local vOrig = ed:GetOrigin()
    local normal = ed:GetNormal()
    local radius = ed:GetRadius()
    self.Emitter = ParticleEmitter(vOrig)
    local emitter2 = ParticleEmitter(vOrig, true)
    --sound.Play("ambient/explosions/explode_4.wav", vOrig, 80, math.random(70, 90))

    for i=1,8 do
        local flash = self.Emitter:Add("effects/combinemuzzle2_dark", vOrig)
        if (flash) then
            flash:SetColor(150, 0, 0)
            flash:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            flash:SetRoll(math.Rand(0, 360))
            flash:SetDieTime(0.1)
            flash:SetLifeTime(0)
            flash:SetStartSize(0)
            flash:SetStartAlpha(150)
            flash:SetEndSize(radius)
            flash:SetEndAlpha(0)
            flash:SetGravity(Vector(0,0,0))
        end

        local quake = self.Emitter:Add("effects/splashwake3", vOrig)
        if (quake) then
            quake:SetColor(150, 0, 0)
            quake:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            quake:SetRoll(math.Rand(0, 360))
            quake:SetDieTime(0.2)
            quake:SetLifeTime(0)
            quake:SetStartSize(0)
            quake:SetStartAlpha(150)
            quake:SetEndSize(radius + 25)
            quake:SetEndAlpha(0)
            quake:SetGravity(Vector(0,0,0))
        end
    end

    local ringstart = vOrig + normal * 10
    local particle
    for i=1, 3 do
        particle = emitter2:Add("effects/select_ring", ringstart)
        particle:SetDieTime(0.1 + i * 0.1)
        particle:SetColor(150, 0, 0)
        particle:SetStartAlpha(150)
        particle:SetEndAlpha(0)
        particle:SetStartSize(0)
        particle:SetEndSize(radius + 25)
        particle:SetAngles(normal:Angle())
        particle = emitter2:Add("effects/select_ring", ringstart)
        particle:SetDieTime(0.2 + i * 0.1)
        particle:SetColor(150, 0, 0)
        particle:SetStartAlpha(150)
        particle:SetEndAlpha(0)
        particle:SetStartSize(0)
        particle:SetEndSize(radius + 25)
        particle:SetAngles(normal:Angle())
    end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end