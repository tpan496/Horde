GADGET.PrintName = "Ultimate Booster"
GADGET.Description = [[15% increased movement speed.
15% increased maximum health.
15% increased Global damage.
15% increased Global damage resistance.]]
GADGET.Icon = "items/gadgets/ultimate_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus_walk.increase = bonus_walk.increase + 0.15
    bonus_run.increase = bonus_run.increase + 0.15
end

GADGET.Hooks.Horde_OnSetMaxHealth = function (ply, bonus)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.increase = bonus.increase + 0.15
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.increase = bonus.increase + 0.15
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.resistance = bonus.resistance + 0.15
end