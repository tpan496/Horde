function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
    local type = effectdata:GetDamageType()

	local emitter = ParticleEmitter(pos)

	for i = 1, math.random(150, 200) do
		local particle = emitter:Add("effects/slime1", pos)
		particle:SetVelocity(VectorRand():GetNormalized() * math.Rand(250,500))
		particle:SetAirResistance(100)
		particle:SetDieTime(math.Rand(0.25,0.5))
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(10, 30))
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-30, 30))

        if type == 1 then
            particle:SetColor(200, 100, 50)
        else
            particle:SetColor(100, 200, 50)
        end
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end