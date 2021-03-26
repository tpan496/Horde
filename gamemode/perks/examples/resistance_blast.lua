PERK.PrintName = "Blastproof"
PERK.Description = "Take {percent} less explosive damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk("resistance_blast") and
            (dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsExplosionDamage()) then
        dmginfo:ScaleDamage(0.25)
    end
end