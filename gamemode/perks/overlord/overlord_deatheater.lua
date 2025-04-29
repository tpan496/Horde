PERK.PrintName = "Deatheater"
PERK.Description = [[Enemies in your presence are always at maximum Fear.]]
PERK.Icon = "materials/perks/overlord/deatheater.png"
PERK.Params = {
    [1] = { value = 0.5, percent = true },
}
PERK.Hooks = {}
--Effects are in sv_fear.lua
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_deatheater" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_deatheater" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end
