PERK.PrintName = "Napalm"
PERK.Description = "{1} increased Ignite duration."
PERK.Icon = "materials/perks/napalm.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "cremator_napalm" then
        ply:Horde_SetApplyIgniteDuration(ply:Horde_GetApplyIgniteDuration() * 1.5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "cremator_napalm" then
        ply:Horde_SetApplyIgniteDuration(ply:Horde_GetApplyIgniteDuration() / 1.5)
    end
end