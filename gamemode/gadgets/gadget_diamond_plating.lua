GADGET.PrintName = "Diamond Plating"
GADGET.Description = "10% increased Physical damage resistance."
GADGET.Icon = "items/gadgets/diamond_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.10, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetGadget("gadget_diamond_plating")  then return end
    if dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_BUCKSHOT or dmginfo:GetDamageType() == DMG_SLASH or dmginfo:GetDamageType() == DMG_CLUB or dmginfo:GetDamageType() == DMG_SNIPER or dmginfo:GetDamageType() == DMG_CRUSH or dmginfo:GetDamageType() == DMG_GENERIC then
        bonus.resistance = bonus.resistance + 0.10
    end
end