PERK.PrintName = "DPS Maniac"
PERK.Description = "All damage dealt is increased by {percent}."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(target, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and attacker:Horde_GetPerk("damage_bonus_all") then
        dmginfo:ScaleDamage(1.5)
    end
end