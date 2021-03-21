PERK.PrintName = "Phase Walk"
PERK.Description = "Running/Jumping does not cancel Camoflague.\n25% increased movement speed when you have Camoflague."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if perk == "ghost_phase_walk" then
        ply:Horde_SetRemoveCamoflagueOnRun(0)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if perk == "ghost_phase_walk" then
        ply:Horde_SetRemoveCamoflagueOnRun(0)
    end
end

hook.Add("Horde_PlayerMoveBonus", "Horde_PhaseWalkMoveBonus", function(ply, mv)
    if not ply:Horde_GetPerk("ghost_phase_walk") or not ply:Horde_CamoflagueEnabled() then return end
    if ply:Horde_GetCamoflague() == 1 then
        local bonus = 1.25
        ply:SetWalkSpeed(ply:GetWalkSpeed() * bonus)
        ply:SetRunSpeed(ply:GetRunSpeed() * bonus)
    end
end)