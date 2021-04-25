PERK.PrintName = "Scorch"
PERK.Description = "15% increased Fire damage against Ignited enemies."
PERK.Icon = "materials/perks/scorch.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_scorch")  then return end
end