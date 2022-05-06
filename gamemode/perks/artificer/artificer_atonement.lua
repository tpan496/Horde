PERK.PrintName = "Atonement"
PERK.Description =
[[Increase damage resistance while charging.
Increase resistance by 10% for each charge stage.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end