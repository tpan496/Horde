if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_p2000")
    killicon.Add("arccw_horde_p2000", "arccw/weaponicons/arccw_go_p2000", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_p2000"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "P2000"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_p2000.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_p2000.mdl"
