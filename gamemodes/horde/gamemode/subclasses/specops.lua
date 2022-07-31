SUBCLASS.PrintName = "SpecOps" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Assault -- Required for any new classes
SUBCLASS.Icon = "subclasses/specops.png" -- Required
SUBCLASS.Description = [[
Assault subclass.
Plays around a unique mode switch mechanic.]] -- Required
SUBCLASS.BasePerk = "specops_base"
SUBCLASS.Perks = {
    [1] = {title = "Utility", choices = {"specops_smokescreen", "specops_flare"}},
    [2] = {title = "Engage", choices = {"specops_tactical_visor", "specops_neuron_stabilizer"}},
    [3] = {title = "Protection", choices = {"specops_biotic_mask", "specops_adaptive_coating"}},
    [4] = {title = "Sunset", choices = {"specops_night_stalker", "specops_peace_walker"}},
} -- Required