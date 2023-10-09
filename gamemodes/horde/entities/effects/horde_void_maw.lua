function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)
	local scale = 1

	local particle

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

	local ringstart = pos + normal * 10
	for i=1, 25 do
		particle = emitter2:Add("effects/splashwake3", ringstart)
		particle:SetDieTime(0.1 + (i % 2) * 0.1)
		particle:SetColor(50, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(300 * scale)
		particle:SetEndSize(0)
		particle:SetAngles(normal:Angle())
		particle = emitter2:Add("effects/splashwake3", ringstart)
		particle:SetDieTime(0.2 + (i % 2) * 0.1)
		particle:SetColor(50, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(300 * scale)
		particle:SetEndSize(0)
		particle:SetAngles(normal:Angle())

		particle = emitter:Add("effects/splashwake3", ringstart)
		particle:SetDieTime(0.1 + (i % 2) * 0.1)
		particle:SetColor(50, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(300 * scale)
		particle:SetEndSize(0)
		particle:SetRoll(math.random(-180, 180))
		particle = emitter:Add("effects/splashwake3", ringstart)
		particle:SetDieTime(0.2 + (i % 2) * 0.1)
		particle:SetColor(50, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(300 * scale)
		particle:SetEndSize(0)
		particle:SetRoll(math.random(-180, 180))
	end
	emitter2:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end