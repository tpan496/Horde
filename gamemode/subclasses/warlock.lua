SUBCLASS.PrintName = "Warlock" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Demolition -- Required for any new classes
SUBCLASS.Icon = "subclasses/warlock.png" -- Required
SUBCLASS.Description = [[
Demolition subclass.
A slow caster that uses destructive spells.]] -- Required
SUBCLASS.BasePerk = "warlock_base"
SUBCLASS.Perks = {
    [1] = {title = "Transfigure", choices = {"warlock_meditate", "warlock_quickcast"}},
    [2] = {title = "Channelling", choices = {"warlock_sigil_of_courage", "warlock_sigil_of_malediction"}},
    [3] = {title = "Vectorize", choices = {"warlock_arcane_supremacy", "warlock_negative_burst"}},
    [4] = {title = "Annihilation", choices = {"warlock_shaper_of_destruction", "warlock_sigil_mastery"}},
} -- Required