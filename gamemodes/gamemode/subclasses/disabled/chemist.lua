SUBCLASS.PrintName = "Chemist" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Medic -- Required for any new classes
SUBCLASS.Icon = "subclasses/chemist.png" -- Required
SUBCLASS.Description = [[
Medic subclass.
Focuses on dealing Poison damage.]] -- Required
SUBCLASS.BasePerk = "chemist_base"
SUBCLASS.Perks = {
    [1] = {title = "Inner Strength", choices = {"chemist_erosion", "chemist_contagion"}},
    [2] = {title = "Recuperate", choices = {"chemist_cleansing", "chemist_poison_weapon"}},
    [3] = {title = "Power", choices = {"chemist_mustard_gas", "chemist_sarin_mist"}},
    [4] = {title = "Ascension", choices = {"chemist_beacon_of_agony", "chemist_disintegrate"}},
} -- Required