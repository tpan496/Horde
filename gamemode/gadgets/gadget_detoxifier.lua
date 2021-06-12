GADGET.PrintName = "Detoxifier"
GADGET.Description = "20% increased Poison damage resistance."
GADGET.Icon = "items/gadgets/detoxifier.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetGadget() ~= "gadget_detoxifier"  then return end
    if dmginfo:GetDamageType() == DMG_POISON or dmginfo:GetDamageType() == DMG_ACID or dmginfo:GetDamageType() == DMG_NERVEGAS then
        bonus.resistance = bonus.resistance + 0.20
    end
end