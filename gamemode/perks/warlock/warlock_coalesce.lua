PERK.PrintName = "Coalesce"
PERK.Description =
[[+{1} to maximum active Astral Remnants.
Allows you to target Astral Pulsar on Astral Remnants.
Targeted Astral Remnant attaches to Astral Pulsar on contact.]]
PERK.Icon = "materials/perks/warlock/coalesce.png"
PERK.Params = {
    [1] = {value = 5},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnNetherStarLaunch = function (ply, properties)
    if ply:Horde_GetPerk("warlock_coalesce") then
        properties.coalesce = true
    end
end
