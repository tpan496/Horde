PERK.PrintName = "Ionize"
PERK.Description = "Enemies you kill have {1} chance to generate a blue flame.\nBlue flame deals damage over time.\nEnemies in blue flame take increased Fire damage."
PERK.Icon = "materials/perks/scorch.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_incineration")  then return end
end