PERK.PrintName = "Breathing Technique"
PERK.Description = "Regenerate 2% health per second."
PERK.Icon = "materials/perks/breathing_technique.png"

 = {}

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