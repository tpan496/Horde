PERK.PrintName = "Bloodlust"
PERK.Description = "Leech {1} of melee damage dealt, up to {2} hp per hit.\nImmune to Bleeding."
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 10}
}

PERK.Hooks = {}
PERK.Hooks.PostEntityTakeDamage = function (ent, dmginfo, took)
    local attacker = dmginfo:GetAttacker()
    if took and ent:IsNPC() and attacker:IsPlayer() and attacker:Horde_GetPerk("berserker_bloodlust") and (HORDE:IsSlashDamage(dmginfo) or HORDE:IsBluntDamage(dmginfo)) then
        local leech = math.min(10, dmginfo:GetDamage() * 0.10)
        local ply = dmginfo:GetAttacker()
        local healinfo = HealInfo:New({amount=leech, healer=ply})
        HORDE:OnPlayerHeal(ply, healinfo)
    end
end


PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("berserker_bloodlust") and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end