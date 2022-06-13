PERK.PrintName = "Sarin Mist"
PERK.Description = [[Press SHIFT+E to release a sarin mist.
Sarin Mist increases Break buildup over time.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("")  then return end
end