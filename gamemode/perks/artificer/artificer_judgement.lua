PERK.PrintName = "Judgement"
PERK.Description =
[[Solar Storm can chain to multiple enemies.
Charging increases number of chains.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end