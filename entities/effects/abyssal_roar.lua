function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)
	local scale = 1

	local particle

	sound.Play("horde/status/cold_explosion.ogg", pos, 50, math.random(70, 90))

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

	local ringstart = pos + normal * 10
	for i=1, 3 do
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.1 + i * 0.1)
		particle:SetColor(100, 100, 200)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(250 * scale)
		particle:SetAngles(normal:Angle())
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.2 + i * 0.1)
		particle:SetColor(100, 100, 200)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(250 * scale)
		particle:SetAngles(normal:Angle())
	end

    --[[for i=1, math.random(120, 160) do
		local heading = VectorRand()
		heading:Normalize()

		particle = emitter:Add("effects/blueflare1", pos + heading * 8)
		particle:SetVelocity(800 * heading)
		particle:SetDieTime(math.Rand(0.5, 0.85))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(3,4))
		particle:SetEndSize(0)
		particle:SetAirResistance(250)
	end]]--

	for i=1, 2 do
		local smoke = emitter:Add("particles/smokey", pos)
		smoke:SetGravity( Vector(0, 0, 1500) )
		smoke:SetDieTime( math.Rand(0.5, 1) )
		smoke:SetStartAlpha(255)
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(10)
		smoke:SetEndSize(300 * scale)
		smoke:SetRoll( math.Rand(-180, 180) )
		smoke:SetRollDelta( math.Rand(-0.2,0.2) )
		smoke:SetColor(50, 50, 50)
		smoke:SetAirResistance(1000)
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