PERK.PrintName = "Breathing Technique"
PERK.Description = "Regenerate 2% health per second.\nImmune to Poison damage."
PERK.Icon = "materials/perks/breathing_technique.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_breathing_technique" then
        ply:Horde_SetHealthRegenEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_breathing_technique" then
        ply:Horde_SetHealthRegenEnabled(nil)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("berserker_breathing_technique") then return end
    if dmginfo:GetDamageType() == DMG_NERVEGAS or dmginfo:GetDamageType() == DMG_ACID or dmginfo:GetDamageType() == DMG_POISON then
        bonus.resistance = bonus.resistance + 1.0
    end
end