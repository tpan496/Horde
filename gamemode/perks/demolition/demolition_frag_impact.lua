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
    if IsValid(inflictor) and (inflictor:GetClass() == "npc_grenade_frag" or inflictor:GetClass() == "arccw_go_nade_frag") and (not dmginfo:IsExplosionDamage()) then
        bonus.increase = bonus.increase + 0.25
        local dmg
        if inflictor:GetClass() == "npc_grenade_frag" then
            dmg = 150
        else
            dmg = 450
        end

        local rad = 150
        local e = EffectData()
        e:SetOrigin(inflictor:GetPos())
        util.Effect("Explosion", e)
        util.BlastDamage(inflictor, ply, inflictor:GetPos(), rad, dmg)
        npc:Horde_AddDebuffBuildup(HORDE.Status_Stun, 500, ply, npc:GetPos())
        inflictor:Remove()
    end
end