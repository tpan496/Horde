GADGET.PrintName = "Hyperdrive"
GADGET.Description = [[{1} increased movement speed and grants 1 Adrenaline stack.
Lasts for {2} seconds.]]
GADGET.Icon = "items/gadgets/hyperdrive.png"
GADGET.Duration = 3
GADGET.Cooldown = 12
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 3}
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hyperdrive" then return end
    ply.Horde_Has_Hyperdive = true
    ply:Horde_AddAdrenalineStack()
    timer.Simple(3, function ()
        if IsValid(ply) then
            ply.Horde_Has_Hyperdive = nil
        end
    end)
end


GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply.Horde_Has_Hyperdive then
        bonus_walk.more = bonus_walk.more * 2
        bonus_run.more = bonus_run.more * 2
    end
end
