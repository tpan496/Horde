PERK.PrintName = "Meditate"
PERK.Description =
[[{1} increased maximum mind.]]
PERK.Icon = "materials/perks/warlock/meditate.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxMind = function(ply, bonus)
    if ply:Horde_GetPerk("warlock_meditate") then
        bonus.increase = bonus.increase + 0.25
    end
end