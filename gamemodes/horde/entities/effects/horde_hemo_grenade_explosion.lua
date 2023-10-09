function EFFECT:Think()
	return false
end

function EFFECT:Render()
end

function EFFECT:Init(data)
	local pos = data:GetOrigin()

	sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", pos, 77, math.Rand(95, 105))

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 48)

	for i = 1, 50 do
		local particle = emitter:Add("effects/splash2", pos + VectorRand() * 50)
        particle:SetGravity(Vector(500,0,0))
		particle:SetAirResistance(1500)
		particle:SetDieTime(math.Rand(0.25, 0.5))
		particle:SetStartAlpha(150)
		particle:SetEndAlpha(0)
		particle:SetStartSize(150)
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-10, 10))
		particle:SetColor(200, 0, 0)
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end