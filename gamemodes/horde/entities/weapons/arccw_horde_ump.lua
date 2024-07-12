if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ump")
    killicon.Add("arccw_horde_ump", "arccw/weaponicons/arccw_go_ump", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ump"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "UMP-45"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_ump45.mdl"

SWEP.Damage = 38
SWEP.DamageMin = 27 -- damage done at maximum range
SWEP.RecoilPunch = 0
