GADGET.PrintName = "Sunder"
GADGET.Description =
[[Charges yourself with tremendous energy.
On your next Melee hit:
- Deals 50% increased damage on the target.
- Deals weapon base damage to all other enemies along the path.]]
GADGET.Icon = "items/gadgets/sunder.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_sunder" then return end
end