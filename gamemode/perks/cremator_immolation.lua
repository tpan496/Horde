PERK.PrintName = "Immolation"
PERK.Description = "100% increased Ignite damage."
PERK.Icon = "materials/perks/immolation.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_immolation")  then return end
    if dmginfo:GetInflictor() == "entityflame" then
        bonus.increase = bonus.increase + 1.00
    end
end