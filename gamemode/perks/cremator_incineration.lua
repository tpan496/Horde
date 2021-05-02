PERK.PrintName = "Incineration"
PERK.Description = "{1} increased Ignite damage.\n{2} increased Ignite chance."
PERK.Icon = "materials/perks/incineration.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 0.35, percent = true}
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "cremator_incineration" then
        ply:Horde_SetApplyIgniteChance(ply:Horde_GetApplyIgniteChance() + 0.35)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "cremator_incineration" then
        ply:Horde_SetApplyIgniteChance(ply:Horde_GetApplyIgniteChance() - 0.35)
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_incineration")  then return end
    if dmginfo:GetInflictor():GetClass() == "entityflame" then
        bonus.increase = bonus.increase + 1.00
    end
end