GADGET.PrintName = "Aerial Guard"
GADGET.Description =
[[While in air, take 60% less Physical damage.]]
GADGET.Icon = "items/gadgets/aerial_guard.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.60},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_aerial_guard" then return end
    ply:Horde_SetAerialGuardEnabled(1)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_aerial_guard" then return end
    ply:Horde_SetAerialGuardEnabled(0)
end