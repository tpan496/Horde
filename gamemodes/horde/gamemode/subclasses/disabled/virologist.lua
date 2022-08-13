SUBCLASS.PrintName = "Virologist" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Medic -- Required for any new classes
SUBCLASS.Icon = "subclasses/virologist.png" -- Required
SUBCLASS.Description = [[
Medic subclass.
Support class that focuses on weakening enemies.]] -- Required
SUBCLASS.BasePerk = "virologist_base"
SUBCLASS.Perks = {
    [1] = {title = "Stage I", choices = {"virologist_assembly", "virologist_outburst"}},
    [2] = {title = "Stage II", choices = {"virologist_corrosion", "virologist_ingrain"}},
    [3] = {title = "Stage III", choices = {"virologist_type_delta", "virologist_type_omega"}},
    [4] = {title = "Stage IV", choices = {"virologist_metamorphosis", "virologist_disintegrate"}},
} -- Required