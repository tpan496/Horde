PERK.PrintName = "Impact Detonation"
PERK.Description = "{1} increased Blast damage.\n{2} increased Grenade damage."
PERK.Icon = "materials/perks/frag_impact.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
    [2] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_frag_impact")  then return end
    if dmginfo:GetDamageType() == DMG_BLAST or dmginfo:IsExplosionDamage() then
        bonus.increase = bonus.increase + 0.15
    end
    local inflictor = dmginfo:GetInflictor()
    if inflictor:GetClass() == "weapon_frag" or inflictor:GetClass() == "arccw_go_nade_frag" then
        bonus.increase = bonus.increase + 0.25
    end
end