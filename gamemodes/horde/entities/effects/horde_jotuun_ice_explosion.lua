function EFFECT:Init(effectdata)
	local pos = effectdata:GetOrigin()
	local normal = Vector(0,0,1)
	local scale = 0.75

	local particle

	sound.Play("horde/weapons/jotuun/explosion.ogg", pos, 80, math.random(70, 90))

	local emitter = ParticleEmitter(pos)
	local emitter2 = ParticleEmitter(pos, true)
	emitter:SetNearClip(24, 32)
	emitter2:SetNearClip(24, 32)

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

	for i=1, 10 do
		local smoke = emitter:Add("particles/smokey", pos)
		smoke:SetGravity( Vector(0, 0, 1500) )
		smoke:SetDieTime( math.Rand(0.5, 1) )
		smoke:SetStartAlpha(50)
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(10)
		smoke:SetEndSize(300 * scale)
		smoke:SetRoll( math.Rand(-180, 180) )
		smoke:SetRollDelta(math.Rand(-3.2, 3.2))
		smoke:SetColor(126, 212, 230)
		smoke:SetAirResistance(1000)
		smoke:SetLighting(false)
		smoke:SetCollide(true)
		smoke:SetBounce(0)
	end

    for i=1,100 do
		local particle = emitter2:Add("effects/splash2", pos)
		particle:SetDieTime(0.4)
		particle:SetColor(126, 212, 230)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(4)
		particle:SetEndSize(4)
		particle:SetStartLength(30)
		particle:SetEndLength(30)
		particle:SetVelocity(VectorRand():GetNormal() * math.random(450,600))
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
	emitter2:Finish() emitter2 = nil collectgarbage("step", 64)
    
    if CLIENT then return end
    for i = 1, math.random(5,10) do
		local debris = ents.Create("base_gmodentity")
		local mat = "debris/debris" .. tostring(math.random(1, 4))
		
		debris:SetPos(self:GetPos())
		debris:SetAngles(VectorRand():Angle())
		debris:SetModel("models/props_junk/rock001a.mdl")
		debris:SetCollisionGroup(COLLISION_GROUP_WORLD)
		debris:PhysicsInit(SOLID_VPHYSICS)
        debris:SetModelScale(1)
		
		local physobj = debris:GetPhysicsObject()
		local force = 1000
		
		physobj:AddVelocity(Vector(math.random(-force, force), math.random(-force, force), math.random(-force, force)))
		physobj:AddAngleVelocity(Vector(math.random(-force, force), math.random(-force, force), math.random(-force, force)))
		
		timer.Simple(3, function()
		
			if IsValid(debris) then
				local effect = EffectData()
				local debrisPos = debris:GetPos()
				effect:SetStart(debrisPos)
				effect:SetOrigin(debrisPos)
				effect:SetEntity(debris)
				util.Effect("entity_remove", effect)
				debris:Remove()
			end
		end)
    end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end