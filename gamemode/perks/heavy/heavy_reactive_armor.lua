PERK.PrintName = "Reactive Armor"
PERK.Description = "While you have at least {1} armor:\n  Immune to Fire and Blast damage."
PERK.Icon = "materials/perks/reactive_armor.png"
PERK.Params = {
    [1] = {value = 5},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("heavy_reactive_armor") then return end
    if ply:Armor() >= 5 and (HORDE:IsFireDamage(dmginfo) or HORDE:IsBlastDamage(dmginfo)) then
        bonus.resistance = bonus.resistance + 1.0
    end
end