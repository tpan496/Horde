PERK.PrintName = "Bonus Bullet Damage"
PERK.Description = "Do {percent} extra bullet damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsBulletDamage())
            and attacker:Horde_GetPerk("damage_bonus_bullet") then
        dmginfo:ScaleDamage(1.5)
    end
end