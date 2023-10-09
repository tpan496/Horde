GADGET.PrintName = "Resistance Booster"
GADGET.Description = "20% increased Global damage resistance."
GADGET.Icon = "items/gadgets/resistance_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.2, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_resistance_booster" then return end
    bonus.resistance = bonus.resistance + 0.2
end