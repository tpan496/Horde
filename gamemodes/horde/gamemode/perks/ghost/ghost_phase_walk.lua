PERK.PrintName = "Phase Walk"
PERK.Description = "Running does not cancel Camoflague.\n{1} increased movement speed when you have Camoflague.\nAdds {2} evasion when you have Camoflague."
PERK.Icon = "materials/perks/phase_walk.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "ghost_phase_walk" then
        ply:Horde_SetRemoveCamoflagueOnRun(0)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "ghost_phase_walk" then
        ply:Horde_SetRemoveCamoflagueOnRun(1)
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("ghost_phase_walk") or not ply:Horde_GetCamoflagueEnabled() then return end
    if ply:Horde_GetCamoflague() == 1 then
        bonus_walk.increase = bonus_walk.increase + 0.25
        bonus_run.increase = bonus_run.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("ghost_phase_walk")  then return end
    if ply:Horde_GetCamoflague() == 1 then
        bonus.evasion = bonus.evasion + 0.15
    end
end