PERK.PrintName = "Type-ω"
PERK.Description = [[Adds a new virus type.
Affected enemies deals {1} reduced Elemental damage.
Affected enemies inflicts {2} reduced Elemental status buildup.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("")  then return end
end