PERK.PrintName = "Dispersion"
PERK.Description = [[+1 Fear stack.
Applying Fear reduces your debuff buildup.]]
PERK.Icon = "materials/perks/overlord/dispersion.png"
PERK.Params = {
    [1] = { value = 0.05, percent = true },
    [2] = { value = 3 },
}
PERK.Hooks = {}
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
