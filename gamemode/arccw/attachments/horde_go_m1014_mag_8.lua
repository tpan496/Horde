if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "8-Round M1014 Tube"
att.Icon = Material("entities/acwatt_go_m1014_mag_7.png", "mips smooth")
att.Description = "Extended magazine with 8-round capacity."
att.SortOrder = 7
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "horde_go_m1014_mag"

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.05
att.Override_ClipSize = 8
--att.Mult_ReloadTime = 1.1

ArcCW.LoadAttachmentType(att, "horde_go_m1014_mag_8")

