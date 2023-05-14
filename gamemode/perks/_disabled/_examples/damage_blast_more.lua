PERK.PrintName = "High Explosive (more)"
PERK.Description = "Do 50% more blast damage."

PERK.Hooks = {}
PERK.Hooks.OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsExplosionDamage())
            and attacker:Horde_GetPerk("damage_blast_more") then
        bonus.more = bonus.more * 1.5
    end
end

-- About Damage Types, See: https://wiki.facepunch.com/gmod/Enums/DMG
-- Horde:
-- Ballistic: DMG_BULLET, DMG_SNIPER, DMG_BUCKSHOT
-- Melee: DMG_SLASH, DMG_CLUB
-- Fire: DMG_BURN