PERK.PrintName = "Rip and Tear"
PERK.Description = "Do {percent} extra melee (clubbing, slashing) damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_CLUB) or dmginfo:IsDamageType(DMG_SLASH))
            and attacker:Horde_GetPerk(PERK.ClassName) then
        dmginfo:ScaleDamage(1 + attacker:Horde_GetPerkParam(PERK.ClassName, "percent"))
    end
end