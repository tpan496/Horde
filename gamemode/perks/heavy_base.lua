PERK.PrintName = "Heavy Base"
PERK.Description = "Regenerate 1 armor per second.\nRegenerate up to 25 armor."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "heavy_base" then
        ply:Horde_SetArmorRegenEnabled(true)
        ply:Horde_SetWeight(HORDE.max_weight + 5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "heavy_base" then
        ply:Horde_SetArmorRegenEnabled(false)
        ply:Horde_SetWeight(HORDE.max_weight)
        ply:Horde_SetArmor(0)
    end
end