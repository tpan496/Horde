PERK.PrintName = "Accelerated Healing Factor"
PERK.Description = "{1} increased health regeneration per second.\nBuffs you apply are {2} more effective."
PERK.Icon = "materials/perks/xcele.png"
PERK.Params = {
    [1] = {value = 0.50, percent = true},
    [2] = {value = 1},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "medic_xcele" then
        ply:Horde_SetApplyBuffMore(1)
        ply:Horde_SetHealthRegenPercentage(ply:Horde_GetHealthRegenPercentage() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "medic_xcele" then
        ply:Horde_SetApplyBuffMore(0)
        ply:Horde_SetHealthRegenPercentage(ply:Horde_GetHealthRegenPercentage() / 1.5)
    end
end