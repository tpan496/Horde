GADGET.PrintName = "Hyperdrive"
GADGET.Description = [[{1} increased effect of Arenaline.
Lasts for {2} seconds.]]
GADGET.Icon = "items/gadgets/nanosuit.png"
GADGET.Duration = 3
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 1, percent = true},
    [2] = {value = 3}
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_hyperdrive" then return end
end