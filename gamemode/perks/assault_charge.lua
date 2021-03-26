PERK.PrintName = "Charge"
PERK.Description = "Each Adrenaline stack increases damage and speed by 5%.\nAdds 2 maximum Adrenaline stacks."
PERK.Icon = "materials/perks/charge.png"

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 2)
    end
end