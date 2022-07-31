function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)

	local particle

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

	for i=1, 12 do
		particle = emitter:Add("particles/smokey", pos + Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(0, 10)))
		particle:SetVelocity(VectorRand():GetNormal() * 240)
		particle:SetDieTime(math.Rand(0.3, 0.6))
		particle:SetStartAlpha(150)
		particle:SetStartSize(1)
		particle:SetEndSize(250)
		particle:SetRoll(math.Rand(-360, 360))
		particle:SetRollDelta(math.Rand(-4.5, 4.5))
		particle:SetColor(50,50,50)
	end
	local ringstart = pos + normal * -3
	for i=1, 3 do
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.1 + i * 0.1)
		particle:SetColor(50, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(50)
		particle:SetStartSize(0)
		particle:SetEndSize(250)
		particle:SetAngles(normal:Angle())
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.2 + i * 0.1)
		particle:SetColor(50, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(150)
		particle:SetStartSize(0)
		particle:SetEndSize(300)
		particle:SetAngles(normal:Angle())
	end

	emitter:Finish()
	emitter2:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
