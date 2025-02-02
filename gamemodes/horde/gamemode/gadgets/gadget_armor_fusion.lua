GADGET.PrintName = "Armor Fusion"
GADGET.Description = [[When toggled, drains your health and recovers armor up to 50% of your maximum armor.]]
GADGET.Icon = "items/gadgets/armor_fusion.png"
GADGET.Cooldown = 1
GADGET.Active = true
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_armor_fusion" then return end
	
    local id = ply:SteamID()
    if ply.Horde_ArmorFusion then
        ply.Horde_ArmorFusion = nil
		ply:EmitSound("items/suitchargeno1.wav")
        timer.Remove("Horde_ArmorFusion" .. id)
    else
        ply.Horde_ArmorFusion = true
		ply:EmitSound("buttons/combine_button5.wav")
        timer.Remove("Horde_ArmorFusion" .. id)
        timer.Create("Horde_ArmorFusion" .. id, 0.2, 0, function ()
            if !ply:IsValid() or !ply:Alive() then
                timer.Remove("Horde_ArmorFusion" .. id)
                return
            end

            if (not ply.Horde_ArmorFusion) then
                timer.Remove("Horde_ArmorFusion" .. id)
                ply.Horde_ArmorFusion = nil
                return
            end
			
        if ply:Health() > (ply:GetMaxHealth() * 0.5) and ply:Armor() < (ply:GetMaxArmor() * 0.5) then
        ply:SetHealth(ply:Health() - 1)
        if ply:Armor() <= (ply:GetMaxArmor() * 0.5) then
        ply:SetArmor(math.min(ply:GetMaxArmor() * 0.5, ply:Armor() + 1))
        end
        end
        end)
    end
end

GADGET.Hooks.Horde_OnUnsetGadget = function (ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_armor_fusion" then return end
    local id = ply:SteamID()
	ply.Horde_ArmorFusion = nil
    timer.Remove("Horde_ArmorFusion" .. id)
end

