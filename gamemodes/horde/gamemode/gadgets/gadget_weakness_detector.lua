GADGET.PrintName = "Weakness Detector"
GADGET.Description =
[[Prints out the weakness of the enemies, if available.]]
GADGET.Icon = "items/gadgets/weakness_detector.png"
GADGET.Duration = 0
GADGET.Cooldown = 1
GADGET.Active = true
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_weakness_detector" then return end
end