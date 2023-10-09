PERK.PrintName = "Positron Array"
PERK.Description = "Immune to Fire damage.\nAbsorb {1} of Fire damage taken as health."
PERK.Icon = "materials/perks/positron_array.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("cremator_positron_array")  then return end
    if HORDE:IsFireDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 1.00
        if dmginfo:GetDamage() > 0 and dmginfo:GetDamage() * 0.06 then
            HORDE:OnPlayerHeal(ply, HealInfo:New({amount=math.max(1,dmginfo:GetDamage() * 0.06), healer=ply}))
        end
    end
end