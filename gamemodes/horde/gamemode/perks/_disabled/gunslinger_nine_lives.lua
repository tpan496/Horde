PERK.PrintName = "Nine Lives"
PERK.Description = [[
Once per turn, gain Nine Lives for {1} seconds when your health depletes.
Nine Lives refills your health and provides invulnerability.
Nine Lives provides {2} increased damage.]]
PERK.Icon = "materials/perks/gunslinger/nine_lives.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.50, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_nine_lives" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Nine_Lives, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        ply.Horde_Has_Nine_Lives = true
        ply.Horde_Nine_Lives_Active = nil
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_nine_lives" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Nine_Lives, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        ply.Horde_Has_Nine_Lives = nil
        ply.Horde_Nine_Lives_Active = nil
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.Horde_Nine_Lives_Active then
        bonus.increase = bonus.increase + 0.5
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if ply.Horde_Has_Nine_Lives and ply:Horde_GetPerk("gunslinger_nine_lives") then
        if dmg:GetDamage() >= ply:Health() then
            -- Play sound effect
            ply:EmitSound("sound/player/breathe1.wav", 100, 100)
            dmg:SetDamage(0)
            ply:SetHealth(100)
            ply.Horde_Has_Nine_Lives = nil
            ply.Horde_Nine_Lives_Active = true
            net.Start("Horde_SyncActivePerk")
                net.WriteUInt(HORDE.Status_Nine_Lives, 8)
                net.WriteUInt(0, 3)
            net.Send(ply)
            timer.Simple(5, function ()
                ply.Horde_Nine_Lives_Active = nil
            end)
        end
    end
    if ply.Horde_Nine_Lives_Active then
        bonus.resistance = bonus.resistance + 1.0
    end
end