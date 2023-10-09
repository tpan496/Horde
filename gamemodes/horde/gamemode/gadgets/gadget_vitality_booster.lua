GADGET.PrintName = "Vitality Booster"
GADGET.Description = "+25 to maximum health."
GADGET.Icon = "items/gadgets/vitality_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 25},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetMaxHealth = function (ply, bonus)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_vitality_booster" then return end
    bonus.add = bonus.add + 25
end