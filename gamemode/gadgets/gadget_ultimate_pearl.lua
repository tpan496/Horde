GADGET.PrintName = "Elixir"
GADGET.Description = [[Recovers 100% of your health.
Removes all status effects.]]
GADGET.Icon = "items/gadgets/elixir.png"
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