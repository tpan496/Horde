function EFFECT:Init(data)
    local owner = data:GetEntity()
    local scale = data:GetScale()
    if not scale then scale = 1 end
	local has_burner = nil
	if owner and owner:IsPlayer() and owner:Horde_GetGadget() == "gadget_hydrogen_burner" then
		has_burner = true
	end

    local FlameEmitter = ParticleEmitter(data:GetOrigin())

    for i=1, 25 do
        if !FlameEmitter then return end
        local FlameParticle = FlameEmitter:Add("particles/flamelet5", data:GetOrigin() )

        if (FlameParticle) then
            if has_burner then
                FlameParticle:SetColor(0,100,255)
            else
                FlameParticle:SetColor(255,150,0)
            end

            FlameParticle:SetVelocity( VectorRand() * 500 * scale)

            FlameParticle:SetLifeTime(0)
            FlameParticle:SetDieTime(math.Rand(0, 0.5))

            FlameParticle:SetStartAlpha(255)
            FlameParticle:SetEndAlpha(0)

            FlameParticle:SetStartSize(0)
            FlameParticle:SetEndSize(64 * scale)

            FlameParticle:SetRoll(math.Rand(-180, 180))
            FlameParticle:SetRollDelta(math.Rand(-3.2, 3.2))

            FlameParticle:SetAirResistance(500)

            FlameParticle:SetGravity(Vector(0, 0, 64))

        end
    end

    -- Smoke screen
	for i = 1,12 do
		local EffectCode = FlameEmitter:Add("particles/smokey", data:GetOrigin())
		EffectCode:SetVelocity(VectorRand() * 150 * scale)
		EffectCode:SetDieTime(math.Rand(0.5, 1.5)) -- How much time until it dies
		EffectCode:SetStartAlpha(math.Rand(150,230)) -- Transparency
		EffectCode:SetStartSize(0) -- Size of the effect
		EffectCode:SetEndSize(math.Rand(100,150) * scale) -- Size of the effect at the end (The effect slowly trasnsforms to this size)
		EffectCode:SetRoll(math.Rand(480,540))
		EffectCode:SetRollDelta(0) -- How fast it rolls
		EffectCode:SetColor(100,100,100) -- The color of the effect
		EffectCode:SetGravity(Vector(0, 0, 0)) -- The Gravity
		EffectCode:SetAirResistance(15)
        EffectCode:SetEndAlpha(0)
	end

    for i = 1,2 do
		local wave = FlameEmitter:Add("sprites/heatwave", data:GetOrigin())
		wave:SetColor(0, 200, 200)
        wave:SetVelocity(VectorRand():GetNormal()*math.random(10, 30))
        wave:SetRoll(math.Rand(0, 360))
        wave:SetDieTime(0.25)
        wave:SetLifeTime(0)
        wave:SetStartSize(200)
        wave:SetStartAlpha(255)
        wave:SetEndSize(200)
        wave:SetEndAlpha(0)
        wave:SetGravity(Vector(0,0,0))
	end

    FlameEmitter:Finish()
end

function EFFECT:Think()
return false
end

function EFFECT:Render()
end