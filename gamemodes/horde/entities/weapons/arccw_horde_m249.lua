if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m249para")
    killicon.Add("arccw_horde_m249", "arccw/weaponicons/arccw_go_m249para", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_m249para"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M249 SAW"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_mach_m249para.mdl"

SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.

SWEP.RecoilPunch = 0

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.SpeedMult = 0.9

SWEP.ShootSpeedMult = 0.75
SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.topHinge",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.04, -0.4, -5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1.1, 1.1, 1.1),
        InstalledEles = {"rs_none"},
        CorrectiveAng = Angle(1, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "m249_bipod"},
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(0, -1.15, 15),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(1.15, -4.3, 15.75),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_m249_barrel",
        DefaultAttName = "460mm SAW Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(0, -4.4, 30),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_m249_mag",
        DefaultAttName = "100-Round 5.56mm Belt"
    },
    {
        PrintName = "Stock",
        Slot = {"go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(0, -4, -3),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1, 1, 1)
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.m249_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -3.25, 4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.Jamming = nil
