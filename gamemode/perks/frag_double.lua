PERK.PrintName = "Pressure Blast"
PERK.Description = "Grenades and SLAMs do an extra blast with {damage}dmg in {radius}HU."

PERK.Parameters = {
    ["damage"] = {type = "i", default = 200, min = 0},
    ["radius"] = {type = "i", default = 400, min = 0},
}

local exp = {npc_grenade_frag = true, npc_satchel = true, npc_tripmine = true}
PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function(ent)
    local owner = ent:GetInternalVariable("m_hThrower")
    if not owner then ent = ent:GetInternalVariable("m_hOwner") end
    if SERVER and IsValid(ent) and exp[ent:GetClass()] and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("frag_double") then
        local dmg = owner:Horde_GetPerkParam("frag_double", "damage")
        local rad = owner:Horde_GetPerkParam("frag_double", "radius")
        local pos = ent:GetPos()
        local wep = ent:GetClass() == "npc_grenade_frag" and owner:GetWeapon("weapon_frag") or owner:GetWeapon("weapon_slam")
        timer.Simple(0.08, function()
            local e = EffectData()
            e:SetOrigin(pos)
            util.Effect("Explosion", e)
            util.BlastDamage(wep, owner, pos, rad, dmg)
        end)
    end
end