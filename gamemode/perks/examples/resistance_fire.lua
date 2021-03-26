PERK.PrintName = "Fireproof"
PERK.Description = "Take {percent} less fire damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk("resistance_fire") and
            (dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_DIRECT)) then
        dmginfo:ScaleDamage(0.5)
    end
end