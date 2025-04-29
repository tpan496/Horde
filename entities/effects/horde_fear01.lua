function EFFECT:Init(data)
	local entity = data:GetEntity()
	if(!IsValid(entity)) then return end
	local mins, maxs = entity:OBBMins(), entity:OBBMaxs()
	local pos = entity:GetPos() + entity:OBBCenter()
    local emitter = ParticleEmitter(pos)
    local particle

    for i = 1, math.random(3, 8) do
    	local size = math.random(32, 48)
        particle = emitter:Add("particle/fear_particle.vtf", pos)
        particle:SetPos(pos + Vector(math.random(mins.x, maxs.x), math.random(mins.y, maxs.y), math.random(mins.z * 0.2, maxs.z * 0.2)))
        particle:SetDieTime(math.Rand(0.4, 0.6))
        particle:SetVelocity(Vector(0, 0, math.random(-256, 256)))
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(50)
        particle:SetStartSize(size)
        particle:SetEndSize(size * 0.7)
        particle:SetColor(32, 0, 56)
        particle:SetAirResistance(1000)
        particle:SetLighting(false)
        particle:SetCollide(true)
        particle:SetBounce(0)
    end

    emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return
end