function EFFECT:Init(data)	
	local Startpos = data:GetStart()
	local Hitpos = data:GetOrigin()

	if Startpos && Hitpos then
		self.Emitter = ParticleEmitter(Startpos)


		for i = 1, 20 do
			local p = self.Emitter:Add("effects/splash2", Startpos)
			p:SetColor(255,0,0)
            p:SetDieTime(0.5)
			p:SetStartAlpha(100)
			p:SetEndAlpha(0)
			p:SetStartSize(5)
			p:SetEndSize(25)
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-10, 10))
			p:SetVelocity(((Hitpos - Startpos):GetNormal() * 1000) + VectorRand() * math.random(1, 20))
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