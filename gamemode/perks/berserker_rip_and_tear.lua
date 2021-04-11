PERK.PrintName = "Rip and Tear"
PERK.Description = "{1} more melee damage.\n{2} less Global damage resistance."
PERK.Icon = "materials/perks/rip_and_tear.png"
PERK.Params = {
    [1] = {value = 0.50, percent = true},
    [2] = {value = 0.10, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    local dmgtype = dmginfo:GetDamageType()
    if dmgtype == DMG_SLASH or dmgtype == DMG_CLUB then
        bonus.more = bonus.more * 1.5
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    bonus.resistance = bonus.resistance - 0.1
end