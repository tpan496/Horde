PERK.PrintName = "Virologist Base"
PERK.Description = [[
Complexity: HIGH

Equipped with Anti-Bio Capsule. Upgradable through shop.
Upgrading Anti-Bio Capsule increases its Break buildup and area of effect.

LMB: Infection
Infects enemies with the selected virus in the targeted area.
Infected enemies receive Break buildup over time.
Virus lasts for 5 seconds.
Increase area of effect by charging.

RMB: Virus Switch
Changes the current virus in the capsule.
Enemies can be affected by multiple viruses at the same time.
- Type-α: Affected enemies take 20% increased Physical damage.
- Type-β: Affected enemies take 20% increased Elemental damage.

{1} increased virus effects. ({2} per level, up to {3}).
{1} increased Break buildup. ({2} per level, up to {3}).]]

PERK.Params = {
    [1] = {percent = true, level = 0.01, max = 0.25, classname = "Virologist"},
    [2] = {value = 0.001, percent = true},
    [3] = {value = 0.25, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("virologist_base") then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("chemist_base_2")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("virologist_base", math.min(0.3, 0.1 + 0.008 * ply:Horde_GetLevel("Chemist")))
        ply:Horde_SetPerkLevelBonus("virologist_base_2", math.min(0.75, 0.5 + 0.01 * ply:Horde_GetLevel("Chemist")))
    end
end