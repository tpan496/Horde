PERK.PrintName = "Cardiac Resonance"
PERK.Description = "Every time you kill an enemy, Players near you also gain {1} Adrenaline, up to {2}.\nAdds {3} maximum Adrenaline stacks.\n"
PERK.Icon = "materials/perks/cardiac_resonance.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 2},
    [3] = {value = 1},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_resonance" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 1)
        ply:Horde_SetCardiacResonanceEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_cardiac_resonance" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 1)
        ply:Horde_SetCardiacResonanceEnabled(nil)
    end
end