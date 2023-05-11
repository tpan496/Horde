PERK.PrintName = "Resolution"
PERK.Description =
[[Reduces your total weight to 7.
{1} more Melee damage.
+3 damage block.]]
PERK.Icon = "materials/perks/samurai/resolution.png"
PERK.Params = {
    [1] = {value = 0.75, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("samurai_resolution") then return end
    if HORDE:IsMeleeDamage(dmginfo) then
        bonus.more = bonus.more * 1.75
    end
end

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_resolution" then
        ply:Horde_SetMaxWeight(7)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "samurai_resolution" then
        ply:Horde_SetMaxWeight(HORDE.max_weight)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("samurai_resolution") then return end
    bonus.block = bonus.block + 3
end