PERK.PrintName = "Void Field"
PERK.Description =
[[Void Spear applies extra Frostbite buildup.
Increases Void Spear damage by its travelling distance.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
    [1] = {value = 0.20, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply, properties)
    if ply:Horde_GetPerk("necromancer_void_field") then
        properties.field = true
    end
end