GADGET.PrintName = "Irradiant Pearl"
GADGET.Description = [[Permantly increases your maximum damage by 10%.]]
GADGET.Icon = "items/gadgets/life_diffuser.png"
GADGET.Droppable = true
GADGET.Active = true
GADGET.Once = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_life_diffuser" then return end
end