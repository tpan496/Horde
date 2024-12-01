SUBCLASS.PrintName = "Gunslinger" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Ghost -- Required for any new classes
SUBCLASS.Icon = "subclasses/gunslinger.png" -- Required
SUBCLASS.Description = translate.Get("info_Gunslinger_extra_desc") -- Required
SUBCLASS.BasePerk = "gunslinger_base"
SUBCLASS.Perks = {
    [1] = {title = "Precision", choices = {"gunslinger_deadeye", "gunslinger_puncture"}},
    [2] = {title = "Gunfight", choices = {"gunslinger_elusive", "gunslinger_poach"}},
    [3] = {title = "Tricks", choices = {"gunslinger_quickdraw", "gunslinger_smuggle"}},
    [4] = {title = "Ultimatum", choices = {"gunslinger_phantom_reload", "gunslinger_exorcism"}},
} -- Required