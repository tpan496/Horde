PERK.PrintName = "Impact Detonation"
PERK.Description = "Grenades explode on enemy impact.\nGrenade damage increased by {}%."

PERK.Parameters = {
    ["damage"] = {type = "i", default = 125, min = 0},
    ["increase"] = {type = "f", default = 0.5, min = 0, precent = true},
    ["radius"] = {type = "i", default = 200, min = 0},
}

PERK.Hooks = {}

PERK.Hooks.EntityTakeDamage = function(victim, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local ent = dmginfo:GetInflictor()
    if (victim:IsNPC() or victim:IsNextBot()) and IsValid(ent)
            and ent:GetClass() == "npc_grenade_frag" and IsValid(attacker)
            and not dmginfo:IsExplosionDamage() and attacker:Horde_GetPerk("demolition_frag_impact") then
        local dmg = attacker:Horde_GetPerkParam("demolition_frag_impact", "damage")
        local increase = attacker.Horde_GetPerkParam("demolition_frag_impact", "increase")
        local rad = attacker:Horde_GetPerkParam("demolition_frag_impact", "radius")
        local e = EffectData()
        e:SetOrigin(ent:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(ent, attacker, ent:GetPos(), rad, dmg * (1 + increase))
        ent:Remove()
    end
end