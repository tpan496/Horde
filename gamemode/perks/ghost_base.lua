PERK.PrintName = "Ghost Base"
PERK.Description = "25% more headshot damage.\nCrouch to activate Camoflague, granting 15% evasion.\nRunning or jumping REMOVES Camoflague."

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


PERK.Hooks.Horde_ApplyAdditionalDamage = function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("ghost_base") then return end
    if hitgroup == HITGROUP_HEAD then
        bonus.more = bonus.more + 0.25
    end
end
