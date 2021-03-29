PERK.PrintName = "Berserker Base"
PERK.Description = "The Berserker class is a melee-centered class that can be played both offensively and defensively.\nComplexity: HIGH\n\n20% increased global damage resistance.\n25% increased Poison damage resistance."

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_base" then
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if not ply:Horde_GetPerk("berserker_base")  then return end
    bonus.resistance = bonus.resistance + 0.20
    if dmg:GetDamageType() == DMG_POISON or dmg:GetDamageType() == DMG_ACID or dmg:GetDamageType() == DMG_NERVEGAS then
        bonus.resistance = bonus.resistance + 0.25
    end
end