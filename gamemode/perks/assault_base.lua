PERK.PrintName = "Assault Base"
PERK.Description = "The Assault class is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.\nComplexity: EASY\n\nGain Adrenaline when you kill an enemy.\nAdrenaline increases damage and speed by 6%."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 1)
    end
end