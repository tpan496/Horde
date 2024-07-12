if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ssg08")
    killicon.Add("arccw_horde_ssg08", "arccw/weaponicons/arccw_go_ssg08", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ssg08"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SSG08"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_snip_ssg08.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_snip_ssg08.mdl"

SWEP.Damage = 300
SWEP.DamageMin = 300 -- damage done at maximum range
SWEP.Recoil = 1
SWEP.RecoilSide = 0.2
SWEP.RecoilPunch = 0

SWEP.AccuracyMOA = 0.1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.9
SWEP.SightTime = 0.2
