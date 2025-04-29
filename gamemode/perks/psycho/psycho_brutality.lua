PERK.PrintName = "Brutality"
PERK.Description = [[
Brutality adds an additional {1} Base Critical Hit chance.
Brutality also increases Critical Hit damage by {2}.
Brutality stacks decay {3} slower.]]
PERK.Icon = "materials/perks/psycho/brutality.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 0.1, percent = true},
    [3] = {value = 0.5, percent = true},
}
PERK.Hooks = {}
-- Perk effect is in Psycho Base
PERK.Hooks.Horde_OnSetPerk = function (ply, perk)
    if SERVER and perk == "psycho_brutality" then
        ply.Horde_BrutalityStackDuration = 7.5
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function (ply, perk)
    if SERVER and perk == "psycho_brutality" then
        ply.Horde_BrutalityStackDuration = 5
    end
end

PERK.Hooks.Horde_OnPlayerCriticalCheck = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_brutality") then
        crit_bonus.add = crit_bonus.add + 0.05 * ply:Horde_GetBrutalityStack()
    end
end

PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_brutality") then
        bonus.increase = bonus.increase + 0.1 * ply:Horde_GetBrutalityStack()
    end
end