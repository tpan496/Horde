PERK.PrintName = "Poison Weapon"
PERK.Description = [[Players you heal have Poison Weapon for {1} seconds.
Adds extra Poison damage to Physical damage while you have Poison Weapon.
Only applies to direct Physical attacks.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("")  then return end
end