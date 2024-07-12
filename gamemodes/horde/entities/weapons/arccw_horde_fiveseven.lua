if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_fiveseven")
    killicon.Add("arccw_horde_fiveseven", "arccw/weaponicons/arccw_go_fiveseven", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_fiveseven"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Five-seveN"
SWEP.Slot = 1


SWEP.ViewModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"

SWEP.Damage = 34
SWEP.DamageMin = 25 -- damage done at maximum range

SWEP.Penetration = 10

SWEP.Delay = 60 / 700 -- 60 / RPM.