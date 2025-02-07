GADGET.PrintName = "Energy Shield"
GADGET.Description = "Gain {1} barrier on use."
GADGET.Icon = "items/gadgets/energy_shield.png"
GADGET.Cooldown = 5
GADGET.Active = true
GADGET.Params = {
    [1] = { value = 75 },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_energy_shield" then return end
    ply:EmitSound("horde/gadgets/energy_shield_on.ogg")
    ply:Horde_AddBarrierStack(75)
end