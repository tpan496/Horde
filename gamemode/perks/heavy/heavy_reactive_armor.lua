PERK.PrintName = "Reactive Armor"
PERK.Description = [[Gain a reactive armor that negates critical damage taken.
Activates on taking more than {1} damage and recharges after {2} seconds.
Uses {3} of your armor when triggered.]]
PERK.Icon = "materials/perks/reactive_armor.png"
PERK.Params = {
    [1] = {value = 25},
    [2] = {value = 6},
    [3] = {value = 0.25, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "heavy_reactive_armor" then
        ply:Horde_SetReactiveArmorEnabled(true)
        ply:Horde_AddReactiveArmor()
    end
end
 
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "heavy_reactive_armor" then
        ply:Horde_SetReactiveArmorEnabled(nil)
        ply:Horde_RemoveReactiveArmor()
        timer.Remove("Horde_RestockReactiveArmor" .. ply:SteamID())
    end
end