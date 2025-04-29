if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "3-Round 12-Gauge Mag"
att.Icon = Material("entities/acwatt_go_mag7_mag_3.png", "mips smooth")
att.Description = "Small magazine with lighter load. Improves handling."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.magcap"
}
att.SortOrder = 3
att.AutoStats = true
att.Slot = "horde_go_mag7_mag"

att.Mult_MoveSpeed = 1.1
att.Mult_SightTime = 0.85
att.Override_ClipSize = 3
att.Mult_ReloadTime = 0.9
att.Mult_CycleTime = 0.9

ArcCW.LoadAttachmentType(att, "horde_go_mag7_mag_3")
