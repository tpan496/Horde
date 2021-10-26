PERK.PrintName = "Phase Walk"
PERK.Description = "Running does not cancel Camoflague.\n{1} increased movement speed when you have Camoflague.\n{2} increased evasion when you have Camoflague."
PERK.Icon = "materials/perks/phase_walk.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [1] = {value = 0.10, percent = true},
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

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, mv)
    if not ply:Horde_GetPerk("ghost_phase_walk") or not ply:Horde_GetCamoflagueEnabled() then return end
    if ply:Horde_GetCamoflague() == 1 then
        ply:SetWalkSpeed(ply:GetWalkSpeed() * 1.25)
        ply:SetRunSpeed(ply:GetRunSpeed() * 1.25)
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("ghost_phase_walk")  then return end
    bonus.evasion = bonus.evasion + 0.10
end