PERK.PrintName = "Purging Flame"
PERK.Description =
[[Solar Orb leaves behind ion clouds.
Ion clouds deal continuous Physical damage to enemies.]]
PERK.Icon = "materials/subclasses/artificer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply)
end