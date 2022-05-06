PERK.PrintName = "Artificer Base"
PERK.Description = [[
{1} increased Fire damage resistance. ({2} + {3} per level, up to {4}).
{1} increased Lightning damage resistance. ({2} + {3} per level, up to {4}).

Equipped with Solar Seal. Upgradable through shop.
LMB: Solar Orb (5 - 20 Energy)
Releases a projectile that deals Fire damage. Hold for splash and extra damage.

RMB: Solar Storm (10 - 40 Energy)
Releases a powerful lightning strike at the target. Hold for extra range and damage.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {percent = true, base = 0.25, level = 0.01, max = 0.5, classname = HORDE.Class_Engineer},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.01, percent = true},
    [4] = {value = 0.50, percent = true},
    [5] = {percent = true, base = 0, level = 0.008, max = 0.20, classname = HORDE.Class_Engineer},
    [6] = {value = 0.008, percent = true},
    [7] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("artificer_base")  then return end
    if HORDE:IsFireDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus("cremator_base") - 0.25
    end
end