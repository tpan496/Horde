PERK.PrintName = "Berserker Base"
PERK.Description = "20% increased global damage resistance.\n25% increased Poison damage resistance."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
    end
end

PERK.Hooks.Horde_ApplyAdditionalDamageTaken = function(ply, dmg, resistance)
    if not ply:Horde_GetPerk("berserker_base")  then return end
    resistance.resistance = resistance.resistance + 0.20
    if dmg:GetDamageType() == DMG_POISON or dmg:GetDamageType() == DMG_ACID or dmg:GetDamageType() == DMG_NERVEGAS then
        resistance.resistance = resistance.resistance + 0.25
    end
end