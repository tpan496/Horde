PERK.PrintName = "Neuron Stabilizer"
PERK.Description = [[
Provides bonus based how long you stay in Tactical Mode.
{1} increased Ballistic damage per second, up to {2}
+{3} damage block per second, up to {4}]]
PERK.Icon = "materials/perks/specops/neuron_stabilizer.png"
PERK.Params = {
    [1] = {value = 0.06, percent = true},
    [2] = {value = 0.30, percent = true},
    [3] = {value = 2},
    [4] = {value = 10},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "specops_neuron_stabilizer" then
        ply:Horde_SetNeuronStabilizerEnabled(nil)
    end
end
