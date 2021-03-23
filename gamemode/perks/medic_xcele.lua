PERK.PrintName = "Accelerated Healing Factor"
PERK.Description = "50% increased health regeneration per second.\nBuffs you apply are 100% more effective."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "medic_xcele" then
        ply:Horde_SetApplyBuffMore(ply:Horde_GetApplyBuffMore() * 2)
        ply:Horde_SetHealthRegenPercentage(ply:Horde_GetHealthRegenPercentage() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if SERVER and perk == "medic_xcele" then
        ply:Horde_SetApplyBuffMore(ply:Horde_GetApplyBuffMore() / 2)
        ply:Horde_SetHealthRegenPercentage(ply:Horde_GetHealthRegenPercentage() / 1.5)
    end
end