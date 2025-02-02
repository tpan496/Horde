GADGET.PrintName = "Diamond Plating"
GADGET.Description = "15% increased Physical damage resistance."
GADGET.Icon = "items/gadgets/diamond_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_diamond_plating"  then return end
    if HORDE:IsPhysicalDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.15
    end
end