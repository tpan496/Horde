PERK.PrintName = "Entropy Shield"
PERK.Description = "Gain a shield that negates damage taken.\nShield explodes on hit and recharges after {1} seconds.\nExplosion deals {2} Fire damage."
PERK.Icon = "materials/perks/entropy_shield.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 100},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_entropy_shield")  then return end
end