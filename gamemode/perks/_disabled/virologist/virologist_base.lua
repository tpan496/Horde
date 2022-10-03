PERK.PrintName = "Virologist Base"
PERK.Description = [[
Complexity: HIGH

{1} increased Virus effects. ({2} per level, up to {3}).
{4} increased Break buildup. ({5} per level, up to {6}).

Equipped with Anti-Bio Capsule. Upgradable through shop.

LMB: Infection
Infects enemies and applies Break buildup over time in the target area.
Virus lasts for 5 seconds.
Hold LMB to increase area of effect.

RMB: Virus Switch
Changes the current Virus for Infection.
- Type-α: Affected enemies take 15% increased Physical damage.
- Type-β: Affected enemies take 15% increased Elemental damage.]]

PERK.Params = {
    [1] = {percent = true, level = 0.02, max = 0.5, classname = "Virologist"},
    [2] = {value = 0.02, percent = true},
    [3] = {value = 0.5, percent = true},
    [4] = {percent = true, level = 0.01, max = 0.25, classname = "Virologist"},
    [5] = {value = 0.01, percent = true},
    [6] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("virologist_base", math.min(1, 0.04 * ply:Horde_GetLevel("Chemist")))
        ply:Horde_SetPerkLevelBonus("virologist_base_2", math.min(0.25, 0.01 * ply:Horde_GetLevel("Chemist")))
    end
end