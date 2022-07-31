PERK.PrintName = "Dirac Sea"
PERK.Description =
[[{1} increased maximum energy.
Removes explosion damage falloff for Astral Pulsar and Astral Remnants.
Charged Astral Remnants leave behind uncharged Astral Remnants on explosion.]]
PERK.Icon = "materials/perks/warlock/dirac_sea.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 5},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNetherStarLaunch = function (ply, properties)
    if ply:Horde_GetPerk("warlock_dirac_sea") then
        properties.dirac_sea = true
    end
end

PERK.Hooks.Horde_OnNetherMineLaunch = function (ply, properties)
    if ply:Horde_GetPerk("warlock_dirac_sea") then
        properties.dirac_sea = true
    end
end