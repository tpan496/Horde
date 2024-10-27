SUBCLASS.PrintName = "Necromancer" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Engineer -- Required for any new classes
SUBCLASS.Icon = "subclasses/necromancer.png" -- Required
SUBCLASS.Description = translate.Get("info_Necromancer_extra_desc") -- Required
SUBCLASS.BasePerk = "necromancer_base"
SUBCLASS.Perks = {
    [1] = {title = "Domination", choices = {"necromancer_withering_prescence", "necromancer_hollow_essence"}},
    [2] = {title = "Recovery", choices = {"necromancer_energy_siphon", "necromancer_eldritch_protection"}},
    [3] = {title = "Occultism", choices = {"necromancer_occult_armor", "necromancer_abyssal_might"}},
    [4] = {title = "Apex", choices = {"necromancer_beacon_of_void", "necromancer_necromastery"}},
} -- Required