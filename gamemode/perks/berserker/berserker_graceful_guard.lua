PERK.PrintName = "Graceful Guard"
PERK.Description = [[
Removes all debuffs and debuff buildups on successful Aerial Parry.
Recover {1} health and regenerate {2} of maximum health per second 
for {3} seconds on successful Aerial Parry.]]

PERK.Icon = "materials/perks/graceful_guard.png"
PERK.Params = {
    [1] = {value = 10},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 10},
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