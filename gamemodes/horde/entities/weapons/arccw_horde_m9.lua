if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m9")
    killicon.Add("arccw_horde_m9", "arccw/weaponicons/arccw_go_m9", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_m9"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M92FS"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_m9.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_m9.mdl"
