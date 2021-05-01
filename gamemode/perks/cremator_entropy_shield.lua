PERK.PrintName = "Entropy Shield"
PERK.Description = "Gain a shield that negates damage taken.\nShield explodes on hit and recharges after {1} seconds.\nExplosion deals {2} Fire damage."
PERK.Icon = "materials/perks/entropy_shield.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 100},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "cremator_entropy_shield" then
        ply:Horde_SetEntropyShieldEnabled(true)
        ply:Horde_AddEntropyShield()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "cremator_entropy_shield" then
        ply:Horde_SetEntropyShieldEnabled(nil)
        ply:Horde_RemoveEntropyShield()
        timer.Remove("Horde_RestockEntropyShield" .. ply:SteamID())
    end
end