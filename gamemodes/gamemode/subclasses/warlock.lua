SUBCLASS.PrintName = "Warlock" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Demolition -- Required for any new classes
SUBCLASS.Icon = "subclasses/warlock.png" -- Required
SUBCLASS.Description = [[
Demolition subclass.
Physical damage caster that focuses on area control.]] -- Required
SUBCLASS.BasePerk = "warlock_base"
SUBCLASS.Perks = {
    [1] = {title = "Transfigure", choices = {"warlock_celestial_bond", "warlock_coalesce"}},
    [2] = {title = "Channelling", choices = {"warlock_magnetar", "warlock_nucleosynthesis"}},
    [3] = {title = "Vectorize", choices = {"warlock_gravity_vacuum", "warlock_negative_burst"}},
    [4] = {title = "Annihilation", choices = {"warlock_starscourge", "warlock_dirac_sea"}},
} -- Required