PERK.PrintName = "Golem Base"
PERK.Description = [[
{1} increased maximum health. ({2} per level, up to {3}).

Gain Hypertrophy when you kill an enemy.
Hypertrophy reduces Physical damage taken by {4}.
Hypertrophy provdes 1 health regen per second.

Equipped with Fists.

LMB: Punch (0/10 Energy)
Hold for a charged punch.

RMB: Force Shield (1 Energy per tick)
Hold to activate a force shield that negates damage taken.
Damage taken is depleted as energy instead.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
    [1] = {percent = true, base = 0, level = 0.01, max = 0.25, classname = HORDE.Class_Heavy},
    [2] = {value = 0.01, percent = true},
    [3] = {value = 0.25, percent = true},
    [4] = {value = 0.04, percent = true},
}
PERK.Hooks = {}


PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "golem_base" then
    end
end
 
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "golem_base" then
    end
end