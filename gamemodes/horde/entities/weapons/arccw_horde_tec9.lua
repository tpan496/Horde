if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_tec9")
    killicon.Add("arccw_horde_tec9", "arccw/weaponicons/arccw_go_tec9", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_tec9"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "TEC-9"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_tec9.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_tec9.mdl"
