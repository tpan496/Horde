if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "45-Round Extended Mag"
att.AbbrevName = "Extended Mag"


att.SortOrder = 1
att.Icon = Material("entities/acwatt_go_mp5_mag_40.png", "smooth mips")
att.Description = "Extended magazine"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "skorpion_mags"

att.AutoStats = true

att.Mult_SightTime = 1.15
att.Mult_ReloadTime = 1.15
att.Mult_SpeedMult = 0.9
att.Override_ClipSize = 45


att.ActivateElements = {"skorpion_ext"}

att.Hook_SelectReloadAnimation = function(wep, anim)
    return anim .. "_ext"
end

att.HideIfBlocked = true
ArcCW.LoadAttachmentType(att, "bo1_skorpion_ext_mag")
