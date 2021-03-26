PERK.PrintName = "Reactive Armor"
PERK.Description = "While you have at least 5 armor:\n  Immune to Poison, Fire and Blast damage."
PERK.Icon = "materials/perks/reactive_armor.png"

 = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamageTaken", "Horde_ReactiveArmorDamageTaken", function (ply, dmg, resistance)
    if not ply:Horde_GetPerk("heavy_reactive_armor") then return end
    if ply:Armor() >= 5 and (dmg:GetDamageType() == DMG_NERVEGAS or dmg:GetDamageType() == DMG_ACID or dmg:GetDamageType() == DMG_POISON or dmg:GetDamageType() == DMG_FIRE or dmg:GetDamageType() == DMG_BURN or dmg:GetDamageType() == DMG_BLAST) then
        resistance = resistance + 1.0
    end
end)
