PERK.PrintName = "Oppressor"
PERK.Description = [[{1} increased effectiveness of Suffering.]]
PERK.Icon = "materials/perks/overlord/oppressor.png"
PERK.Params = {
    [1] = { value = 0.5, percent = true },
}
PERK.Hooks = {}
--Effects are in sv_fear.lua
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "overlord_oppressor" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() + 1)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "overlord_oppressor" then
        ply:Horde_SetMaxFearStack(ply:Horde_GetMaxFearStack() - 1)
        if ply:Horde_GetPerk("overlord_base") then
            ply:Horde_AddOverlordPresence()
        else
            ply:Horde_RemoveOverlordPresence()
        end
    end
end
