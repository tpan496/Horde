GADGET.PrintName = "Defibrillator"
GADGET.Description =
[[Revives the last teammate that died at 50% health.]]
GADGET.Icon = "items/gadgets/defibrillator.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Once = true
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_nuke" then return end
end