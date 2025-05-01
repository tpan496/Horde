GADGET.PrintName = "Nuke"
GADGET.Description =
[[Bombards an area with 8 large explosions after a 10 second delay.
Finishes off with a Nuke detonation dealing massive Blast damage.

Leaves behind Decay for 45 seconds.]]
GADGET.Icon = "items/gadgets/nuke.png"
GADGET.Duration = 0
GADGET.Cooldown = 90
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
    if ply.Horde_NukeCooldown and ply.Horde_NukeCooldown > CurTime() then
        local remaining_cooldown = math.ceil(ply.Horde_NukeCooldown - CurTime())
        HORDE:SendNotification("Nuke is still on cooldown! (" .. remaining_cooldown .. "s remaining)", 1, ply)
        net.Start("Horde_GadgetStartCooldown")
            net.WriteUInt(remaining_cooldown, 8)
        net.Send(ply)
        return
    end

    ply.Horde_NukeCooldown = CurTime() + 90

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
        local flashpower = 2000
        local targets = ents.FindInSphere(pos, flashpower)
        for _, k in pairs(targets) do
            if k:IsPlayer() and k:VisibleVec( pos ) then
                k:ScreenFade(SCREENFADE.IN, Color( 255, 255, 255, 120), 1, 0.5)
            end
        end
    end )
    timer.Simple(10, function ()
        bs:Stop()
        local attacker = ply
        if not ply:IsValid() then attacker = Entity(0) end

        for i = 1, 8 do
            timer.Simple(0.2 * i, function ()
                if not ply:IsValid() then attacker = Entity(0) end
                local angle = math.random() * math.pi * 2
                local distance = math.random(200, 600)
                local x = math.cos(angle) * distance
                local y = math.sin(angle) * distance
                local blast_pos = pos + Vector(x, y, 0)
                Blast(attacker, ent, blast_pos, 1000, 800, "vj_explosion" .. math.random( 1,3 ), "ambient/explosions/explode_" .. i .. ".wav")
            end )
        end

        timer.Simple(2, function ()
            if not ply:IsValid() then attacker = Entity(0) end
            Blast(attacker, ent, pos, 1600, 1500, "explosion_huge", "ambient/explosions/explode_1.wav")
        end )

        HORDE:CreateTimer("NukeDecay", 1, 45, function ()
            if not ply:IsValid() or not ply:Alive() then HORDE:RemoveTimer("NukeDecay") return end
            for _, e in pairs(ents.FindInSphere(pos, 1000)) do
                if e:IsPlayer() then
                    e:Horde_AddDebuffBuildup(HORDE.Status_Decay, 15, ply)
                end
            end
        end )
    end )
end

hook.Add("Horde_OnUnsetGadget", "Horde_NukeCooldownPersistence", function(ply, gadget)
    if gadget ~= "gadget_nuke" then return end
    ply.Horde_NukeCooldown = ply.Horde_NukeCooldown or 0
end )

hook.Add("Horde_OnSetGadget", "Horde_NukeCooldownRestore", function(ply, gadget)
    if gadget ~= "gadget_nuke" then return end
    if ply.Horde_NukeCooldown and ply.Horde_NukeCooldown > CurTime() then
        local remaining_cooldown = math.ceil(ply.Horde_NukeCooldown - CurTime())
        HORDE:SendNotification("Nuke is still on cooldown! (" .. remaining_cooldown .. "s remaining)", 1, ply)
        net.Start("Horde_GadgetStartCooldown")
            net.WriteUInt(remaining_cooldown, 8)
        net.Send(ply)
    end
end )