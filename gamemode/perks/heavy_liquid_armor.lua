PERK.PrintName = "Liquid Armor"
PERK.Description = "While you have at least 5 armor:\n  75% increasaed physical damage resistance."
PERK.Icon = "materials/perks/liquid_armor.png"

PERK.Hooks = {}
PERK.Hooks.Horde_ApplyAdditionalDamageTaken = function (ply, dmg, resistance)
    if not ply:Horde_GetPerk("heavy_liquid_armor") then return end
    if ply:Armor() >= 5 and (dmg:GetDamageType() == DMG_BULLET or dmg:GetDamageType() == DMG_SLASH or dmg:GetDamageType() == DMG_CLUB or dmg:GetDamageType() == DMG_GENERIC) then
        resistance.resistance = resistance.resistance + 0.75
    end
end
