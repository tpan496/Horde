PERK.PrintName = "Medic Base"
PERK.Description = "Regenerate 2% health per second."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "medic_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "medic_base" then
    end
end