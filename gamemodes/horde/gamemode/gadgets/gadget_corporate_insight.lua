GADGET.PrintName = "Corporate Insight"
GADGET.Description = "Allows you to access the stock market."
GADGET.Icon = "items/gadgets/corporate_insight.png"
GADGET.Duration = 0
GADGET.Cooldown = 1
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 10},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_corporate_insight" then return end
end