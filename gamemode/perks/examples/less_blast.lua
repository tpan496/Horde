PERK.PrintName = "Blastproof (less)"
PERK.Description = "25% less Blast damage taken."

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("less_blast") then return end
    if dmginfo:GetDamageType() == DMG_BLAST then
        bonus.less = bonus.less * 0.75
    end
end

-- About Damage Types, See: https://wiki.facepunch.com/gmod/Enums/DMG
-- Horde:
-- Ballistic: DMG_BULLET, DMG_SNIPER, DMG_BUCKSHOT
-- Melee: DMG_SLASH, DMG_CLUB
-- Fire: DMG_BURN