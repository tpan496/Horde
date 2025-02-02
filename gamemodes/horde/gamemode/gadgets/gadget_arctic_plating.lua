GADGET.PrintName = "Arctic Plating"
GADGET.Description = "40% increased Cold damage resistance."
GADGET.Icon = "items/gadgets/arctic_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_arctic_plating"  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.4
    end
end