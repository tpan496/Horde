PERK.PrintName = "Incineration"
PERK.Description = "{1} increased Ignite damage."
PERK.Icon = "materials/perks/incineration.png"
PERK.Params = {
    [1] = {value = 0.75, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_incineration")  then return end
    if dmginfo:GetInflictor():GetClass() == "entityflame" then
        bonus.increase = bonus.increase + 0.75
    end
end