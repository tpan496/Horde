function EFFECT:Init(ed)

    local vOrig = ed:GetOrigin()
    self.Emitter = ParticleEmitter(vOrig)
    sound.Play("ambient/explosions/explode_7.wav", vOrig, 80, math.random(70, 90))

    for i=1,72 do
        local sparks = self.Emitter:Add("effects/spark", vOrig)
        if (sparks) then
            sparks:SetColor(0, 200, 200)
            sparks:SetVelocity(VectorRand():GetNormal()*math.random(300, 500))
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
            sparks2:SetVelocity(VectorRand():GetNormal()*math.random(400, 800))
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
            flash:SetStartAlpha(255)
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
            quake:SetStartSize(180)
            quake:SetStartAlpha(200)
            quake:SetEndSize(200)
            quake:SetEndAlpha(0)
            quake:SetGravity(Vector(0,0,0))		
        end

        local wave = self.Emitter:Add("sprites/heatwave", vOrig)
        if (wave) then
            wave:SetColor(0, 200, 200)
            wave:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            wave:SetRoll(math.Rand(0, 360))
            wave:SetDieTime(0.25)
            wave:SetLifeTime(0)
            wave:SetStartSize(200)
            wave:SetStartAlpha(255)
            wave:SetEndSize(200)
            wave:SetEndAlpha(0)
            wave:SetGravity(Vector(0,0,0))
        end
    end
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end