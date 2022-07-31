PERK.PrintName = "Liquid Armor"
PERK.Description = "While you have at least {1} armor:\n  {2} less Physical damage taken."
PERK.Icon = "materials/perks/liquid_armor.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.40, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("heavy_liquid_armor") then return end
    if ply:Armor() >= 5 and HORDE:IsPhysicalDamage(dmginfo) then
        bonus.less = bonus.less * 0.60
    end
end