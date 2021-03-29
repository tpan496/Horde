PERK.PrintName = "Heavy Base"
PERK.Description = "Regenerate 1 armor per second.\nRegenerate up to 25 armor."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_base" then
        ply:Horde_SetArmorRegenEnabled(true)
        ply:Horde_SetWeight(HORDE.max_weight + 5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_base" then
        ply:Horde_SetArmorRegenEnabled(nil)
        ply:Horde_SetWeight(HORDE.max_weight)
    end
end