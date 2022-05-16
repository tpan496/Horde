PERK.PrintName = "Solar Thrust"
PERK.Description =
[[Press Shift+E to launch yourself in air.
Creates an explosion that deals Fire damage when activated.
Increase passive energy regeneration.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end