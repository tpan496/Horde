function EFFECT:Init(ed)

    local vOrig = ed:GetOrigin()
    self.pos = vOrig
    self.emitter = ParticleEmitter(vOrig)
    local emitter2 = ParticleEmitter(vOrig, true)
    local normal = Vector(0,0,1)
    local scale = ed:GetScale()
    self.scale = scale
    self.duration = ed:GetMagnitude()
    --sound.Play("ambient/explosions/explode_7.wav", vOrig, 80, math.random(70, 90))

    local ringstart = vOrig + normal * 10
    local particle
    local mat = Material("spells/sigil_of_arcana.png", "mips smooth")
    --for i=1, 20 do
        particle = emitter2:Add(mat, ringstart)
        particle:SetDieTime(self.duration)
        particle:SetColor(0, 200, 200)
        particle:SetStartAlpha(150)
        particle:SetEndAlpha(150)
        particle:SetStartSize(scale)
        particle:SetEndSize(scale)
        particle:SetAngles(normal:Angle())
    emitter2:Finish()

    self.StartTime = CurTime() + self.duration
    
    --end
end

function EFFECT:Think()
    if self.StartTime <= CurTime() then
        self.emitter:Finish()
        return false
    end
    local disp = VectorRand()
    disp.z = 0
    local particle = self.emitter:Add("particle/sparkles", self.pos + disp * self.scale * 300)
    particle:SetDieTime(1)
    particle:SetColor(0, 200, 200)
    particle:SetStartAlpha(255)
    particle:SetEndAlpha(0)
    particle:SetStartSize(1)
    particle:SetEndSize(1)
    particle:SetVelocity(Vector(0,0,1) * 50)
    particle:SetGravity(Vector(0,0,0))
    particle:SetCollide(false)
    particle:SetBounce(0)
    particle:SetAirResistance(0)
    return true
end

function EFFECT:Render()
end