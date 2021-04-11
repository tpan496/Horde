PERK.PrintName = "Ghost Base"
PERK.Description = "The Ghost class is focused on taking down boss enemies using Camoflague.\nComplexity: HIGH\n\n{1} more headshot damage.\nCrouch to activate Camoflague, granting {2} evasion.\nAttacking, Running or Jumping REMOVES Camoflague."
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "ghost_base" then
        ply:Horde_SetCamoflagueEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "ghost_base" then
        ply:Horde_SetCamoflagueEnabled(nil)
    end
end


PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("ghost_base") then return end
    if hitgroup == HITGROUP_HEAD then
        bonus.more = bonus.more * 1.25
    end
end
