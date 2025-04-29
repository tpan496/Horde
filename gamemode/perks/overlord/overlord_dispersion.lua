PERK.PrintName = "Dispersion"
PERK.Description = [[Applying Fear reduces your debuff buildup by {1}.]]
PERK.Icon = "materials/perks/overlord/dispersion.png"
PERK.Params = {
    [1] = { value = 0.10, percent = true },
    [2] = { value = 0.01, percent = true },
}
PERK.Hooks = {}
--Effects are in sv_fear.lua
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_dispersion" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_dispersion" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
    end
end
