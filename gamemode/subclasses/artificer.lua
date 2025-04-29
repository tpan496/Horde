SUBCLASS.PrintName = "Artificer" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Cremator -- Required for any new classes
SUBCLASS.Icon = "subclasses/artificer.png" -- Required
SUBCLASS.Description = [[
Offensive AoE and single target spell caster.
Weaves fire and lightning spells to shock 
and ignite enemies to maximize damage.]] -- Required
SUBCLASS.BasePerk = "artificer_base"
SUBCLASS.Perks = {
    [1] = {title = "Inner Strength", choices = {"artificer_solar_flux", "artificer_purge"}},
    [2] = {title = "Recuperate", choices = {"artificer_devotion", "artificer_intensity"}},
    [3] = {title = "Codex", choices = {"artificer_spell_echo", "artificer_multicast"}},
    [4] = {title = "Ascension", choices = {"artificer_godslayer", "artificer_draconic_reckoning"}},
} -- Required