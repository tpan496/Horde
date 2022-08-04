SUBCLASS.PrintName = "Gunslinger" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Ghost -- Required for any new classes
SUBCLASS.Icon = "subclasses/gunslinger.png" -- Required
SUBCLASS.Description = [[
Ghost subclass.
Specializes in pistols and marks.]] -- Required
SUBCLASS.BasePerk = "gunslinger_base"
SUBCLASS.Perks = {
    [1] = {title = "Precision", choices = {"gunslinger_deadeye", "gunslinger_bounty_hunter"}},
    [2] = {title = "Gunfight", choices = {"gunslinger_quickdraw", "gunslinger_puncture"}},
    [3] = {title = "Outlaw", choices = {"gunslinger_maverick", "gunslinger_poach"}},
    [4] = {title = "Ultimatum", choices = {"gunslinger_nine_lives", "gunslinger_bladerunner"}},
} -- Required