PERK.PrintName = "Bushido"
PERK.Description = "Melee headshots increases Stun buildup.\n{2} increased movement speed."
PERK.Icon = "materials/perks/bushido.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_bushido") then return end
    if hitgroup == HITGROUP_HEAD and HORDE:IsMeleeDamage(dmginfo) then
        npc:Horde_AddStun(dmginfo:GetDamage())
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus)
    if not ply:Horde_GetPerk("berserker_bushido") then return end
    bonus.walkspd = bonus.walkspd * 1.25
    bonus.sprintspd = bonus.sprintspd * 1.25
end