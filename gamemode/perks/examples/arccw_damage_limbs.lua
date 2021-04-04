PERK.PrintName = "Bone Breaker"
PERK.Description = "ArcCW weapons do 50% extra damage on arms and legs."

-- You can call ArcCW weapon hooks just like a regular hook (it's called by the base).
-- arccw/shared/attachments/default.lua has a list of hooks you can call as well as what the data variable contains.
local limbs = {HITGROUP_LEFTARM, HITGROUP_LEFTLEG, HITGROUP_RIGHTARM, HITGROUP_RIGHTLEG}
PERK.Hooks = {}
PERK.Hooks.Hook_BulletHit = function(wpn, data)
    local attacker = wpn:GetOwner()
    if SERVER and IsValid(attacker) and attacker:IsPlayer()
            and (table.HasValue(limbs, data.tr.HitGroup))
            and attacker:Horde_GetPerk("arccw_damage_limbs") then
        data.damage = data.damage * 1.5
    end
end