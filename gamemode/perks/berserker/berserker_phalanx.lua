PERK.PrintName = "Phalanx"
PERK.Description = [[
Gain {1} Phalanx stack when you hit an enemy, up to {2} stacks.
Each stack increases global damage resistance by {3}.
Each stack lasts {4} seconds and falls off consecutively.]]

PERK.Icon = "materials/perks/phalanx.png"
PERK.Params = {
    [1] = {value = 1},
    [2] = {value = 5},
    [3] = {value = 0.06, percent = true},
    [4] = {value = 5},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "berserker_phalanx" then
        ply:Horde_SetPhalanxEnabled(true)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "berserker_phalanx" then
        ply:Horde_SetPhalanxEnabled(nil)
    end
end