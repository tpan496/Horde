SUBCLASS.PrintName = "Carcass" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Heavy -- Required for any new classes
SUBCLASS.Icon = "subclasses/carcass.png" -- Required
SUBCLASS.Description = [[
Heavy subclass.
An abomination with high health and mobility.]] -- Required
SUBCLASS.BasePerk = "carcass_base"
SUBCLASS.Perks = {
    [1] = {title = "Bowel", choices = {"carcass_grappendix", "carcass_bio_thruster"}},
    [2] = {title = "Secretion", choices = {"carcass_tactical_spleen", "carcass_anabolic_gland"}},
    [3] = {title = "Limbs", choices = {"carcass_reinforced_arms", "carcass_pneumatic_legs"}},
    [4] = {title = "Core", choices = {"carcass_twin_heart", "carcass_aas_perfume"}},
} -- Required