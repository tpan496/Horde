PERK.PrintName = "Decapitate"
PERK.Description = "When you have Camoflague:\n  {1} increased Ballistic damage.\n  {2} increased headshot damage against elites."
PERK.Icon = "materials/perks/decapitate.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.50, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    
    if not ply:Horde_GetPerk("ghost_decapitate") then return end
    if not (ply:Horde_GetCamoflague() == 1) then return end
    if dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_SNIPER or dmginfo:GetDamageType() == DMG_BUCKSHOT then
        bonus.increase = bonus.increase + 0.25
    end

    if npc:GetVar("is_elite") and hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.50
    end
end
