PERK.PrintName = "Ghost Base"
PERK.Description = "25% more headshot damage.\nCrouch to activate Camoflague, granting 15% evasion.\n\nRunning or jumping removes Camoflague."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if SERVER and perk == "ghost_base" then
        ply:Horde_SetCamoflagueEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
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