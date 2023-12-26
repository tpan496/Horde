att.PrintName = "Unfolded Stock"
att.AbbrevName = "Unfolded Stock"
att.Icon = Material("entities/att/npczv1grey.png", "smooth mips")
att.Description = "Unfolded wire stock"

att.Slot = "skorpion_misc"
att.AutoStats = true
att.ActivateElements = {"unfolded_stock"}

att.SortOrder = 2
att.Free = true

att.Mult_Recoil = 0.95
att.Mult_RecoilSide = 0.95
--att.Mult_HipDispersion = 0.9
att.Mult_SightTime = 1.25
att.Mult_SpeedMult = 0.95
att.Hook_SelectReloadAnimation = function(wep, anim)
    return anim .. "_stock"
end
ArcCW.LoadAttachmentType(att, "bo1_skorpion_stock_unfolded")
