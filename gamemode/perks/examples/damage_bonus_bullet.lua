PERK.PrintName = "Bonus Bullet Damage"
PERK.Description = "Do {percent} extra bullet damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsBulletDamage())
            and attacker:Horde_GetPerk("damage_bonus_bullet") then
        dmginfo:ScaleDamage(1 + attacker:Horde_GetPerkParam("damage_bonus_bullet", "percent"))
    end
end