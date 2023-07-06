PERK.PrintName = "Pressurized Warhead"
PERK.Description = [[{1} increased Blast damage against elites.
{2} more Blast and Blunt damage on headshot.]]
PERK.Icon = "materials/perks/pressurized_warhead.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
    [2] = {value = 0.95, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_pressurized_warhead") then return end
    if HORDE:IsBlastDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo) then
        if npc:Horde_IsElite() and HORDE:IsBlastDamage(dmginfo) then
            bonus.increase = bonus.increase * 1.15
        end
        if hitgroup == HITGROUP_HEAD then
            bonus.more = bonus.more * 1.95
        end
    end
end
