PERK.PrintName = "Entropy Reflector"
PERK.Description = "Every damage taken increases Reflector stack by 1, up to 3.\nEach stack increases {1} Global damage resistance.\nLoses all stacks when max stack is exceeded."
PERK.Icon = "materials/perks/entropy_reflector.png"
PERK.Params = {
    [1] = {value = 0.07, percent = true},
    [2] = {value = 150}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_entropy_reflector")  then return end
end