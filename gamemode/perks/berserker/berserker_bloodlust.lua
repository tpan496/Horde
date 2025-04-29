PERK.PrintName = "Bloodlust"
PERK.Description = [[
Leech {1} of melee damage dealt up to {2} health per hit.
Immune to Bleeding buildup.]]

PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 0.10, percent = true},
    [2] = {value = 10}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("berserker_bloodlust") then return end 
    if HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true then
        --[[
        local dmgheadshotcheck = dmginfo:GetDamage()
        if hitgroup == HITGROUP_HEAD then
            dmgheadshotcheck = dmginfo:GetDamage() * 2
        end
        ]]
        local leech = math.min(10, dmginfo:GetDamage() * 0.1)
        HORDE:SelfHeal(ply, leech)
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("berserker_bloodlust") and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end