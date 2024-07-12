if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_cz75")
    killicon.Add("arccw_horde_cz75", "arccw/weaponicons/arccw_go_cz75", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_cz75"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "CZ-75"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_cz75.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_cz75.mdl"



SWEP.Delay = 60 / 600 -- 60 / RPM.
