PERK.PrintName = "Tactical Spleen"
PERK.Description =
[[{1} increased maximum health.
Grants a spleen that negates all debuffs when buildup is full.
The spleen regenerates every {2} seconds.]]
PERK.Icon = "materials/perks/carcass/tactical_spleen.png"
PERK.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 5},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "carcass_tactical_spleen" then
        ply:Horde_SetTacticalSpleenEnabled(true)
        ply:Horde_AddTacticalSpleen()
    end
end
 
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "carcass_tactical_spleen" then
        ply:Horde_SetTacticalSpleenEnabled(nil)
        ply:Horde_RemoveTacticalSpleen()
        timer.Remove("Horde_RestockTacticalSpleen" .. ply:SteamID())
    end
end

PERK.Hooks.Horde_OnSetMaxHealth = function(ply, bonus)
    if SERVER and ply:Horde_GetPerk("carcass_tactical_spleen") then
        bonus.increase = bonus.increase + 0.2
    end
end