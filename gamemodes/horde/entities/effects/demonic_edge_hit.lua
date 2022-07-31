function EFFECT:Init(data)
    local light = DynamicLight(0);
    if(light) then
        light.Pos = data:GetOrigin();
        light.Size = 128;
        light.Decay = 64;
        light.R = 255;
        light.G = 132;
        light.B = 0;
        light.Brightness = 3;
        light.DieTime = CurTime()+1;

    end

    local DrawFlame = 1
    sound.Play("ambient/fire/ignite.wav", self:GetPos(), 54, math.random(82,112))

    if DrawFlame == 1 then

        local FlameEmitter = ParticleEmitter(data:GetOrigin())

        for i=0, 16 do
            if !FlameEmitter then return end
            local FlameParticle = FlameEmitter:Add("particles/flamelet3", data:GetOrigin() )

            if (FlameParticle) then
                FlameParticle:SetColor(200,100,0)
                FlameParticle:SetVelocity( VectorRand() * 150 )

                FlameParticle:SetLifeTime(0)
                FlameParticle:SetDieTime(0.72)

                FlameParticle:SetStartAlpha(255)
                FlameParticle:SetEndAlpha(0)

                FlameParticle:SetStartSize(0)
                FlameParticle:SetEndSize(64 * data:GetScale())

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