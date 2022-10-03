GADGET.PrintName = "ULPA Filter"
GADGET.Description =
[[{1} reduced buildups from all sources while you have armor.
Buildups also drain your armor.]]
GADGET.Icon = "items/gadgets/ulpa_filter.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = {value = 0.5},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus, inflictor)
    if ply:Horde_GetGadget() ~= "gadget_ulpa_filter" then return end
    if ply:Armor() > 0 then
        bonus.less = bonus.less * 0.5
        ply:SetArmor(math.max(0,ply:Armor() - math.max(1, debuff / 4)))
    end
end