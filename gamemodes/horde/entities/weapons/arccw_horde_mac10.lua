if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mac10")
    killicon.Add("arccw_horde_mac10", "arccw/weaponicons/arccw_go_mac10", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_mac10"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MAC-10"

SWEP.Slot = 2


SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mac10.mdl"

SWEP.Damage = 35
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.RecoilPunch = 0
