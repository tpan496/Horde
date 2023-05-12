GADGET.PrintName = "ULPA Filter"
GADGET.Description =
[[{1} increased maximum armor.
{2} reduced buildups from all sources while you have armor.]]
GADGET.Icon = "items/gadgets/ulpa_filter.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.2, percent = true},
    [2] = {value = 0.25, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
    if ply:Horde_GetGadget() ~= "gadget_ulpa_filter" then return end
    if ply:Armor() > 0 then
        bonus.less = bonus.less * 0.75
    end
end

GADGET.Hooks.Horde_OnSetGadget = function (ply, gadget)
    if SERVER and ply:Horde_GetGadget() == "gadget_ulpa_filter" then
        ply:Horde_SetMaxArmor()
    end
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if SERVER and ply:Horde_GetGadget() == "gadget_ulpa_filter" then
        ply:Horde_SetMaxArmor()
    end
end

GADGET.Hooks.Horde_OnSetMaxArmor = function (ply, bonus)
    if SERVER and ply:Horde_GetGadget() == "gadget_ulpa_filter" then
        bonus.increase = bonus.increase + 0.2
    end
end