PERK.PrintName = "Celestial Bond"
PERK.Description =
[[+{1} to maximum active Astral Pulsars.
Allows you to attach Astral Pulsar on targeted players.
Astral Pulsar deals area of effect damage while attached to a player.]]
PERK.Icon = "materials/perks/warlock/celestial_bond.png"
PERK.Params = {
    [1] = {value = 1},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNetherStarLaunch = function (ply, properties)
    if ply:Horde_GetPerk("warlock_celestial_bond") then
        properties.celestial_bond = true
    end
end
