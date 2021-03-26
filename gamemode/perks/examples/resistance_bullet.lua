PERK.PrintName = "Bulletproof"
PERK.Description = "Take {percent} less damage from bullets."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk("resistance_bullet") and
            (dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsBulletDamage()) then
        dmginfo:ScaleDamage(0.5)
    end
end