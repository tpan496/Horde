GADGET.PrintName = "Resistance Booster"
GADGET.Description = "25% increased Global damage resistance. \n50% less debuff buildup."
GADGET.Icon = "items/gadgets/resistance_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_resistance_booster" then return end
    bonus.resistance = bonus.resistance + 0.25
end

GADGET.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
if ply:Horde_GetGadget() ~= "gadget_resistance_booster" then return end
    bonus.less = bonus.less * 0.5
end