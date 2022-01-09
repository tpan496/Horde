PERK.PrintName = "Warden Base"
PERK.Description = "The Warden is a support class that uses aura effects and structures to buff teammates.\nComplexity: MEDIUM\n\nPlayers/Minions near you are affected by Warden Aura.\nWarden Aura blocks {1} damage."
PERK.Params = {
    [1] = {value = 2}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "warden_base" then
        ply:Horde_AddWardenAura()
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "warden_base" then
        ply:Horde_RemoveWardenAura()
    end
end