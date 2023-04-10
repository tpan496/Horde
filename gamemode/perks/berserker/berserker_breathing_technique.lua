PERK.PrintName = "Breathing Technique"
PERK.Description = "Regenerate {1} health per second.\nImmune to Poison damage."
PERK.Icon = "materials/perks/breathing_technique.png"
PERK.Params = {
    [1] = {value = 0.02, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_breathing_technique" then
        ply:Horde_SetHealthRegenPercentage(0.02)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_breathing_technique" then
        ply:Horde_SetHealthRegenPercentage(0)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("berserker_breathing_technique") then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 1.0
    end
end

--[[PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("berserker_breathing_technique") and debuff == HORDE.Status_Break then
        bonus.apply = 0
        return true
    end
end]]--