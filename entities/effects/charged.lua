function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.entity = effect_data:GetEntity()
    self.radius = effect_data:GetRadius()
    self.ticks = 0
end

-- Bubbles
function EFFECT:Think()
    if not self.entity or not self.entity:IsValid() then return true end
    if self.entity:IsWeapon() then
        if not self.entity.Mjollner_Charged then if IsValid(self.emitter) then self.emitter:Finish() end return false end
    else
        if not self.entity.Horde_Mutation_Charged then if IsValid(self.emitter) then self.emitter:Finish() end return false end
    end
    local pos = self.entity:GetPos()
    if not self.emitter then
        self.emitter = ParticleEmitter(pos)
        self.emitter:SetNearClip(24, 32)
    end

    if self.emitter then
		local particle = self.emitter:Add("particle/sparkles", pos + VectorRand() * self.radius)
		particle:SetDieTime(0.25)
		particle:SetColor(0,150,255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(2)
		particle:SetEndSize(2)
		particle:SetVelocity(Vector(0,0,0))
		particle:SetGravity(VectorRand(0,0,0))
		particle:SetCollide(true)
		particle:SetBounce(0.75)
        particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-10, 10))
		particle:SetAirResistance(250)
        if not self.dlight then
            self.dlight = DynamicLight(0)
            self.dlight.Pos = pos
            self.dlight.r = 0
            self.dlight.g = 150
            self.dlight.b = 255
            self.dlight.Brightness = 8
            self.dlight.Size = self.radius * 2
            --dlight.Decay = 1000
            self.dlight.DieTime = CurTime() + 0.2
        end
        if self.dlight then
            self.dlight.Pos = pos
            self.dlight.DieTime = CurTime() + 0.2
        end
	end

    return true
end

function EFFECT:Render()
end