PERK.PrintName = "Charge"
PERK.Description = "Adds 2 maximum Adrenaline stacks."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if perk == "assault_charge" then
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 2)
    end
end