PERK.PrintName = "High Explosives"
PERK.Description = "Do {percent} extra blast damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BLAST) or dmginfo:IsExplosionDamage())
            and attacker:Horde_GetPerk(PERK.ClassName) then
        dmginfo:ScaleDamage(1 + attacker:Horde_GetPerkParam(PERK.ClassName, "percent"))
    end
end