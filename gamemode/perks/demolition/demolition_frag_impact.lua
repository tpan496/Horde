PERK.PrintName = "Impact Grenade"
PERK.Description = "{1} increased Grenade damage on impact.\nGrenades explode on impact.\nImpact explosions increases Stun buildup."
PERK.Icon = "materials/perks/frag_impact.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_frag_impact")  then return end
    local inflictor = dmginfo:GetInflictor()
    if inflictor:GetClass() == "npc_grenade_frag" or inflictor:GetClass() == "arccw_go_nade_frag" then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_frag_impact")  then return end
    local inflictor = dmginfo:GetInflictor()
    if inflictor:GetClass() == "npc_grenade_frag" or inflictor:GetClass() == "arccw_go_nade_frag" then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Stun, dmginfo:GetDamage(), ply, npc:GetPos())
    end
end

PERK.Hooks.EntityTakeDamage = function(victim, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local ent = dmginfo:GetInflictor()
    if not ent:IsValid() or not attacker:IsValid() then return end
    local class = ent:GetClass()
    if (victim:IsNPC() or victim:IsNextBot()) and IsValid(ent)
            and (class == "npc_grenade_frag" or class == "arccw_go_nade_frag") and IsValid(attacker)
            and not dmginfo:IsExplosionDamage() and attacker:IsPlayer() and attacker:Horde_GetPerk("demolition_frag_impact") then
        local dmg
        if class == "npc_grenade_frag" then
            dmg = 150
        else
            dmg = 450
        end

        local rad = 150
        local e = EffectData()
        e:SetOrigin(ent:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(ent, attacker, ent:GetPos(), rad, dmg)
        ent:Remove()
    end
end