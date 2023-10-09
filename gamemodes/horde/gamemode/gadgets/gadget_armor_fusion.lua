GADGET.PrintName = "Armor Fusion"
GADGET.Description = [[When toggled, drains your health and recovers armor up to {1} of your maximum armor.]]
GADGET.Icon = "items/gadgets/armor_fusion.png"
GADGET.Cooldown = 1
GADGET.Active = true
GADGET.Params = {
    [1] = {value = 0.5, percent = true},
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_armor_fusion" then return end
    ply:EmitSound("buttons/combine_button5.wav")
    local id = ply:SteamID()
    if ply.Horde_ArmorFusion then
        ply.Horde_ArmorFusion = nil
        timer.Remove("Horde_ArmorFusion" .. id)
    else
        ply.Horde_ArmorFusion = true
        timer.Remove("Horde_ArmorFusion" .. id)
        timer.Create("Horde_ArmorFusion" .. id, 0.2, 0, function ()
            if !ply:IsValid() then
                timer.Remove("Horde_ArmorFusion" .. id)
                return
            end

            if (not ply.Horde_ArmorFusion) or (ply:Armor() >= ply:GetMaxArmor() * 0.5) or (ply:Health() <= 1) then
                timer.Remove("Horde_ArmorFusion" .. id)
                ply.Horde_ArmorFusion = nil
                return
            end

            ply:SetHealth(ply:Health() - 1)
            ply:SetArmor(ply:Armor() + 1)
        end)
    end
end