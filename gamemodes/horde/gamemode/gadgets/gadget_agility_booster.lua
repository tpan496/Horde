GADGET.PrintName = "Agility Booster"
GADGET.Description = "{1} increased movement speed."
GADGET.Icon = "items/gadgets/agility_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetGadget() ~= "gadget_agility_booster" then return end
    bonus_walk.increase = bonus_walk.increase + 0.25
    bonus_run.increase = bonus_run.increase + 0.25
end
