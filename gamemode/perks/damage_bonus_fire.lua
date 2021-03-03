PERK.PrintName = "Pyromaniac"
PERK.Description = "Do {percent} extra fire damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and (dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_DIRECT))
            and attacker:Horde_GetPerk("damage_bonus_fire") then
        dmginfo:ScaleDamage(1 + attacker:Horde_GetPerkParam("damage_bonus_fire", "percent"))
    end
end