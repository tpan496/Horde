GADGET.PrintName = "Shock Plating"
GADGET.Description = "20% increased Shock damage resistance."
GADGET.Icon = "items/gadgets/shock_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetGadget() ~= "gadget_shock_plating"  then return end
    if dmginfo:GetDamageType() == DMG_SHOCK then
        bonus.resistance = bonus.resistance + 0.20
    end
end