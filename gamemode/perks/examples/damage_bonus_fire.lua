PERK.PrintName = "Bonus Fire Damage"
PERK.Description = "Do {percent} extra fire damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_DIRECT))
            and attacker:Horde_GetPerk("damage_bonus_fire") then
        dmginfo:ScaleDamage(1.5)
    end
end