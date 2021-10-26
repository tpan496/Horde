GADGET.PrintName = "Aerial Guard"
GADGET.Description =
[[While in air, take 65% less Physical damage.]]
GADGET.Icon = "items/gadgets/aerial_guard.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
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