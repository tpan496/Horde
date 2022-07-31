PERK.PrintName = "Foresight"
PERK.Description =
[[Adds {1} charge to Quickstep.
Gain Foresight, negating Physical damage taken on hit.
Foresight expires on hit and reflects damage taken.]]
PERK.Icon = "materials/perks/samurai/foresight.png"
PERK.Params = {
    [1] = {value = 1},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "samurai_foresight" then
        ply:Horde_SetForesightEnabled(true)
        ply:Horde_AddForesight()
    end
end
 
PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "samurai_foresight" then
        ply:Horde_SetForesightEnabled(nil)
        ply:Horde_RemoveForesight()
        timer.Remove("Horde_RestockForesight" .. ply:SteamID())
    end
end