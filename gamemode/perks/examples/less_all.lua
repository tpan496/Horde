PERK.PrintName = "Tough (less)"
PERK.Description = "10% less Global damage taken."

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("less_all") then return end
    bonus.less = bonus.less * 0.9
end