function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)

	local particle

	--sound.Play("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", pos, 75, math.random(70, 90))
	sound.Play("AlyxEMP.Discharge", pos, 100, math.random(105, 120))

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

	for i=1, 100 do
		particle = emitter:Add("effects/spark", pos)
		particle:SetDieTime(0.3)
		particle:SetColor(245, 250, 255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(6)
		particle:SetEndSize(6)
		particle:SetStartLength(60)
		particle:SetEndLength(60)
		particle:SetVelocity(VectorRand():GetNormal() * 220)
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
	local ringstart = pos + normal * -3
	for i=1, 3 do
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.1 + i * 0.1)
		particle:SetColor(245, 250, 255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(50)
		particle:SetAngles(normal:Angle())
		particle = emitter2:Add("effects/select_ring", ringstart)
		particle:SetDieTime(0.2 + i * 0.1)
		particle:SetColor(245, 250, 255)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(0)
		particle:SetEndSize(160)
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
