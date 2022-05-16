PERK.PrintName = "Beacon of Reckoning"
PERK.Description =
[[20% increased Shock buildup.
Lightning damage ignores enemy Lightning damage resistance.
Convert 100% of your damage into Lightning damage.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end