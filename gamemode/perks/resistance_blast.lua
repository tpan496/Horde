PERK.PrintName = "Blastproof"
PERK.Description = "Take {percent} less explosive damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.75, min = 0, max = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk("resistance_blast") and
            (dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsExplosionDamage()) then
        dmginfo:ScaleDamage(1 - target:Horde_GetPerkParam("resistance_blast", "percent"))
    end
end