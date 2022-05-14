PERK.PrintName = "Void Sphere"
PERK.Description =
[[Void Spear always deal splashing damage.
Increases Void Spear splash damage.]]
PERK.Icon = "materials/subclasses/necromancer.png"
PERK.Params = {
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnVoidProjectorLaunch = function (ply, properties)
    if ply:Horde_GetPerk("necromancer_void_sphere") then
        properties.sphere = true
    end
end