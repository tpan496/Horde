function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local scale = effectdata:GetScale() or 1

	local emitter = ParticleEmitter(pos)
	local smokeimages = {"particle/smokesprites_0001", "particle/smokesprites_0002", "particle/smokesprites_0003", "particle/smokesprites_0004"}
	emitter:SetNearClip(24, 32)

	for i=1, 10 do
		local smoke = emitter:Add(smokeimages[math.random(#smokeimages)], pos)
		--smoke:SetGravity( Vector(0, 0, 1500) )
		local p2 = VectorRand() * 50
		p2.z = 0
		smoke:SetPos(self:GetPos() + p2)
		smoke:SetDieTime( math.Rand(0.5, 1) )
		smoke:SetStartAlpha(255)
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(10)
		smoke:SetEndSize(300 * scale)
		smoke:SetRoll( math.Rand(-180, 180) )
		smoke:SetRollDelta( math.Rand(-0.2,0.2) )
		smoke:SetColor(255, 255, 255)
		smoke:SetAirResistance(75)
		smoke:SetLighting(false)
		smoke:SetCollide(true)
		smoke:SetBounce(0.2)
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end