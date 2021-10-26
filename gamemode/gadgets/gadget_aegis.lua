GADGET.PrintName = "Aegis"
GADGET.Description =
[[Aegis Modular Immunization System.
Use the active ability to switch between modes.
Your healing grants additional effects based on Aegis modes.
Biological Aegis provides Poison damage immunity.]]
GADGET.Icon = "items/gadgets/aerial_guard.png"
GADGET.Duration = 0
GADGET.Cooldown = 2
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.5},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_aerial_guard"  then return end
    if not ply:IsOnGround() and (dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_BUCKSHOT or dmginfo:GetDamageType() == DMG_SLASH or dmginfo:GetDamageType() == DMG_CLUB or dmginfo:GetDamageType() == DMG_SNIPER or dmginfo:GetDamageType() == DMG_CRUSH or dmginfo:GetDamageType() == DMG_GENERIC) then
        bonus.less = bonus.less * 0.35
        ply:EmitSound("horde/gadgets/guard" .. tostring(math.random(1,2)) ..".ogg", 125, 100, 1, CHAN_AUTO)
    end
end