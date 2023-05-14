PERK.PrintName = "Repair Catalyst"
PERK.Description = "Adds {1} to maximum armor regeneration."
PERK.Icon = "materials/perks/repair_catalyst.png"
PERK.Params = {
    [1] = {value = 0.1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_repair_catalyst" then
        ply:Horde_SetArmorRegenMax(ply:Horde_GetArmorRegenMax() + 0.1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_repair_catalyst" then
        ply:Horde_SetArmorRegenMax(ply:Horde_GetArmorRegenMax() - 0.1)
    end
end
