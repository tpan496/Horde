function EFFECT:Init(effect_data)
	self.effect_data = effect_data
    self.ticks = 0
    self.entity = effect_data:GetEntity()
end

function EFFECT:Think()
    if self.ticks % 5 == 0 then
        if not self.entity or not self.entity:IsValid() then return true end
        if not self.entity.Horde_Mutation and IsValid(self.emitter) then self.emitter:Finish() return false end
        local pos = self.entity:GetPos()
        if not self.emitter then
            self.emitter = ParticleEmitter(pos)
        end
        
        if self.emitter then
            local smoke = self.emitter:Add("particles/smokey", pos)
            smoke:SetGravity( Vector(0, 0, 1500) )
            smoke:SetDieTime( math.Rand(0.5, 1) )
            smoke:SetStartAlpha(20)
            smoke:SetEndAlpha(0)
            smoke:SetStartSize(10)
            smoke:SetEndSize(200)
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