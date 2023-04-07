GADGET.PrintName = "Iridescent Pearl"
GADGET.Description = [[Permantly increases your movement speed by 10%.]]
GADGET.Icon = "items/gadgets/life_diffuser.png"
GADGET.Droppable = true
GADGET.Active = true
GADGET.Once = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_iridescent_pearl" then return end
end