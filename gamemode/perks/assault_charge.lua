PERK.PrintName = "Charge"
PERK.Description = "Adds {1} maximum Adrenaline stacks.\n(Each Adrenaline stack increases damage and speed by {2}.)"
PERK.Icon = "materials/perks/charge.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 0.06, percent=true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 2)
    end
end