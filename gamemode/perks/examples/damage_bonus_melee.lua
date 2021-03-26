PERK.PrintName = "Bonus Melee Damage"
PERK.Description = "Do {percent} extra melee (clubbing, slashing) damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_CLUB) or dmginfo:IsDamageType(DMG_SLASH))
            and attacker:Horde_GetPerk("damage_bonus_melee") then
        dmginfo:ScaleDamage(1.5)
    end
end