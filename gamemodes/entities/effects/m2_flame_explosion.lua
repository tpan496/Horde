function EFFECT:Init(data)
    local owner = data:GetEntity()
	local has_burner = nil
	if owner and owner:IsPlayer() and owner:Horde_GetGadget() == "gadget_hydrogen_burner" then
		has_burner = true
	end
    local light = DynamicLight(0);
    if(light) then
        if has_burner then
            light.R = 0;
            light.G = 132;
            light.B = 255;
        else
            light.R = 255;
            light.G = 132;
            light.B = 0;
        end
        light.Pos = data:GetOrigin();
        light.Size = 128;
        light.Decay = 64;
        light.Brightness = 3;
        light.DieTime = CurTime()+1;
    end

    local DrawFlame = 1

    if DrawFlame == 1 then

        local FlameEmitter = ParticleEmitter(data:GetOrigin())

        for i=0, 16 do
            if !FlameEmitter then return end
            local FlameParticle = FlameEmitter:Add("particles/flamelet1", data:GetOrigin() )

            if (FlameParticle) then
                if has_burner then
                    FlameParticle:SetColor(0,100,255)
                else
                    FlameParticle:SetColor(200,150,0)
                end

                FlameParticle:SetVelocity( VectorRand() * 172 )

                FlameParticle:SetLifeTime(0)
                FlameParticle:SetDieTime(0.72)

                FlameParticle:SetStartAlpha(210)
                FlameParticle:SetEndAlpha(0)

                FlameParticle:SetStartSize(0)
                FlameParticle:SetEndSize(64 * (data:GetScale() or 1))

                FlameParticle:SetRoll(math.Rand(-210, 210))
                FlameParticle:SetRollDelta(math.Rand(-3.2, 3.2))

                FlameParticle:SetAirResistance(350)

                FlameParticle:SetGravity(Vector(0, 0, 64))

            end
        end

        FlameEmitter:Finish()
    end
end

function EFFECT:Think()
return false
end

function EFFECT:Render()
end