PERK.PrintName = "Survivor Base"
PERK.Description = "No bonus."

 = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "survivor_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "survivor_base" then
    end
end