PERK.PrintName = "Survivor Base"
PERK.Description = "The Survivor class can be played into any class to fill in missing roles for the team.\nComplexity: EASY\n\nNo bonus."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "survivor_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "survivor_base" then
    end
end