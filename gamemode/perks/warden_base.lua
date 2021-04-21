PERK.PrintName = "Warden Base"
PERK.Description = "The Warden is a support class that uses aura effects and structures to buff teammates.\nComplexity: MEDIUM\n\nPlayers/Minions near you are affected by Warden Aura.\nWarden Aura blocks {1} damage per damage taken.\nWarden Aura has {2} increased effect on you."
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.5, percent = true},
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