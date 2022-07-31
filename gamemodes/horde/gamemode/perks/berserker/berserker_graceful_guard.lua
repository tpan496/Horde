PERK.PrintName = "Graceful Guard"
PERK.Description = [[On successful Aerial Parry:
    - Removes all debuff and debuff buildups.
    - Recover {1} health.]]
PERK.Icon = "materials/perks/graceful_guard.png"
PERK.Params = {
    [1] = {value = 20},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_graceful_guard" then
        ply:Horde_SetGracefulGuardEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_graceful_guard" then
        ply:Horde_SetGracefulGuardEnabled(nil)
    end
end