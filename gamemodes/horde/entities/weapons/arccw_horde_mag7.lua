if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mag7")
    killicon.Add("arccw_horde_mag7", "arccw/weaponicons/arccw_go_mag7", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_mag7"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MAG-7"

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_mag7.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_mag7.mdl"

SWEP.Damage = 17

SWEP.Range = 45 -- in METRES
SWEP.RecoilPunch = 0


SWEP.AccuracyMOA = 65 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
