SUBCLASS.PrintName = "Psycho" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Survivor -- Required for any new classes
SUBCLASS.Icon = "subclasses/psycho.png" -- Required
SUBCLASS.Description = [[
Survivor subclass.
Hybrid fighter focused on critical hits.]] -- Required
SUBCLASS.BasePerk = "psycho_base"
SUBCLASS.Perks = {
    [1] = {title = "Violence", choices = {"psycho_ferocity", "psycho_savor"}},
    [2] = {title = "Sadism", choices = {"psycho_bloodbath", "psycho_disembowel"}},
    [3] = {title = "Fatality", choices = {"psycho_skewering", "psycho_brutality"}},
    [4] = {title = "Psychosis", choices = {"psycho_grudge", "psycho_bestial_wrath"}},
} -- Required 