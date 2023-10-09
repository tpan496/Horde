PERK.PrintName = "Ghost Veil"
PERK.Description = "Attacking does not cancel Camoflague.\n{1} increased walk speed when you have Camoflague.\n{2} increased Ballistic damage when you have Camoflague."
PERK.Icon = "materials/perks/ghost_veil.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
    [2] = {value = 0.1, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "ghost_ghost_veil" then
        ply:Horde_SetRemoveCamoflagueOnAttack(0)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "ghost_ghost_veil" then
        ply:Horde_SetRemoveCamoflagueOnAttack(1)
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("ghost_ghost_veil") or not ply:Horde_GetCamoflagueEnabled() then return end
    if ply:Horde_GetCamoflague() == 1 then
        bonus_walk.increase = bonus_walk.increase + 0.15
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_ghost_veil") then return end
    if not (ply:Horde_GetCamoflague() == 1) then return end
    bonus.increase = bonus.increase + 0.10
end