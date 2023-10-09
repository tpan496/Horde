PERK.PrintName = "Methane"
PERK.Description = "{1} increased Fire damage against Ignited enemies."
PERK.Icon = "materials/perks/methane.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("cremator_methane")  then return end
    if npc:IsOnFire() and HORDE:IsFireDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.15
    end
end