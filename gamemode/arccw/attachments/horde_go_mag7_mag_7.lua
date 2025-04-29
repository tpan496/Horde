if not ArcCWInstalled then return end
AddCSLuaFile()
local att = {}
att.PrintName = "7-Round 12-Gauge Mag"
att.Icon = Material("entities/acwatt_go_mag7_mag_7.png", "mips smooth")
att.Description = "Extended magazine with 7-round capacity, bringing the MAG-7 to its namesake capacity. Try saying 'MAG-7 7 Round 12 Gauge Mag 7 times' seven times fast."
att.SortOrder = 7
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "horde_go_mag7_mag"

--att.Mult_MoveSpeed = 0.98
att.Mult_SightTime = 1.05
att.Override_ClipSize = 7
att.Mult_ReloadTime = 1.1

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_longmag"
    elseif anim == "reload_empty" then
        return "reload_longmag_empty"
    end
end

ArcCW.LoadAttachmentType(att, "horde_go_mag7_mag_7")
