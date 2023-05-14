PERK.PrintName = "Knockout"
PERK.Description = "Blast damage increases Stun buildup.\nEnemies affected by Stun is paralyzed for {1} seconds.\nStun cooldown is {2} seconds."
PERK.Icon = "materials/perks/knockout.png"
PERK.Params = {
    [1] = {value = 3},
    [2] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("demolition_knockout") and HORDE:IsBlastDamage(dmginfo) then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Stun, dmginfo:GetDamage() / 2, ply, npc:GetPos())
    end
end