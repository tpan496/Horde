PERK.PrintName = "Ambush"
PERK.Description = "{1} increased headshot damage."
PERK.Icon = "materials/perks/ambush.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not hitgroup == HITGROUP_HEAD then return end
    if not ply:Horde_GetPerk("assault_ambush") then return end
     bonus.increase = bonus.increase + 0.20
end