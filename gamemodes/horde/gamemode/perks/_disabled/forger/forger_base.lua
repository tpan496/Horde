PERK.PrintName = "Striker Base"
PERK.Description = [[
The Striker class relies on Barrier and manipulates space to its advantage.
Complexity: HIGH

{1} increased maximum Barrier.
{2} increased Barrier regeneration near Monoliths.

You only have 1 health.
Your Watchtowers are converted to Monoliths.
You spawn with Monolith MKI.
You regenerate 5 Barrier per second near Monoliths.

SHIFT+E to activate Blink.
Teleports to the target Monolith.
Blink has a cooldown of 5 seconds.]]
PERK.Params = {
    [1] = {percent = true, level = 0.08, max = 2, classname = HORDE.Class_Warden},
    [2] = {value = 0.08, percent = true},
    [3] = {value = 2, percent = true},
    [4] = {value = 2}
}

PERK.Hooks = {}