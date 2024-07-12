if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_bizon")
    killicon.Add("arccw_horde_bizon", "arccw/weaponicons/arccw_go_bizon", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_bizon"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "PP-19 Bizon-2"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_bizon.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_bizon.mdl"

SWEP.Damage = 45
SWEP.DamageMin = 32 -- damage done at maximum range

SWEP.Delay = 60 / 750 -- 60 / RPM.