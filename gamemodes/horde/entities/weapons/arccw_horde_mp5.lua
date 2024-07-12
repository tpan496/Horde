if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp5")
    killicon.Add("arccw_horde_mp5", "arccw/weaponicons/arccw_go_mp5", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_mp5"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP5A3"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp5.mdl"

SWEP.RecoilPunch = 0
