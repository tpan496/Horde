PERK.PrintName = "Phalanx"
PERK.Description = "Gain 1 Phalanx stack every 2 seconds, up to {1}.\nEach stack increases {2} physical damage resistance and {3} melee damage.\nLose stacks when you attack."
PERK.Icon = "materials/perks/phalanx.png"
PERK.Params = {
    [1] = {value = 5},
    [2] = {value = 0.06, percent = true},
    [3] = {value = 0.06, percent = true},
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