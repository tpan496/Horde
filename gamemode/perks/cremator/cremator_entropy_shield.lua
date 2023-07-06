PERK.PrintName = "Entropy Shield"
PERK.Description =
[[Gain an Entropy Shield that reduces damage taken on hit.
Provides {1} damage resistance and deals Fire damage around you.
Lasts for {2} seconds and recharges in {3} seconds.]]
PERK.Icon = "materials/perks/entropy_shield.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 3},
    [3] = {value = 8},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function (ply, perk)
    if SERVER and perk == "cremator_entropy_shield" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_EntropyShield, 8)
            net.WriteUInt(1, 8)
        net.Send(ply)
        local id = ply:SteamID()
        timer.Remove("Horde_RecoverEntropyShield" .. id)
        timer.Remove("Horde_RecoverEntropyShield1" .. id)
        ply.Horde_Entropy_Shield_Cooldown = nil
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function (ply, perk)
    if SERVER and perk == "cremator_entropy_shield" then
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_EntropyShield, 8)
            net.WriteUInt(0, 8)
        net.Send(ply)
        local id = ply:SteamID()
        timer.Remove("Horde_RecoverEntropyShield" .. id)
        timer.Remove("Horde_RecoverEntropyShield1" .. id)
        ply.Horde_Entropy_Shield_Cooldown = nil
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_entropy_shield")  then return end
    if ply.Horde_Entropy_Shield_Activated then
        bonus.resistance = bonus.resistance + 0.25
    else
        if (not ply.Horde_Entropy_Shield_Cooldown) or (ply.Horde_Entropy_Shield_Cooldown <= CurTime()) then
            ply:EmitSound("horde/weapons/blaster/fire_explosion.ogg")
            ply.Horde_Entropy_Shield_Activated = true
            bonus.resistance = bonus.resistance + 0.25
            net.Start("Horde_SyncStatus")
                net.WriteUInt(HORDE.Status_EntropyShield, 8)
                net.WriteUInt(0, 8)
            net.Send(ply)
            local dmg = DamageInfo()
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamageType(DMG_SLOWBURN)
            dmg:SetDamage(100)
            util.BlastDamageInfo(dmg, ply:GetPos(), 150)

            local effectdata = EffectData()
            effectdata:SetOrigin(ply:GetPos())
            effectdata:SetScale(1)
            effectdata:SetEntity(ply)
            util.Effect("horde_blaster_flame_explosion", effectdata )
            local id = ply:SteamID()
            ply:ScreenFade( SCREENFADE.IN, Color( 255, 165, 0, 50 ), 2.5, 0)
            timer.Create("Horde_RecoverEntropyShield" .. id, 3, 1, function ()
                if IsValid(ply) then
                    ply.Horde_Entropy_Shield_Activated = nil
                    ply.Horde_Entropy_Shield_Cooldown = CurTime() + 5
                end
            end)

            timer.Create("Horde_RecoverEntropyShield1" .. id, 8, 1, function ()
                if IsValid(ply) then
                    net.Start("Horde_SyncStatus")
                        net.WriteUInt(HORDE.Status_EntropyShield, 8)
                        net.WriteUInt(1, 8)
                    net.Send(ply)
                end
            end)
        end
    end
end