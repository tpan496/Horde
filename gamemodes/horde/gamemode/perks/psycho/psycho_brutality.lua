PERK.PrintName = "Brutality"
PERK.Description = [[
Gain Brutality by hitting enemy with Melee attacks, up to 5 stacks.
Each Brutality stack adds {1} Critical Hit chance.
Each Brutality stack increases {2} Critical Hit damage.]]
PERK.Icon = "materials/perks/psycho/brutality.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
    [2] = {value = 0.1, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function (ply, perk)
    if SERVER and perk == "psycho_brutality" then
        ply:Horde_SetMaxBrutalityStack(5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function (ply, perk)
    if SERVER and perk == "psycho_brutality" then
        ply:Horde_SetMaxBrutalityStack(0)
    end
end