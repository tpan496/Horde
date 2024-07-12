if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_aug")
    killicon.Add("arccw_horde_aug", "arccw/weaponicons/arccw_go_aug", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_aug"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AUG A3"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_aug.mdl"

SWEP.Damage = 63
SWEP.DamageMin = 47 -- damage done at maximum range

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.ShootVol = 75 -- volume of shoot sound
