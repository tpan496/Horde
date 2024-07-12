if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ace")
    killicon.Add("arccw_horde_ace", "arccw/weaponicons/arccw_go_ace", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_ace"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "ACE 22"
SWEP.Slot = 2


SWEP.ViewModel = "models/weapons/arccw_go/v_rif_ace.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_ace.mdl"

SWEP.Damage = 54
SWEP.DamageMin = 44  -- damage done at maximum range

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.ShootVol = 75 -- volume of shoot sound
