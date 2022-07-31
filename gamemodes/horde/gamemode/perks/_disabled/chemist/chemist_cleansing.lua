PERK.PrintName = "Cleansing"
PERK.Description = [[Players you heal have Cleansing for {1} seconds.
{2} increased Poison damage resistance while you have Cleansing.
{3} reduced Break buildup taken while you have Cleansing.]]
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("")  then return end
end