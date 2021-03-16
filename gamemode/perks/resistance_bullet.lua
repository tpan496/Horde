PERK.PrintName = "Bulletproof"
PERK.Description = "Take {percent} less damage from bullets."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, max = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk("resistance_bullet") and
            (dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsBulletDamage()) then
        dmginfo:ScaleDamage(1 - target:Horde_GetPerkParam("resistance_bullet", "percent"))
    end
end