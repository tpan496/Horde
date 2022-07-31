function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)

	local particle

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)

	for i=1, 12 do
		particle = emitter:Add("particles/smokey", pos + Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(0, 10)))
		particle:SetVelocity(VectorRand():GetNormal() * 240)
		particle:SetDieTime(math.Rand(0.3, 0.6))
		particle:SetStartAlpha(150)
		particle:SetStartSize(1)
		particle:SetEndSize(200)
		particle:SetRoll(math.Rand(-360, 360))
		particle:SetRollDelta(math.Rand(-4.5, 4.5))
		particle:SetColor(50,50,50)
	end
	local ringstart = pos + normal * -3

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
