PERK.PrintName = "Ghost Veil"
PERK.Description = "100% increased Camoflague activation speed."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk, params)
    if perk == "ghost_ghost_veil" then
        ply:Horde_SetCamoflagueActivationTime(ply:Horde_GetCamoflagueActivationTime() / 2)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk, params)
    if perk == "ghost_ghost_veil" then
        ply:Horde_SetCamoflagueActivationTime(ply:Horde_GetCamoflagueActivationTime() * 2)
    end
end