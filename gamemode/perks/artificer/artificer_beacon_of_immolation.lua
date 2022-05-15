PERK.PrintName = "Beacon of Immolation"
PERK.Description =
[[Fire damage ignores enemy Fire damage resistance.
Your Lightning damage can Ignite.
Reduce cooldown of Solar Seal skills by 25%.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end