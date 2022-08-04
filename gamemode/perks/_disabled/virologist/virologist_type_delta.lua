PERK.PrintName = "Type-δ"
PERK.Description = [[Adds a new virus type.
Enemies affected by the virus deals {1} reduced Physical damage.
Enemies affected by the virus inflicts {2} reduced Bleeding buildup.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("")  then return end
end