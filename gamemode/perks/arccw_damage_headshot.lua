PERK.PrintName = "Headhunter"
PERK.Description = "ArcCW weapons do {percent} extra damage on headshots."

PERK.Parameters = {
    ["percent"] = {type = "f", default = 0.5, min = 0, percent = true},
}

-- You can call ArcCW weapon hooks just like a regular hook (it's called by the base).
-- arccw/shared/attachments/default.lua has a list of hooks you can call as well as what the data variable contains.
PERK.Hooks = {}
PERK.Hooks.Hook_BulletHit = function(wpn, data)
    local attacker = wpn:GetOwner()
    if SERVER and IsValid(attacker) and attacker:IsPlayer()
            and data.tr.HitGroup == HITGROUP_HEAD and attacker:Horde_GetPerk("arccw_damage_headshot") then
        data.damage = data.damage * (1 + attacker:Horde_GetPerkParam("arccw_damage_headshot", "percent"))
    end
end