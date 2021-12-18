function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = effectdata:GetNormal()

	local particle

	sound.Play("horde/status/cold_explosion.ogg", pos, 80, math.random(70, 90))

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)

    for i=1, math.random(120, 160) do
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
	end

	for i=1, 2 do
		local smoke = emitter:Add("particles/smokey", pos)
		smoke:SetGravity( Vector(0, 0, 1500) )
		smoke:SetDieTime( math.Rand(0.5, 1) )
		smoke:SetStartAlpha(255)
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(10)
		smoke:SetEndSize(300)
		smoke:SetRoll( math.Rand(-180, 180) )
		smoke:SetRollDelta( math.Rand(-0.2,0.2) )
		smoke:SetColor(149, 200, 216)
		smoke:SetAirResistance(1000)
		smoke:SetLighting(false)
		smoke:SetCollide(true)
		smoke:SetBounce(0)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end