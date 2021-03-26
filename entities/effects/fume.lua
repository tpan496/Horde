function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.ticks = 0
    self.entity = effect_data:GetEntity()
end

function EFFECT:Think()
    if self.ticks % 5 == 0 then
        if not self.entity or not self.entity:IsValid() then return end
        local emitter = ParticleEmitter(self.entity:GetPos())
        if emitter then
            local smoke = emitter:Add("particles/smokey", self.entity:GetPos())
            smoke:SetGravity( Vector(0, 0, 1500) )
            smoke:SetDieTime( math.Rand(0.5, 1) )
            smoke:SetStartAlpha(20)
            smoke:SetEndAlpha(0)
            smoke:SetStartSize(10)
            smoke:SetEndSize(300)
            smoke:SetRoll( math.Rand(-180, 180) )
            smoke:SetRollDelta( math.Rand(-0.2,0.2) )
            smoke:SetColor(200, 50, 50)
            smoke:SetAirResistance(1000)
            smoke:SetPos(self.entity:GetPos())
            smoke:SetLighting(false)
            smoke:SetCollide(true)
            smoke:SetBounce(0)
        end
    end
    self.ticks = self.ticks + 1
    return true
end

function EFFECT:Render()
end