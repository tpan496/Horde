if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m1014")
    killicon.Add("arccw_horde_m1014", "arccw/weaponicons/arccw_go_m1014", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_m1014"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - GSO (SGs)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M1014"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_m1014.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_m1014.mdl"


SWEP.Damage = 26
SWEP.DamageMin = 13 -- damage done at maximum range
SWEP.Recoil = 4
SWEP.RecoilSide = 2
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0

SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}


SWEP.AccuracyMOA = 75 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.


SWEP.ShootVol = 75 -- volume of shoot sound

SWEP.SpeedMult = 1

SWEP.SightTime = 0.2
