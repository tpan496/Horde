if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_awp")
    killicon.Add("arccw_horde_awp", "arccw/weaponicons/arccw_go_awp", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_awp"
SWEP.Spawnable = false -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AWSM"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_snip_awp.mdl"


SWEP.Damage = 550
SWEP.DamageMin = 550 -- damage done at maximum range
SWEP.Range = 150 -- in METRES

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.5
SWEP.RecoilSide = 0

SWEP.Delay = 60 / 400 -- 60 / RPM.

SWEP.AccuracyMOA = 0.06 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 800 -- inaccuracy added by hip firing.

SWEP.ShootVol = 75 -- volume of shoot sound

SWEP.SpeedMult = 0.9

SWEP.SightTime = 0.25
