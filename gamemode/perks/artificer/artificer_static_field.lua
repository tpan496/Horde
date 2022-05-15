PERK.PrintName = "Static Field"
PERK.Description =
[[Press Shift+E to generate a static field.
Static field deals continuous Lightning damage to enemies.
Solar Seal skills cost no energy when you are in static field.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end