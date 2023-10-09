function EFFECT:Init(data)
    self.Origin = data:GetOrigin()

    util.Decal("FadingScorch", self.Origin, self.Origin - Vector(0, 0, 16))

    local emitter = ParticleEmitter( self.Origin + Vector( 0, 0, 16 ) )

    local particle = emitter:Add( "sprites/heatwave", self.Origin )
        particle:SetAirResistance( 0 )
        particle:SetDieTime( 1.5 )
        particle:SetStartAlpha( 255 )
        particle:SetEndAlpha( 255 )
        particle:SetStartSize( 250 )
        particle:SetEndSize( 0 )
        particle:SetRoll( math.Rand(180,480) )
        particle:SetRollDelta( math.Rand(-5,5) )
        particle:SetColor( 255, 255, 255 )

    local fire = emitter:Add( "particle/fire", self.Origin )
        fire:SetAirResistance( 0 )
        fire:SetDieTime( 0.1 )
        fire:SetStartAlpha( 255 )
        fire:SetEndAlpha( 0 )
        fire:SetEndSize( 0 )
        fire:SetStartSize( 800 )
        fire:SetRoll( math.Rand(180,480) )
        fire:SetRollDelta( math.Rand(-1,1) )
        fire:SetColor( 255, 255, 255 )

    local light = DynamicLight(self:EntIndex())
    if (light) then
        light.Pos = self.Origin
        light.r = 255
        light.g = 255
        light.b = 255
        light.Brightness = 9
        light.Decay = 2500
        light.Size = 512
        light.DieTime = CurTime() + 0.1
    end

    emitter:Finish()

end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end