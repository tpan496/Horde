PERK.PrintName = "Manhack"
PERK.Description = "Gain 1 Manhack minion every 30 seconds.\nManhack dies on impact, dealing its health as damage.\nYou can have at most 2 Manhacks."
PERK.Icon = "materials/perks/manhack.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "engineer_manhack" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "engineer_manhack" then
    end
end
