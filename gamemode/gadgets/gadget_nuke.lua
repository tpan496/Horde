GADGET.PrintName = "Nuke"
GADGET.Description =
[[Drops a nuke at the target location after a 5 second delay.
Deals extremely high Blast damage in a large area.
However, also leaves behind toxic waste for the remainder of the wave.]]
GADGET.Icon = "items/gadgets/nuke.png"
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