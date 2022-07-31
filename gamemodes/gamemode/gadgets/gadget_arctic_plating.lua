GADGET.PrintName = "Arctic Plating"
GADGET.Description = "20% increased Cold damage resistance."
GADGET.Icon = "items/gadgets/arctic_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
    [1] = {value = 0.20, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_arctic_plating"  then return end
    if HORDE:IsColdDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.20
    end
end