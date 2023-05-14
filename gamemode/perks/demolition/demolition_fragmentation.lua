PERK.PrintName = "Fragmentation"
PERK.Description = "{1} increased Blast damage."
PERK.Icon = "materials/perks/fragmentation.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("demolition_fragmentation") then return end
    if HORDE:IsBlastDamage(dmginfo) then
        bonus.increase = bonus.increase + 0.2
    end
end