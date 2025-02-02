GADGET.PrintName = "Vitality Booster"
GADGET.Description = "Adds 50 to maximum health."
GADGET.Icon = "items/gadgets/vitality_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetMaxHealth = function (ply, bonus)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_vitality_booster" then return end
    bonus.add = bonus.add + 50
end