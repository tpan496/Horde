function EFFECT:Init(data)	
	local Startpos = data:GetStart()
	local Hitpos = data:GetOrigin()

	if data:GetEntity():IsValid() && Startpos && Hitpos then
		self.Emitter = ParticleEmitter(Startpos)


		for i = 1, 20 do
			local p = self.Emitter:Add("particle/fire", Startpos)
			p:SetColor(220,150,0)
            p:SetDieTime(1.8 / 3)
			p:SetStartAlpha(255)
			p:SetEndAlpha(0)
			p:SetStartSize(10)
			p:SetEndSize(10)
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-5, 5))
			p:SetVelocity(((Hitpos - Startpos):GetNormal() * math.random(500, 500)/3) + VectorRand() * math.random(1, 20))
			p:SetCollide(true)
            p:SetCollideCallback(function()
                p:SetDieTime(0)
            end)
		end

		self.Emitter:Finish()
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end