PERK.PrintName = "DPS Maniac (increase)"
PERK.Description = "Deal 50% increased damage."

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(ply, npc, bonus, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if attacker:IsPlayer() and attacker:Horde_GetPerk("damage_increase") then
        bonus.increase = bonus.increase + 0.5
    end
end