PERK.PrintName = "Reactive Armor"
PERK.Description = "While you have at least {1} armor:\n  Immune to Poison, Fire and Blast damage."
PERK.Icon = "materials/perks/reactive_armor.png"
PERK.Params = {
    [1] = {value = 5},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("heavy_reactive_armor") then return end
    if ply:Armor() >= 5 and (dmginfo:GetDamageType() == DMG_NERVEGAS or dmginfo:GetDamageType() == DMG_ACID or dmginfo:GetDamageType() == DMG_POISON or dmginfo:GetDamageType() == DMG_FIRE or dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_BLAST) then
        bonus.resistance = bonus.resistance + 1.0
    end
end
