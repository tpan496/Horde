GADGET.PrintName = "Damage Booster"
GADGET.Description = "25% increased Global damage."
GADGET.Icon = "items/gadgets/damage_booster.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Params = {
    [1] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetGadget() ~= "gadget_damage_booster" then return end
    bonus.increase = bonus.increase + 0.25
end
