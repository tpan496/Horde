PERK.PrintName = "Overclock"
PERK.Description = "Adrenaline duration increased by {1}.\nAdds {2} maximum Adrenaline stacks."
PERK.Icon = "materials/perks/overclock.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 2},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_overclock" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + PERK.Params[1].value)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_overclock" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - PERK.Params[1].value)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() / 1.5)
    end
end