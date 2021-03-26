PERK.PrintName = "High Explosive"
PERK.Description = "Do {percent} extra blast damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsExplosionDamage())
            and attacker:Horde_GetPerk("damage_bonus_blast") then
        dmginfo:ScaleDamage(1.5)
    end
end