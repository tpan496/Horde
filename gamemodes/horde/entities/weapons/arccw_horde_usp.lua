if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_usp")
    killicon.Add("arccw_horde_usp", "arccw/weaponicons/arccw_go_usp", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_usp"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "USP-45"
SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_usp.mdl"
