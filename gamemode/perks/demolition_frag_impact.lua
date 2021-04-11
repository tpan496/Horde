PERK.PrintName = "Impact Detonation"
PERK.Description = "Grenades explode on enemy impact.\nGrenade damage increased by {1}."
PERK.Icon = "materials/perks/frag_impact.png"
PERK.Params = {
    [1] = {value = 0.50, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.EntityTakeDamage = function(victim, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local ent = dmginfo:GetInflictor()
    if (victim:IsNPC() or victim:IsNextBot()) and IsValid(ent)
            and ent:GetClass() == "npc_grenade_frag" and IsValid(attacker)
            and not dmginfo:IsExplosionDamage() and attacker:Horde_GetPerk("demolition_frag_impact") then
        local dmg = 125 * 1.5
        local rad = 250
        local e = EffectData()
        e:SetOrigin(ent:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(ent, attacker, ent:GetPos(), rad, dmg)
        ent:Remove()
    end
end