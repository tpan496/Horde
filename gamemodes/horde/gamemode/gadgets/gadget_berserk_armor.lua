GADGET.PrintName = "Berserker Armor"
GADGET.Description = "25% increased damage.\n25% increased Global damage resistance.\n25% increased movespeed."
GADGET.Icon = "items/gadgets/berserk_armor.png"
GADGET.Duration = 8
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.25, percent = true},
    [3] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" then return end
    sound.Play("horde/gadgets/berserk_on.ogg", ply:GetPos())
    sound.Play("horde/gadgets/berserk_in.ogg", ply:GetPos())
    ply.Horde_HasGuts = true
    ply:ScreenFade(SCREENFADE.IN, Color(200, 50, 50, 50), 0.1, 8)
    timer.Simple(8, function()
        if ply:IsValid() then ply.Horde_HasGuts = nil end
    end)
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" or not ply.Horde_HasGuts then return end
    bonus.resistance = bonus.resistance + 0.25
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" or not ply.Horde_HasGuts then return end
    bonus.increase = bonus.increase + 0.25
end

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" or not ply.Horde_HasGuts then return end
    bonus_walk.increase = bonus_walk.increase + 0.25
    bonus_run.increase = bonus_run.increase + 0.25
end