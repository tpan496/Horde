PERK.PrintName = "Brain Snap"
PERK.Description = "Headshots increases Freeze buildup based on weapon damage.\nEnemies affected by Freeze becomes immobile for {1} seconds.\nFrostbite cooldown is {2} seconds."
PERK.Icon = "materials/perks/brain_snap.png"
PERK.Params = {
    [1] = {value = 3},
    [2] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("ghost_brain_snap") then return end

    if hitgroup == HITGROUP_HEAD then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Freeze, dmginfo:GetDamage() / 1.5, ply, dmginfo:GetDamagePosition())
    end
end
