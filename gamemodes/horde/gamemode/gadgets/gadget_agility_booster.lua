GADGET.PrintName = "Agility Booster"
GADGET.Description =
[[{1} increased movement speed.
{2} increased jump height.
{3} increased dodge chance.]]
GADGET.Icon = "items/gadgets/agility_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.3, percent = true },
    [3] = { value = 0.2, percent = true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetGadget() ~= "gadget_agility_booster" then return end
    bonus_walk.increase = bonus_walk.increase + 0.25
    bonus_run.increase = bonus_run.increase + 0.25
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_agility_booster" then return end
    bonus.evasion = bonus.evasion + 0.2
end

GADGET.Hooks.Horde_OnSetGadget = function(ply, gadget)
    if gadget ~= "gadget_agility_booster" then return end
    ply:SetJumpPower( 150 * ( 1 + 0.3 ) )
end

GADGET.Hooks.Horde_OnUnsetGadget = function(ply, gadget)
    if gadget ~= "gadget_agility_booster" then return end
    ply:SetJumpPower( 150 )
end
