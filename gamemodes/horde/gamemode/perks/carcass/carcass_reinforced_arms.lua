PERK.PrintName = "Reinforced Arms"
PERK.Description =
[[Adds {1} maximum Hypertrophy stacks.
Your punch deals more damage based on your velocity.
Charged punch against surfaces provide speed boost.]]
PERK.Icon = "materials/perks/carcass/reinforced_arms.png"
PERK.Params = {
    [1] = {value = 1},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_reinforced_arms" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_reinforced_arms" then
        ply:Horde_SetMaxHypertrophyStack(ply:Horde_GetMaxHypertrophyStack() - 1)
    end
end