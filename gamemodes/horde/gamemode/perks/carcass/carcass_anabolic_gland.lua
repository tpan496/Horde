PERK.PrintName = "Anabolic Gland"
PERK.Description =
[[Adds {1} maximum Hypertrophy stacks.
Adds {2} chance to gain Hypertrophy when you hit an enemy.]]
PERK.Icon = "materials/perks/carcass/anabolic_gland.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_anabolic_gland" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_anabolic_gland" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() - 2)
    end
end