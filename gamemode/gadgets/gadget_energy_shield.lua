GADGET.PrintName = "Energy Shield"
GADGET.Description = "Gain 15 armor, up to maximum armor regen limit."
GADGET.Icon = "items/gadgets/energy_shield.png"
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_energy_shield" or (not ply.Horde_ArmorRegenMax) then return end
    ply:EmitSound("horde/gadgets/energy_shield_on.ogg")
    local amax = ply.Horde_ArmorRegenMax * ply:GetMaxArmor()
    if ply:Armor() > amax then
        return
    end
    ply:SetArmor(math.min(amax, ply:Armor() + 15))
end