SUBCLASS.PrintName = "Samurai" -- Required
SUBCLASS.UnlockCost = 100
SUBCLASS.ParentClass = HORDE.Class_Berserker -- Required for any new classes
SUBCLASS.Icon = "subclasses/samurai.png" -- Required
SUBCLASS.Description = [[
Defensive oriented melee weapon class.
Utilizes a dodge mechanic to evade attacks and 
focuses on applying bleeds to multiple enemies.]] -- Required
SUBCLASS.BasePerk = "samurai_base"
SUBCLASS.Perks = {
    [1] = {title = "Technique", choices = {"samurai_focus_slash", "samurai_flesh_bloom"}},
    [2] = {title = "Overwhelm", choices = {"samurai_demon_stomp", "samurai_exsanguinate"}},
    [3] = {title = "Mind", choices = {"samurai_foresight", "samurai_resolution"}},
    [4] = {title = "Art of War", choices = {"samurai_blade_dance", "samurai_demon_strike"}},
} -- Required