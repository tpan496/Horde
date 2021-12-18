PERK.PrintName = "Liquid Armor"
PERK.Description = "While you have at least {1} armor:\n  {2} increasaed Physical damage resistance.\n  Immune to Bleeding."
PERK.Icon = "materials/perks/liquid_armor.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.75, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("heavy_liquid_armor") then return end
    if ply:Armor() >= 5 and HORDE:IsPhysicalDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.75
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Armor() >= 5 and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end