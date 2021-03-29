PERK.PrintName = "Rip and Tear"
PERK.Description = "40% more melee damage.\n10% increased damage taken."
PERK.Icon = "materials/perks/rip_and_tear.png"

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    local dmgtype = dmginfo:GetDamageType()
    if dmgtype == DMG_SLASH or dmgtype == DMG_CLUB then
        bonus.more = bonus.more * 1.4
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmg, bonus)
    if not ply:Horde_GetPerk("berserker_rip_and_tear") then return end
    bonus.resistance = bonus.resistance - 0.1
end