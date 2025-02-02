GADGET.PrintName = "Shock Plating"
GADGET.Description = "40% increased Lightning damage resistance."
GADGET.Icon = "items/gadgets/shock_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_shock_plating"  then return end
    if HORDE:IsLightningDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.4
    end
end