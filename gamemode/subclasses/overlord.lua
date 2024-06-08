SUBCLASS.PrintName = "Overlord"           -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Warden -- Required for any new classes
SUBCLASS.Icon = "subclasses/overlord.png" -- Required
SUBCLASS.Description = [[
Warden subclass.
Focus on oppression and special defense.]] -- Required
SUBCLASS.BasePerk = "overlord_base"
SUBCLASS.Perks = {
    [1] = { title = "Defense", choices = { "overlord_inverse_filter", "overlord_dispersion" } },
    [2] = { title = "Offense", choices = { "overlord_militant", "overlord_oppressor" } },
    [3] = { title = "Spatial Manipulation", choices = { "overlord_dark_energy_blast", "overlord_juxtapose" } },
    [4] = { title = "Requiem", choices = { "overlord_doomed_presence", "overlord_deatheater" } },
} -- Required
