GADGET.PrintName = "Nuke"
GADGET.Description =
[[Drops a nuke at the target location after a 10 second delay.
Bombards a huge area with numerous aftershocks.

Leaves behind radioactive waste for 60 seconds.]]
GADGET.Icon = "items/gadgets/nuke.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Once = true
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

local function Blast(attacker, inflictor, pos, radius, damage, effect_name, sound_name)
    local dmg = DamageInfo()
    dmg:SetAttacker(attacker)
    dmg:SetInflictor(inflictor)
    dmg:SetDamageType(DMG_BLAST)
    dmg:SetDamage(damage)
    util.BlastDamageInfo(dmg, pos, radius)
    local effectdata = EffectData()
	effectdata:SetOrigin(pos)
    if effect_name then
        ParticleEffect(effect_name, pos, Angle(0, 0, 0))
    else
        util.Effect( "Explosion", effectdata )
    end
    if sound_name then
        sound.Play(sound_name, pos, 1000)
    end
end

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_nuke" then return end
    local ent = ents.Create("horde_nuke")
    ent:Spawn()
    local pos = ply:GetEyeTrace().HitPos
    local bs = CreateSound(game.GetWorld(), "ambient/alarms/siren.wav")
    bs:SetSoundLevel(0)
    bs:Play()

    local flare = ents.Create("env_flare")
	flare:SetPos(pos)
	flare:SetAngles(Angle(0,0,0))
	flare:SetParent(flare)
	flare:SetKeyValue("Scale","5")
	flare:SetKeyValue("spawnflags","4")
	flare:Spawn()
    timer.Simple(9, function ()
        flare:Remove()
        local flashpower = 5000
        local targets = ents.FindInSphere(pos, flashpower)
        for _, k in pairs(targets) do
            if k:IsPlayer() then
                if k:VisibleVec( pos ) then
                    k:ScreenFade(SCREENFADE.IN, Color( 255, 255, 255, 255 ), 1, 0.5)
                end
            end
        end
    end)
    timer.Simple(10, function ()
        bs:Stop()
        local attacker = ply
        if !ply:IsValid() then attacker = Entity(0) end

        Blast(attacker, ent, pos, 800, 500, "explosion_huge", "ambient/explosions/explode_1.wav")
        timer.Simple(0.2, function()
            if !ply:IsValid() then attacker = Entity(0) end
            Blast(attacker, ent, pos + Vector(0,0,100), 1000, 100, "explosion_huge")
        end)
        for i = 1, 10 do
            for j = 1, i * 2 do
                timer.Simple(0.2 * i, function ()
                    if !ply:IsValid() then attacker = Entity(0) end
                    local angle = math.random() * 3.14 * 2;
                    local x = math.cos(angle) * i * 100;
                    local y = math.sin(angle) * i * 100;

                    Blast(attacker, ent, pos + Vector(x,y,0), 500 - i * 10, 400 - i * 20, "vj_explosion" .. math.random(1,3), "ambient/explosions/explode_" .. math.random(2,9) .. ".wav")
                end)
            end
        end

        timer.Simple(2.2, function()
            if !ply:IsValid() then attacker = Entity(0) end
            for i = 1, 40 do
                local angle = math.random() * 3.14 * 2;
                local x = math.cos(angle) * 11 * 100;
                local y = math.sin(angle) * 11 * 100;
                Blast(attacker, ent, pos + Vector(x,y,0), 150, 100, nil)
            end
        end)

        timer.Simple(2.4, function()
            if !ply:IsValid() then attacker = Entity(0) end
            for i = 1, 60 do
                local angle = math.random() * 3.14 * 2;
                local x = math.cos(angle) * 12 * 100;
                local y = math.sin(angle) * 12 * 100;
                Blast(attacker, ent, pos + Vector(x,y,0), 100, 100, nil)
            end
        end)

        timer.Simple(2.4, function ()
            if !ply:IsValid() then return end
            HORDE:CreateTimer("NukeDecay", 1, 60, function ()
                if !ply:IsValid() or !ply:Alive() then HORDE:RemoveTimer("NukeDecay") end
                for _, e in pairs(ents.FindInSphere(pos, 1000)) do
                    if e == ply then
                        e:Horde_AddDebuffBuildup(HORDE.Status_Decay, 10, ply)
                    end
                end
            end)
        end)
    end)
end