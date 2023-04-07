GADGET.PrintName = "Immaculate Pearl"
GADGET.Description = [[Permantly increases your maximum health by 10%.]]
GADGET.Icon = "items/gadgets/life_diffuser.png"
GADGET.Droppable = true
GADGET.Active = true
GADGET.Once = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_immaculate_pearl" then return end
end