PERK.PrintName = "Striker Base"
PERK.Description = [[
The Striker class manipulates space to its advantage.
Complexity: HIGH

{1} increased Blink distance.

SHIFT+E to activate Blink.
Teleports to the target location.
The blink range extends greatly if the target is a Watchtower.]]
PERK.Params = {
    [1] = {percent = true, level = 0.01, max = 0.25, classname = HORDE.Class_Warden},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
    [4] = {value = 2}
}

PERK.Hooks = {}