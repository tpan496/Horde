GADGET.PrintName = "Energy Shield"
GADGET.Description = "Temporarily gain 25 armor."
GADGET.Icon = "items/gadgets/energy_shield.png"
GADGET.Duration = 5
GADGET.Cooldown = 15
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_energy_shield" then return end
    sound.Play("horde/gadgets/energy_shield_on.ogg", ply:GetPos())
    sound.Play("horde/gadgets/energy_shield_in.ogg", ply:GetPos())
    ply.Horde_Previous_Armor = ply:Armor()
    ply:SetArmor(ply:Armor() + 25)
    timer.Simple(5, function()
        if not ply:IsValid() then return end
        if ply:Armor() > ply.Horde_Previous_Armor then
            ply:SetArmor(ply.Horde_Previous_Armor)
        end
    end)
end