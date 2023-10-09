PERK.PrintName = "Natural Selection"
PERK.Description =
[[{1} increased Antlion evolve rate.]]
PERK.Icon = "materials/perks/hatcher/natural_selection.png"
PERK.Params = {
    [1] = {value = 0.5, percent = true},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnAntlionSelfEvolve = function(ply, npc, bonus)
    if not ply:Horde_GetPerk("hatcher_natural_selection") then return end
    bonus.increase = 0.5
end