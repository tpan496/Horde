GADGET.PrintName = "Vitality Booster"
GADGET.Description = "+25 to maximum health."
GADGET.Icon = "items/gadgets/vitality_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 25},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_vitality_booster" then return end
    ply:SetMaxHealth(ply:GetMaxHealth() + 25)
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_vitality_booster" then return end
    ply:SetMaxHealth(ply:GetMaxHealth() - 25)
end