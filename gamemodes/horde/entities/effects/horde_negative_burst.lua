function EFFECT:Init(ed)

    local vOrig = ed:GetOrigin()
    self.Emitter = ParticleEmitter(vOrig)
    local emitter2 = ParticleEmitter(vOrig, true)
    local normal = Vector(0,0,1)
    local radius = ed:GetRadius()
    sound.Play("sound/horde/spells/negative_burst.ogg", vOrig, 80, math.random(70, 90), 0.75)

    --sound.Play("horde/weapons/nether_relic/nether_star_explode.ogg", vOrig, 100, math.random(70, 90))

    for i=1,72 do
        local sparks = self.Emitter:Add("effects/spark", vOrig)
        if (sparks) then
            sparks:SetColor(0, 200, 200)
            sparks:SetVelocity(VectorRand():GetNormal()*math.random(400, 600))
            sparks:SetRoll(math.Rand(0, 360))
            sparks:SetRollDelta(math.Rand(-2, 2))
            sparks:SetDieTime(2)
            sparks:SetLifeTime(0)
            sparks:SetStartSize(3)
            sparks:SetStartAlpha(255)
            sparks:SetStartLength(15)
            sparks:SetEndLength(3)
            sparks:SetEndSize(3)
            sparks:SetEndAlpha(255)
            sparks:SetGravity(Vector(0,0,-800))
        end

        local sparks2 = self.Emitter:Add("effects/spark", vOrig)
        if (sparks2) then
            sparks2:SetColor(0, 200, 200)
            sparks2:SetVelocity(VectorRand():GetNormal()*math.random(500, 900))
            sparks2:SetRoll(math.Rand(0, 360))
            sparks2:SetRollDelta(math.Rand(-2, 2))
            sparks2:SetDieTime(0.4)
            sparks2:SetLifeTime(0)
            sparks2:SetStartSize(5)
            sparks2:SetStartAlpha(255)
            sparks2:SetStartLength(80)
            sparks2:SetEndLength(0)
            sparks2:SetEndSize(5)
            sparks2:SetEndAlpha(0)
            sparks2:SetGravity(Vector(0,0,0))
        end
    end

    for i=1,8 do
        local flash = self.Emitter:Add("effects/combinemuzzle2_dark", vOrig)
        if (flash) then
            flash:SetColor(0, 255, 255)
            flash:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            flash:SetRoll(math.Rand(0, 360))
            flash:SetDieTime(0.10)
            flash:SetLifeTime(0)
            flash:SetStartSize(170)
            flash:SetStartAlpha(radius / 1.2)
            flash:SetEndSize(180)
            flash:SetEndAlpha(0)
            flash:SetGravity(Vector(0,0,0))		
        end

        local quake = self.Emitter:Add("effects/splashwake3", vOrig)
        if (quake) then
            quake:SetColor(0, 200, 200)
            quake:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            quake:SetRoll(math.Rand(0, 360))
            quake:SetDieTime(0.10)
            quake:SetLifeTime(0)
            quake:SetStartSize(0)
            quake:SetStartAlpha(200)
            quake:SetEndSize(radius * 1.2)
            quake:SetEndAlpha(0)
            quake:SetGravity(Vector(0,0,0))		
        end

        local wave = self.Emitter:Add("sprites/heatwave", vOrig)
        if (wave) then
            wave:SetColor(0, 200, 200)
            wave:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            wave:SetRoll(math.Rand(0, 360))
            wave:SetDieTime(0.5)
            wave:SetLifeTime(0)
            wave:SetStartSize(200)
            wave:SetStartAlpha(255)
            wave:SetEndSize(radius)
            wave:SetEndAlpha(0)
            wave:SetGravity(Vector(0,0,0))
        end
    end

    local ringstart = vOrig + normal * 10
    local particle
    for i=1, 4 do
        particle = emitter2:Add("effects/splashwake3", ringstart)
        particle:SetDieTime(0.1 + i * 0.2)
        particle:SetColor(0, 200, 200)
        particle:SetStartAlpha(150)
        particle:SetEndAlpha(0)
        particle:SetStartSize(0)
        particle:SetEndSize(radius)
        particle:SetAngles(normal:Angle())
        particle = emitter2:Add("effects/splashwake3", ringstart)
        particle:SetDieTime(0.2 + i * 0.2)
        particle:SetColor(0, 200, 200)
        particle:SetStartAlpha(150)
        particle:SetEndAlpha(0)
        particle:SetStartSize(0)
        particle:SetEndSize(radius)
        particle:SetAngles(normal:Angle())
    end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end