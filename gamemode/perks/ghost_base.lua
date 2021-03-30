PERK.PrintName = "Ghost Base"
PERK.Description = "The Ghost class is focused on taking down boss enemies using Camoflague.\nComplexity: HIGH\n\n25% more headshot damage.\nCrouch to activate Camoflague, granting 15% evasion.\nAttacking, Running or Jumping REMOVES Camoflague."

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
