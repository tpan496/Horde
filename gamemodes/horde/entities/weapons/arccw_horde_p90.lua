if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_p90")
    killicon.Add("arccw_horde_p90", "arccw/weaponicons/arccw_go_p90", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_p90"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "P90 TR"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_p90.mdl"

SWEP.Damage = 41
SWEP.DamageMin = 30 -- damage done at maximum range
SWEP.RecoilPunch = 0
