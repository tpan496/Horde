PERK.PrintName = "High Explosive (increase)"
PERK.Description = "Do 50% increase blast damage."

PERK.Hooks = {}
PERK.Hooks.OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsExplosionDamage())
            and attacker:Horde_GetPerk("damage_blast_increase") then
        bonus.increase = bonus.increase + 0.5
    end
end

-- About Damage Types, See: https://wiki.facepunch.com/gmod/Enums/DMG
-- Horde:
-- Ballistic: DMG_BULLET, DMG_SNIPER, DMG_BUCKSHOT
-- Melee: DMG_SLASH, DMG_CLUB
-- Fire: DMG_BURN