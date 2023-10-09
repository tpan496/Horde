function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = effectdata:GetNormal()

	local particle

	sound.Play("ambient/levels/labs/electric_explosion5.wav", pos, 80, math.random(70, 90))

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

	local ringstart = pos + normal * 10

	for i=1, 3 do
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(i * 0.1)
		particle:SetColor(200, 200, 255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(200)
		particle:SetAngles(normal:Angle())
	end

    for i=1, math.random(120, 200) do
		local heading = VectorRand()
		heading:Normalize()

		particle = emitter:Add("effects/spark", pos + heading * 8)
		particle:SetVelocity(800 * heading)
		particle:SetDieTime(math.Rand(0.5, 0.85))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(255)
		particle:SetStartSize(math.Rand(3,4))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetColor(200, 200, 255)
		--particle:SetRollDelta(math.Rand(-10, 10))
		particle:SetAirResistance(250)
	end

	for i=1, 160 do
		particle = emitter:Add("effects/blueflare1", pos)
		particle:SetDieTime(0.3)
		particle:SetColor(245, 250, 255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(9)
		particle:SetEndSize(9)
		particle:SetVelocity(VectorRand():GetNormal() * 366)
	end

    local dlight = DynamicLight(0)
	if dlight then
		dlight.Pos = pos
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 8
		dlight.Size = 300
		dlight.Decay = 1000
		dlight.DieTime = CurTime() + 1
	end

	emitter:Finish()
	emitter2:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end