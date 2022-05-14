SUBCLASS.PrintName = "Artificer" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Cremator -- Required for any new classes
SUBCLASS.Icon = "subclasses/artificer.png" -- Required
SUBCLASS.Description = [[
Cremator subclass.
Fire/lightning damage caster.]] -- Required
SUBCLASS.BasePerk = "necromancer_base"
SUBCLASS.Perks = {
    [1] = {title = "Initialization", choices = {"artificer_", "artificer_"}},
    [2] = {title = "Recovery", choices = {"artificer_", "artificer_"}},
    [3] = {title = "Annihilation", choices = {"artificer_", "artificer_"}},
    [4] = {title = "Mastery", choices = {"artificer_beacon_of_immolation", "artificer_beacon_of_reckoning"}},
} -- Required