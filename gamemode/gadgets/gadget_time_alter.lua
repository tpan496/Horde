GADGET.PrintName = "Time Alter"
GADGET.Description = "Doubles your movespeed."
GADGET.Icon = "items/gadgets/timer_alter.png"
GADGET.Duration = 3
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_iv_injection" then return end
    sound.Play("horde/gadgets/injection.ogg", ply:GetPos())
    sound.Play("items/medshot4.wav", ply:GetPos())
    local healinfo = HealInfo:New({amount=25, healer=ply})
    HORDE:OnPlayerHeal(ply, healinfo)
end

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" or not ply.Horde_HasGuts then return end
    bonus_walk.more = bonus_walk.more * 2
    bonus_run.more = bonus_run.more * 2
end