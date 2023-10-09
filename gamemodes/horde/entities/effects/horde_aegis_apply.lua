function EFFECT:Init(data)	
	local Hitpos = data:GetOrigin()

	local mat = Material("status/gadget/aegis.png", "mips smooth")
	print(Hitpos)

	self.Emitter = ParticleEmitter(Hitpos)
	local p = self.Emitter:Add(mat, Hitpos)
	p:SetColor(255,0,0)
	p:SetDieTime(0.5)
	p:SetStartAlpha(255)
	p:SetEndAlpha(0)
	p:SetStartSize(50)
	p:SetEndSize(50)
	p:SetCollide(false)
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end