PERK.PrintName = "Oppressor"
PERK.Description = [[+2 Fear stack.]]
PERK.Icon = "materials/perks/overlord/oppressor.png"
PERK.Params = {
    [1] = { value = 0.05, percent = true },
    [2] = { value = 3 },
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_oppressor" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_oppressor" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 2)
    end
end
