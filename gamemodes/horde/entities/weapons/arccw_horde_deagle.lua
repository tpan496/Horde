if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_deagle")
    killicon.Add("arccw_horde_deagle", "arccw/weaponicons/arccw_go_deagle", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_deagle"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Desert Eagle"
SWEP.Slot = 1
SWEP.ViewModel = "models/weapons/arccw_go/v_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_deagle.mdl"

SWEP.Delay = 60 / 300 -- 60 / RPM.
