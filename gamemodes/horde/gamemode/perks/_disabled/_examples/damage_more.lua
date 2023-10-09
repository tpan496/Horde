PERK.PrintName = "DPS Maniac (more)"
PERK.Description = "Deal 50% more damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(ply, npc, bonus, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and attacker:Horde_GetPerk("damage_more") then
        bonus.more = bonus.more * 1.5
    end
end