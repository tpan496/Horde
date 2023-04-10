PERK.PrintName = "Godslayer"
PERK.Description =
[[{1} more Fire damage.
Your Lightning damage also inflicts Ignite.
Your Lightning spells leave behind Fire pits.]]
PERK.Icon = "materials/perks/artificer/godslayer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("artificer_godslayer")  then return end
    if HORDE:IsFireDamage(dmginfo) then
        bonus.more = bonus.more * 1.2
        npc:Horde_SetMostRecentFireAttacker(ply, dmginfo)
        npc:Ignite(ply:Horde_GetApplyIgniteDuration())
    end
end

PERK.Hooks.Horde_OnGodSlayerCheck = function (ply, param)
    if ply:Horde_GetPerk("artificer_godslayer") then
        param.godslayer = true
    end
end