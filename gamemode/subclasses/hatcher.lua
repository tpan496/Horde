SUBCLASS.PrintName = "Hatcher" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Medic -- Required for any new classes
SUBCLASS.Icon = "subclasses/hatcher.png" -- Required
SUBCLASS.Description = [[
Minion based support class that uses Antlions.
Antlions heals and buffs allies while attacking
enemies as you fire down range with your gun.]] -- Required
SUBCLASS.BasePerk = "hatcher_base"
SUBCLASS.Perks = {
    [1] = {title = "Stage I", choices = {"hatcher_natural_selection", "hatcher_growth_hormone"}},
    [2] = {title = "Stage II", choices = {"hatcher_sand_cloak", "hatcher_bio_barrier"}},
    [3] = {title = "Stage III", choices = {"hatcher_vile_blood", "hatcher_flesh_eater"}},
    [4] = {title = "Natural Selection", choices = {"hatcher_swarm", "hatcher_metamorphosis"}},
} -- Required