PERK.PrintName = "Brain Snap"
PERK.Description = "Headshots increases Freeze buildup based on weapon damage.\nEnemies affected by Freeze becomes immobile for {1} seconds.\nFreeze cooldown is {2} seconds."
PERK.Icon = "materials/perks/brain_snap.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 8},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_brain_snap") then return end

    if hitgroup == HITGROUP_HEAD then
        if npc:GetVar("is_boss") then
            npc:Horde_AddDebuffBuildup(HORDE.Status_Freeze, dmginfo:GetDamage() / 10, ply, dmginfo:GetDamagePosition())
        else
            npc:Horde_AddDebuffBuildup(HORDE.Status_Freeze, dmginfo:GetDamage() / 1.5, ply, dmginfo:GetDamagePosition())
        end
    end
end
