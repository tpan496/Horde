if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_mp40")
    killicon.Add("arccw_horde_mp40", "arccw/weaponicons/arccw_horde_mp40", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP40"
SWEP.Trivia_Class = "PDW"
SWEP.Trivia_Desc = "A submachine gun chambered for the 9×19mm Parabellum cartridge."
SWEP.Trivia_Manufacturer = "Nazi Germany"
SWEP.Trivia_Calibre = "9×19mm"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1940

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/vj_weapons/c_mp40.mdl"
SWEP.WorldModel = "models/vj_weapons/w_mp40.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 30
SWEP.DamageMin = 24 -- damage done at maximum range
SWEP.Range = 75 -- in METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 32 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 740

SWEP.Recoil = 0.18
SWEP.RecoilSide = 0.05
SWEP.RecoilRise = 0.15
SWEP.RecoilPunch = 2

SWEP.Delay = 60 / 525 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0,
    },
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 4 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "mp40" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "vj_weapons/mp_40/mp40_single.wav"
SWEP.ShootSound = "vj_weapons/mp_40/mp40_single.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "vj_weapons/mp_40/mp40_single_dist.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_3"
SWEP.ShellModel = "models/shells/shell_57.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-4.4, -7, 1.4),
    Ang = Angle(1, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "smg"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["nofh"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["ubrms"] = {
        NameChange = "MP7A2",
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["go_mp7_mag_20"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["go_mp7_mag_40"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
        WMBodygroups = {
            {ind = 2, bg = 2},
        },
    },
    ["go_mp7_stock_in"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_mp7_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 5, bg = 2},
        },
        WMBodygroups = {
            {ind = 5, bg = 2},
        },
    },
    ["go_mp7_stock_contractor"] = {
        VMBodygroups = {
            {ind = 5, bg = 3},
        },
        WMBodygroups = {
            {ind = 5, bg = 3},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 5, bg = 4},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.mp7_Parent",
                Offset = {
                    pos = Vector(0, -2.75, -4.75),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-15, 6, -3.5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic"},
        Bone = "v_mp40.mag_release",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.55, -2, -5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_mp40.mag_release",
        Offset = {
            vpos = Vector(-1, 0.2, 4),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_mp40.mag_release",
        Offset = {
            vpos = Vector(-0.5, -1.3, 12),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"nofh"},
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
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"},
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
    },
}