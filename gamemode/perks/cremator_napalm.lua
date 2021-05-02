PERK.PrintName = "Napalm"
PERK.Description = "{1} increased Ignite radius.\n{2} increased Ignite duration."
PERK.Icon = "materials/perks/napalm.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "cremator_napalm" then
        ply:Horde_SetApplyIgniteRadius(ply:Horde_GetApplyIgniteRadius() * 2)
        ply:Horde_SetApplyIgniteDuration(ply:Horde_GetApplyIgniteDuration() * 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "cremator_napalm" then
        ply:Horde_SetApplyIgniteRadius(ply:Horde_GetApplyIgniteRadius() / 2)
        ply:Horde_SetApplyIgniteDuration(ply:Horde_GetApplyIgniteDuration() / 2)
    end
end