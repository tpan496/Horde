PERK.PrintName = "Floating Chaos"
PERK.Description =
[[Unlocks Floating Chaos for Solar Seal ({1} energy, R button).
Spawns a cluster of Solar Orbs that explode afte delay.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 40},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end