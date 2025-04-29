if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "4-Round 870 Tube"
att.Icon = Material("entities/acwatt_go_870_mag_4.png", "mips smooth")
att.Description = "Small tube with lighter load. Improves handling."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "con.magcap"
}
att.SortOrder = 4
att.AutoStats = true
att.Slot = "horde_go_870_mag"

att.Mult_MoveSpeed = 1.1
att.Mult_SightTime = 0.85
att.Override_ClipSize = 4
att.Mult_ReloadTime = 0.9
att.Mult_CycleTime = 0.9

ArcCW.LoadAttachmentType(att, "horde_go_870_mag_4")
