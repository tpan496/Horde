GADGET.PrintName = "Ultimate Booster"
GADGET.Description = [[15% increased movement speed.
25% increased maximum health. 15% increased Global damage.
15% increased Global damage resistance.
25% less debuff buildup.]]
GADGET.Icon = "items/gadgets/ultimate_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.15, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus_walk.increase = bonus_walk.increase + 0.15
    bonus_run.increase = bonus_run.increase + 0.15
end

GADGET.Hooks.Horde_OnSetMaxHealth = function (ply, bonus)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.increase = bonus.increase + 0.25
end

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.increase = bonus.increase + 0.15
end

GADGET.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.resistance = bonus.resistance + 0.15
end

GADGET.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
if ply:Horde_GetGadget() ~= "gadget_ultimate_booster" then return end
    bonus.less = bonus.less * 0.75
end