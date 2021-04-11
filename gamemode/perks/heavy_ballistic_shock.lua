PERK.PrintName = "Ballistic Shock"
PERK.Description = "Debuffs you apply have {1} increased effect.\nDebuffs you apply have {2} increased duration."
PERK.Icon = "materials/perks/ballistic_shock.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_ballistic_shock" then
        ply:Horde_SetApplyDebuffMore(1)
        ply:Horde_SetApplyDebuffDuration(ply:Horde_GetApplyDebuffDuration() * 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_ballistic_shock" then
        ply:Horde_SetApplyDebuffMore(0)
        ply:Horde_SetApplyDebuffDuration(ply:Horde_GetApplyDebuffDuration() / 2)
    end
end
