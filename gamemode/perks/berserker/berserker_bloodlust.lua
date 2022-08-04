PERK.PrintName = "Bloodlust"
PERK.Description = "Leech {1} of melee damage dealt, up to {2} hp per hit.\nImmune to Bleeding."
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 10}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("berserker_bloodlust") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
        local leech = math.min(10, dmginfo:GetDamage() * 0.10)
        HORDE:SelfHeal(ply, leech)
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("berserker_bloodlust") and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end