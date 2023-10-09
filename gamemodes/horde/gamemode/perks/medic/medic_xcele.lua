PERK.PrintName = "Accelerated Healing Factor"
PERK.Description = "Buffs you apply are {1} more effective.\nBuffs you apply have {2} increased duration."
PERK.Icon = "materials/perks/xcele.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 0.50, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "medic_xcele" then
        ply:Horde_SetApplyBuffMore(1)
        ply:Horde_SetApplyBuffDuration(ply:Horde_GetApplyBuffDuration() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "medic_xcele" then
        ply:Horde_SetApplyBuffMore(0)
        ply:Horde_SetApplyBuffDuration(ply:Horde_GetApplyBuffDuration() / 1.5)
    end
end