PERK.PrintName = "Ghost Veil"
PERK.Description = "Attacking does not cancel Camoflague.\n{1} increased Camoflague activation speed."
PERK.Icon = "materials/perks/ghost_veil.png"
PERK.Params = {
    [1] = {value = 1, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "ghost_ghost_veil" then
        ply:Horde_SetCamoflagueActivationTime(0.25)
        ply:Horde_SetRemoveCamoflagueOnAttack(0)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "ghost_ghost_veil" then
        ply:Horde_SetCamoflagueActivationTime(0.5)
        ply:Horde_SetRemoveCamoflagueOnAttack(1)
    end
end