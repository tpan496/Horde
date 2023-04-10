PERK.PrintName = "Intensity"
PERK.Description =
[[Gain Intensity for each enemy you kill, up to {1} stacks.
Each stack increases mind regeneration by {2}
Each stack reduces spell cooldown by {3}.]]
PERK.Icon = "materials/perks/artificer/intensity.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.08, percent = true},
    [3] = {value = 0.08, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "artificer_intensity" then
        ply:Horde_SetMaxIntensityStack(ply:Horde_GetMaxIntensityStack() + 5)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "artificer_intensity" then
        ply:Horde_SetMaxIntensityStack(ply:Horde_GetMaxIntensityStack() - 5)
    end
end