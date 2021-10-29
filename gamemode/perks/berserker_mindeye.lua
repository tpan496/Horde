PERK.PrintName = "Mind's Eye"
PERK.Description = "Each melee attack increases Mind's Eye stack by 1, up to {1}.\nEach stack increases {2} evasion and {3} melee damage.\nLoses all stacks when you are hit or exceeded max stack."
PERK.Icon = "materials/perks/mindeye.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.10, percent = true},
    [3] = {value = 0.10, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_mindeye" then
        ply:Horde_SetMindeyeEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_mindeye" then
        ply:Horde_SetMindeyeEnabled(nil)
    end
end