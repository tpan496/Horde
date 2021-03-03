PERK.PrintName = "Resistant"
PERK.Description = "Take {percent} less damage."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.1, min = 0, max = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk(PERK.ClassName) then
        dmginfo:ScaleDamage(1 - target:Horde_GetPerkParam(PERK.ClassName, "percent"))
    end
end