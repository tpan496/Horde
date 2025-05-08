GADGET.PrintName = "Berserker Armor"
GADGET.Description = "{1} increased damage.\n{2} increased Global damage resistance.\n{3} increased movespeed.\n{4} increased jump height."
GADGET.Icon = "items/gadgets/berserk_armor.png"
GADGET.Duration = 10
GADGET.Cooldown = 20
GADGET.Active = true
GADGET.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.25, percent = true },
    [3] = { value = 0.25, percent = true },
    [4] = { value = 0.25, percent = true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" then return end
    sound.Play("horde/gadgets/berserk_on.ogg", ply:GetPos())
    sound.Play("horde/gadgets/berserk_in.ogg", ply:GetPos())
    ply.Horde_HasGuts = true
    ply:ScreenFade(SCREENFADE.IN, Color(235, 25, 25, 20), 0.1, 10)
    timer.Simple(10, function()
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

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run, bonus_jump)
    if ply:Horde_GetGadget() ~= "gadget_berserk_armor" or not ply.Horde_HasGuts then return end
    bonus_walk.increase = bonus_walk.increase + 0.25
    bonus_run.increase = bonus_run.increase + 0.25
    bonus_jump.increase = bonus_jump.increase + 0.25
end