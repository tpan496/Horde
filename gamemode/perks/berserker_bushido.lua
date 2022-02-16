PERK.PrintName = "Bushido"
PERK.Description = "{1} increased Slashing damage.\n{2} increased movement speed."
PERK.Icon = "materials/perks/bushido.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_bushido") then return end
    if HORDE:IsSlashDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus)
    if not ply:Horde_GetPerk("berserker_bushido") then return end
    bonus.walkspd = bonus.walkspd * 1.25
    bonus.sprintspd = bonus.sprintspd * 1.25
end