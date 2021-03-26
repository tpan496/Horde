PERK.PrintName = "Resistant"
PERK.Description = "Take {percent} less damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    if target:IsPlayer() and target:Horde_GetPerk("resistance_all") then
        dmginfo:ScaleDamage(0.9)
    end
end