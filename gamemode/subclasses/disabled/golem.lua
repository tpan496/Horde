SUBCLASS.PrintName = "Golem" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Heavy -- Required for any new classes
SUBCLASS.Icon = "subclasses/golem.png" -- Required
SUBCLASS.Ignore = true
SUBCLASS.Description = [[
Heavy subclass.
A fucking meatball that punches people.]] -- Required
SUBCLASS.BasePerk = "golem_base"
SUBCLASS.Perks = {
    [1] = {title = "Synthesis", choices = {"golem_biojet", "golem_photosynthesis"}},
    [2] = {title = "Mesocycle", choices = {"golem_biofusion", "golem_amalgam"}},
    [3] = {title = "Proliferation", choices = {"golem_meatshield", "golem_cell_graft"}},
    [4] = {title = "Multiply", choices = {"golem_bioimmortality", "golem_trauma_loop"}},
} -- Required