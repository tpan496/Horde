PERK.PrintName = "Hallowed Bolt"
PERK.Description =
[[20% increased Shock buildup.
Unlocks Hallowed Bolt for Solar Seal ({1} energy, R button).
Strikes the ground from above, dealing heavy Lightning damage in an area.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 40},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end