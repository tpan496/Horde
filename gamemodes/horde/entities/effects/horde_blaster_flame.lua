function EFFECT:Init(data)
	local Startpos = self:GetTracerShootPos(self.Position, data:GetEntity(), data:GetAttachment())
	local Hitpos = data:GetOrigin()
	local owner = data:GetEntity().Owner
	local has_burner = nil
	if owner:IsValid() and owner:Horde_GetGadget() == "gadget_hydrogen_burner" then
		has_burner = true
	end

	if data:GetEntity():IsValid() && Startpos && Hitpos then
		self.Emitter = ParticleEmitter(Startpos)


		for i = 1, 20 do
			local p = self.Emitter:Add("particles/flamelet2", Startpos)
			if not has_burner then
				p:SetColor(220,150,0)
			else
				p:SetColor(0,100,255)
			end
            p:SetDieTime(1.8)
			p:SetStartAlpha(100)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(0.8, 1.5))
			p:SetEndSize(math.random(50, 75))
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-10, 10))
			p:SetVelocity(((Hitpos - Startpos):GetNormal() * math.random(500, 800)) + VectorRand() * math.random(1, 20))
			p:SetCollide(true)
            p:SetCollideCallback(function()
                p:SetDieTime(0)
            end)
		end

		for i = 1, 2 do
			local p = self.Emitter:Add("particles/smokey", Startpos)
			p:SetDieTime(2)
			p:SetStartAlpha(50)
			p:SetEndAlpha(0)
			p:SetStartSize(math.Rand(2, 4))
			p:SetEndSize(math.random(70, 90))
			p:SetRoll(math.random(-10, 10))
			p:SetRollDelta(math.random(-10, 10))	
			p:SetVelocity(((Hitpos - Startpos):GetNormal() * math.random(500, 800)) + VectorRand() * math.random(1, 60) + Vector(0,0,20))
			p:SetCollide(true)
			p:SetColor(40, 40, 40)
		end

		self.Emitter:Finish()
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end