PERK.PrintName = "Cardiac Overload"
PERK.Description = "Adrenaline duration increased by {1}.\nAdds {2} maximum Adrenaline stacks."
PERK.Icon = "materials/perks/cardiac_overload.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
    [2] = {value = 1},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_overload" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 1)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_overload" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 1)
        ply:Horde_SetAdrenalineStackDuration(ply:Horde_GetAdrenalineStackDuration() / 1.5)
    end
end