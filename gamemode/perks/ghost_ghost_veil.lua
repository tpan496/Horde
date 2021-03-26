PERK.PrintName = "Ghost Veil"
PERK.Description = "100% increased Camoflague activation speed."
PERK.Icon = "materials/perks/ghost_veil.png"

 = {}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "ghost_ghost_veil" then
        ply:Horde_SetCamoflagueActivationTime(0.25)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "ghost_ghost_veil" then
        ply:Horde_SetCamoflagueActivationTime(0.5)
    end
end