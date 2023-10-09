PERK.PrintName = "Quickcast"
PERK.Description =
[[{1} increased spell charging speed.]]
PERK.Icon = "materials/perks/warlock/quickcast.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSpellCharge = function (ply, bonus)
    if ply:Horde_GetPerk("warlock_quickcast") then
        bonus.increase = bonus.increase + 0.25
    end
end
