function EFFECT:Init(ed)

    local vOrig = ed:GetOrigin()
    self.Emitter = ParticleEmitter(vOrig)
    
    for i=1,24 do
        local smoke = self.Emitter:Add("particle/particle_smokegrenade", vOrig)
        if (smoke) then
            smoke:SetColor(25, 125, 200)
            smoke:SetVelocity(VectorRand():GetNormal()*math.random(100, 300))
            smoke:SetRoll(math.Rand(0, 360))
            smoke:SetRollDelta(math.Rand(-2, 2))
            smoke:SetDieTime(1)
            smoke:SetLifeTime(0)
            smoke:SetStartSize(50)
            smoke:SetStartAlpha(255)
            smoke:SetEndSize(150)
            smoke:SetEndAlpha(0)
            smoke:SetGravity(Vector(0,0,0))
        end

        local smoke2 = self.Emitter:Add("particle/particle_smokegrenade", vOrig)
        if (smoke2) then
            smoke2:SetColor(25, 125, 200)
            smoke2:SetVelocity(VectorRand():GetNormal()*math.random(50, 100))
            smoke2:SetRoll(math.Rand(0, 360))
            smoke2:SetRollDelta(math.Rand(-2, 2))
            smoke2:SetDieTime(5)
            smoke2:SetLifeTime(0)
            smoke2:SetStartSize(50)
            smoke2:SetStartAlpha(255)
            smoke2:SetEndSize(150)
            smoke2:SetEndAlpha(0)
            smoke2:SetGravity(Vector(0,0,0))

        end

        local smoke3 = self.Emitter:Add("particle/particle_smokegrenade", vOrig+Vector(math.random(-150,150),math.random(-150,150),0))
        if (smoke3) then
            smoke3:SetColor(0, 25, 50)
            smoke3:SetVelocity(VectorRand():GetNormal()*math.random(50, 100))
            smoke3:SetRoll(math.Rand(0, 360))
            smoke3:SetRollDelta(math.Rand(-2, 2))
            smoke3:SetDieTime(5)
            smoke3:SetLifeTime(0)
            smoke3:SetStartSize(50)
            smoke3:SetStartAlpha(255)
            smoke3:SetEndSize(150)
            smoke3:SetEndAlpha(0)
            smoke3:SetGravity(Vector(0,0,0))
        end

        local heat = self.Emitter:Add("sprites/heatwave", vOrig+Vector(math.random(-150,150),math.random(-150,150),0))
        if (heat) then
            heat:SetColor(0, 25, 50)
            heat:SetVelocity(VectorRand():GetNormal()*math.random(50, 100))
            heat:SetRoll(math.Rand(0, 360))
            heat:SetRollDelta(math.Rand(-2, 2))
            heat:SetDieTime(3)
            heat:SetLifeTime(0)
            heat:SetStartSize(150)
            heat:SetStartAlpha(255)
            heat:SetEndSize(0)
            heat:SetEndAlpha(0)
            heat:SetGravity(Vector(0,0,0))
        end
    end

    for i=1,72 do
        local sparks = self.Emitter:Add("effects/spark", vOrig)
        if (sparks) then
            sparks:SetColor(0, 200, 255)
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
            sparks2:SetColor(0, 200, 255)
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
            flash:SetColor(255, 255, 255)
            flash:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            flash:SetRoll(math.Rand(0, 360))
            flash:SetDieTime(0.10)
            flash:SetLifeTime(0)
            flash:SetStartSize(170)
            flash:SetStartAlpha(255)
            flash:SetEndSize(240)
            flash:SetEndAlpha(0)
            flash:SetGravity(Vector(0,0,0))		
        end

        local quake = self.Emitter:Add("effects/splashwake3", vOrig)
        if (quake) then
            quake:SetColor(0, 175, 255)
            quake:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            quake:SetRoll(math.Rand(0, 360))
            quake:SetDieTime(0.10)
            quake:SetLifeTime(0)
            quake:SetStartSize(180)
            quake:SetStartAlpha(200)
            quake:SetEndSize(270)
            quake:SetEndAlpha(0)
            quake:SetGravity(Vector(0,0,0))		
        end

        local wave = self.Emitter:Add("sprites/heatwave", vOrig)
        if (wave) then
            wave:SetColor(0, 175, 255)
            wave:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
            wave:SetRoll(math.Rand(0, 360))
            wave:SetDieTime(0.25)
            wave:SetLifeTime(0)
            wave:SetStartSize(200)
            wave:SetStartAlpha(255)
            wave:SetEndSize(270)
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