PERK.PrintName = "Ghost Base"
PERK.Description = [[
The Ghost class is focused on taking down boss enemies using Camoflague.
Complexity: HIGH

{1} more headshot damage. ({2} per level, up to {3}).

Crouch to activate Camoflague, granting {4} evasion.
Attacking or Running REMOVES Camoflague.]]
PERK.Params = {
    [1] = {percent = true, level = 0.01, max = 0.25, classname = HORDE.Class_Ghost},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
    [4] = {value = 0.25, percent = true},
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
        bonus.more = bonus.more * ply:Horde_GetPerkLevelBonus("ghost_base")
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        ply:Horde_SetPerkLevelBonus("ghost_base", 1 + math.min(0.25, 0.01 * ply:Horde_GetLevel(HORDE.Class_Ghost)))
    end
end