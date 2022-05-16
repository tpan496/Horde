PERK.PrintName = "Purge"
PERK.Description =
[[{1} increased Shock buildup.
Charged Solar Storm removes mutations from main target.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end