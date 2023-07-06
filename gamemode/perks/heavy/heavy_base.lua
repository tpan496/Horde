PERK.PrintName = "Heavy Base"
PERK.Description = [[
The Heavy class is a tank class that provides strong suppression firepower.
Complexity: EASY

{6} increased maximum armor. ({7} per level, up to {8}).

Regenerate {1} armor per second.
Regenerate up to {2} armor. ({3} + {4} per level, up to {5})]]
PERK.Params = {
    [1] = {value = 1},
    [2] = {percent = true, base = 0.05, level = 0.01, max = 0.3, classname = HORDE.Class_Heavy},
    [3] = {value = 0.05},
    [4] = {value = 0.01},
    [5] = {value = 0.3},
    [6] = {percent = true, level = 0.008, max = 0.2, classname = HORDE.Class_Heavy},
    [7] = {value = 0.008, percent = true},
    [8] = {value = 0.2, percent = true},
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
        ply:Horde_SetPerkLevelBonus("heavy_base", math.min(0.25, 0.01 * ply:Horde_GetLevel(HORDE.Class_Heavy)))
        ply:Horde_SetPerkLevelBonus("heavy_base2", math.min(0.2, 0.008 * ply:Horde_GetLevel(HORDE.Class_Heavy)))
        ply:Horde_SetArmorRegenMax(0.05 + ply:Horde_GetPerkLevelBonus("heavy_base"))
        if ply:Horde_GetPerk("heavy_repair_catalyst") then
            ply:Horde_SetArmorRegenMax(0.15 + ply:Horde_GetPerkLevelBonus("heavy_base"))
        end
    end
end

PERK.Hooks.Horde_OnSetMaxArmor = function (ply, bonus)
    if SERVER and ply:Horde_GetPerk("heavy_base") then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("heavy_base2")
    end
end