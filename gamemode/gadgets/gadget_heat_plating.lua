GADGET.PrintName = "Heat Plating"
GADGET.Description = "20% increased Fire and Plasma damage resistance."
GADGET.Icon = "items/gadgets/heat_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetGadget() ~= "gadget_heat_plating"  then return end
    if dmginfo:GetDamageType() == DMG_BURN or dmginfo:GetDamageType() == DMG_SLOWBURN then
        bonus.resistance = bonus.resistance + 0.20
    end
end