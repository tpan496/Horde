GADGET.PrintName = "Detoxifier"
GADGET.Description = "40% increased Poison damage resistance."
GADGET.Icon = "items/gadgets/detoxifier.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
    [1] = {value = 0.40, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_detoxifier"  then return end
    if HORDE:IsPoisonDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.40
    end
end