PERK.PrintName = "Corrosion"
PERK.Description =
[[{1} increased Break buildup.]]
PERK.Icon = "materials/subclasses/virologist.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("virologist_enfeeble")  then return end
end