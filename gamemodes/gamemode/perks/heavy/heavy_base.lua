PERK.PrintName = "Heavy Base"
PERK.Description = [[
The Heavy class is a tank class that provides strong suppression firepower.
Complexity: EASY

Regenerate {1} armor per second.
Regenerate up to {2} armor. ({3} + {4} per level, up to {5})]]
PERK.Params = {
    [1] = {value = 1},
    [2] = {base = 5, level = 1, max = 30, classname = HORDE.Class_Heavy},
    [3] = {value = 5},
    [4] = {value = 1},
    [5] = {value = 30},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_base" then
        ply:Horde_SetArmorRegenEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_base" then
        ply:Horde_SetArmorRegenEnabled(nil)
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("heavy_base", math.min(25, ply:Horde_GetLevel(HORDE.Class_Heavy)))
        ply:Horde_SetArmorRegenMax(5 + ply:Horde_GetPerkLevelBonus("heavy_base"))
        if ply:Horde_GetPerk("heavy_repair_catalyst") then
            ply:Horde_SetArmorRegenMax(15 + ply:Horde_GetPerkLevelBonus("heavy_base"))
        end
    end
end