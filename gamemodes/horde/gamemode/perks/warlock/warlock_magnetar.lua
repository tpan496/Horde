PERK.PrintName = "Magnetar"
PERK.Description =
[[+{1} to maximum active Astral Pulsars.
Extends Astral Pulsar lifetime when it attaches to an enemy.]]
PERK.Icon = "materials/perks/warlock/magnetar.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 0.5, percent = true},
    [3] = {value = 0.25, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNetherStarLaunch = function (ply, properties)
    if ply:Horde_GetPerk("warlock_magnetar") then
        properties.magnetar = true
    end
end
