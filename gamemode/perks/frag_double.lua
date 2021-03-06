PERK.PrintName = "Pressure Blast"
PERK.Description = "Grenades and SLAMs do an extra blast with {damage}dmg in {radius}HU."

PERK.Parameters = {
    ["damage"] = {type = "i", default = 200, min = 0},
    ["radius"] = {type = "i", default = 400, min = 0},
}

PERK.Hooks = {}
PERK.Hooks.EntityRemoved = function(ent)
    local owner = ent:GetOwner()
    if SERVER and (ent:GetClass() == "npc_grenade_frag" or ent:GetClass() == "npc_satchel" or ent:GetClass() == "npc_tripmine") and IsValid(owner)
            and owner:IsPlayer() and owner:Horde_GetPerk("frag_double") then
        local dmg = owner:Horde_GetPerkParam("frag_double", "damage")
        local rad = owner:Horde_GetPerkParam("frag_double", "radius")
        local pos = ent:GetPos()
        local wep = owner:GetWeapon("weapon_frag")
        timer.Simple(0.08, function()
            local e = EffectData()
            e:SetOrigin(pos)
            util.Effect("Explosion", e)
            util.BlastDamage(wep, owner, pos, rad, dmg)
        end)
    end
end