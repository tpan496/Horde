if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_870")
    killicon.Add("arccw_horde_870", "arccw/weaponicons/arccw_go_870", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_870"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Model 870"
SWEP.Slot = 2
SWEP.ViewModel = "models/weapons/arccw_go/v_shot_870.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_870.mdl"
SWEP.Damage = 24
SWEP.Recoil = 4
SWEP.RecoilSide = 3
SWEP.RecoilPunch = 0
SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.85
SWEP.AccuracyMOA = 85 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
