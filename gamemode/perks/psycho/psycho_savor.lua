PERK.PrintName = "Savor"
PERK.Description = [[
{1} increased Critical Hit damage.
Leech {2} of damage dealt when you land a Melee hit.
Leech caps at {3} health per hit or {4} health per Critical Hit.]]
PERK.Icon = "materials/perks/psycho/savor.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.1, percent = true},
    [3] = {value = 2},
    [4] = {value = 10},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("psycho_savor") and (HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true) then
        local leech = math.min(10, dmginfo:GetDamage() * 0.1)
        if ply.PsychoLeechCrit then
            HORDE:SelfHeal(ply, math.min(10, leech))
            ply.PsychoLeechCrit = nil
        else
            HORDE:SelfHeal(ply, math.min(2, leech))
        end
    end
end

PERK.Hooks.Horde_OnPlayerCritical = function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetPerk("psycho_savor") then
        bonus.increase = bonus.increase + 0.25
        if HORDE:IsMeleeDamage(dmginfo) or HORDE:IsCurrentWeapon(dmginfo, "Melee") == true then
            ply.PsychoLeechCrit = true
        end
    end
end