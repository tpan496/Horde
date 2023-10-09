PERK.PrintName = "Grappendix"
PERK.Description =
[[{1} increased maximum health.
Press RMB to use your appendix as a grapple hook.
Drains your health when in use.]]
PERK.Icon = "materials/perks/carcass/grappendix.png"
PERK.Params = {
    [1] = {value = 0.15, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("carcass_grappendix") then
        bonus.increase = bonus.increase + 0.15
    end
end