function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)
	local scale = effectdata:GetScale() or 1

	local particle

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

	local ringstart = pos + normal * 10
	for i=1, 3 do
		particle = emitter2:Add("effects/splashwake3", ringstart)
		particle:SetDieTime(0.1 + i * 0.1)
		particle:SetColor(200, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(250 * scale)
		particle:SetAngles(normal:Angle())
		particle = emitter2:Add("effects/splashwake3", ringstart)
		particle:SetDieTime(0.2 + i * 0.1)
		particle:SetColor(200, 50, 50)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(250 * scale)
		particle:SetAngles(normal:Angle())
	end

	for i=1, 10 do
		local smoke = emitter:Add("particle/particle_smokegrenade", pos)
		smoke:SetGravity( Vector(0, 0, 0) )
		smoke:SetDieTime( math.Rand(0.5, 1) )
		smoke:SetStartAlpha(255)
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(10)
		smoke:SetEndSize(300 * scale)
		smoke:SetRoll( math.Rand(-180, 180) )
		smoke:SetRollDelta( math.Rand(-0.2,0.2) )
		smoke:SetColor(200, 50, 50)
		smoke:SetLighting(false)
		smoke:SetCollide(true)
		smoke:SetBounce(0)
	end

	emitter:Finish()
	emitter2:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end