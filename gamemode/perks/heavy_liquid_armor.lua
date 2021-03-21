PERK.PrintName = "Liquid Armor"
PERK.Description = "75% reduced Physical damage taken while you have armor."

PERK.Parameters = {}

PERK.Hooks = {}

hook.Add("Horde_ApplyAdditionalDamageTaken", "Horde_LiquidArmorDamageTaken", function (ply, dmg, resistance)
    if not ply:Horde_GetPerk("heavy_liquid_armor") then return end
    if ply:Armor() > 0 and (dmg:GetDamageType() == DMG_BULLET or dmg:GetDamageType() == DMG_SLASH or dmg:GetDamageType() == DMG_CLUB or dmg:GetDamageType() == DMG_GENERIC) then
        resistance = resistance + 0.75
    end
end)
