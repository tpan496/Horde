if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_scar")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_scarh", "arccw/weaponicons/arccw_go_scar", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_scar"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SCAR-H"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_scar.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_scar.mdl"
SWEP.ViewModelFOV = 60

SWEP.Damage = 55
SWEP.DamageMin = 40 -- damage done at maximum range
SWEP.RecoilPunch = 0.2

SWEP.Delay = 0.1 -- 60 / RPM.


SWEP.AccuracyMOA = 1.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 285 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.ShootVol = 75 -- volume of shoot sound

SWEP.SpeedMult = 0.96
SWEP.SightTime = 0.2

SWEP.ActivePos = Vector(0, 0, 0)
