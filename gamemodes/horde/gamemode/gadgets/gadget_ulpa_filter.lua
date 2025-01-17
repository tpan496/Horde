GADGET.PrintName = "ULPA Filter"
GADGET.Description =
[[{1} increased maximum armor.
{2} less debuff buildup.]]
GADGET.Icon = "items/gadgets/ulpa_filter.png"
GADGET.Duration = 0
GADGET.Cooldown = 0
GADGET.Active = false
GADGET.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.5, percent = true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDebuffApply = function ( ply, debuff, bonus, inflictor )
    if ply:Horde_GetGadget() ~= "gadget_ulpa_filter" then return end
    bonus.less = bonus.less * 0.5
end

GADGET.Hooks.Horde_OnSetMaxArmor = function ( ply, bonus )
    if SERVER and ply:Horde_GetGadget() == "gadget_ulpa_filter" then
        bonus.add = bonus.add + 25
    end
end

GADGET.Hooks.Horde_OnSetGadget = function ( ply, gadget )
    if SERVER and gadget == "gadget_ulpa_filter" then
        ply:SetMaxArmor( ply:GetMaxArmor() + 25 )
    end
end

GADGET.Hooks.Horde_OnUnsetGadget = function ( ply, gadget )
    if SERVER and gadget == "gadget_ulpa_filter" then
        ply:SetMaxArmor( ply:GetMaxArmor() - 25 )
    end
end