SUBCLASS.PrintName = "Necromancer" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Engineer -- Required for any new classes
SUBCLASS.Icon = "subclasses/necromancer.png" -- Required
SUBCLASS.Description = [[
Engineer subclass.
Specializes in cold damage and spectre minions.]] -- Required
SUBCLASS.BasePerk = "necromancer_base"
SUBCLASS.Perks = {
    [1] = {title = "Initialization", choices = {"necromancer_void_sphere", "necromancer_hollow_essence"}},
    [2] = {title = "Recovery", choices = {"necromancer_void_siphon", "necromancer_superfluidity"}},
    [3] = {title = "Annihilation", choices = {"necromancer_void_field", "necromancer_abyssal_might"}},
    [4] = {title = "Mastery", choices = {"necromancer_beacon_of_void", "necromancer_necromastery"}},
} -- Required