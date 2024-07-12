if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ak47")
    killicon.Add("arccw_horde_ak47", "arccw/weaponicons/arccw_go_ak47", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ak47"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AKM"
SWEP.Slot = 2
SWEP.ViewModel = "models/weapons/arccw_go/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.Damage = 65
SWEP.DamageMin = 49 -- damage done at maximum range

SWEP.Recoil = 0.45
SWEP.RecoilSide = 0.35
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 600 -- 60 / RPM.
SWEP.ShootVol = 75 -- volume of shoot sound
