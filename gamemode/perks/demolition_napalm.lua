PERK.PrintName = "Napalm"
PERK.Description = "{1} increased Fire damage.\n{2} reduced Fire damage taken."
PERK.Icon = "materials/perks/napalm.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.75, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_napalm")  then return end
    if dmginfo:GetDamageType() == DMG_BURN then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("demolition_napalm")  then return end
    if dmginfo:GetDamageType() == DMG_BURN then
        bonus.resistance = bonus.resistance + 0.75
    end
end