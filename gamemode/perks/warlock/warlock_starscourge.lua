PERK.PrintName = "Starscourge"
PERK.Description =
[[+{1} to maximum active Astral Pulsars.
Causes your first Astral Pulsar to have infinite duration.
{2} more Astral Pulsar damage while attached to elite enemies.]]
PERK.Icon = "materials/perks/warlock/starscourge.png"
PERK.Params = {
    [1] = {value = 2},
    [2] = {value = 25},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNetherStarLaunch = function (ply, properties)
    if ply:Horde_GetPerk("warlock_starscourge") then
        properties.starscourge = true
    end
end
