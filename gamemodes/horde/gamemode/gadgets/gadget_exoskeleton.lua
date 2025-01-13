GADGET.PrintName = "Exoskeleton"
GADGET.Icon = "items/gadgets/exoskeleton.png"
GADGET.Description =
[[Using the active ability activates a short boost

You cannot run
Passively increases Global damage resistance by {1}]]

GADGET.Duration = 0
GADGET.Cooldown = 5
GADGET.Active = true

GADGET.Params = {
    [1] = { value = 0.2, percent = true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function ( ply )
    if CLIENT or ply:Horde_GetGadget() ~= "gadget_exoskeleton" then return end
    local dir = ply:GetForward()
    local vel = dir * 1000
    ply:SetLocalVelocity( vel )
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function ( ply, dmginfo, bonus )
    if ply:Horde_GetGadget() ~= "gadget_exoskeleton"  then return end
    bonus.resistance = bonus.resistance + 0.2
end

GADGET.Hooks.Horde_PlayerMoveBonus = function ( ply, bonus_walk, bonus_run )
    if ply:Horde_GetGadget() ~= "gadget_exoskeleton"  then return end
    bonus_run.more = bonus_run.more * 0.8
end