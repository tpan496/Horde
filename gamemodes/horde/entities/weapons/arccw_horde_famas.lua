if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_famas")
    killicon.Add("arccw_horde_famas", "arccw/weaponicons/arccw_go_famas", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "FAMAS G1"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "French bullpup assault rifle with three-round burst fire group. Considered by many to be a lousy gun, but it has won the French many a 'la victoire'."
SWEP.Trivia_Manufacturer = "GIAT Industries"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Delayed Blowback"
SWEP.Trivia_Country = "France"
SWEP.Trivia_Year = 1994

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_famas.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 29 * 1.1
SWEP.DamageMin = 19 * 1.1 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 25 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 900

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.05
SWEP.RecoilRise = 0.4
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 1000 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 3 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 500 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 130

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/famas/famas_01.wav"
SWEP.ShootSound = "arccw_go/famas/famas_04.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/famas/famas-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_famas"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.36

SWEP.IronSightStruct = {
    Pos = Vector(-6.26, -7, 1.2),
    Ang = Angle(0, -0.1, -2),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, -1)
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
    ["rail"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
        WMBodygroups = {{ind = 6, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        WMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_famas_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -2.85, 13.4),
            }
        }
    },
    ["go_famas_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2},
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -2.85, 20.5),
            }
        }
    },
    ["go_famas_mag_25"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_556_ammo_60round"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
        },
    }
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-15, 7, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.famas_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -7.25, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(0.25, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0, -0.9, 12),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0.9, -6.7, 4.5),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_famas_barrel",
        DefaultAttName = "490mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.famas_Parent",
        Offset = {
            vpos = Vector(0, -2.9, 16.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_ammo_556_60"},
        DefaultAttName = "25-Round 5.56mm FR"
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
        Bone = "v_weapon.famas_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, -6.2, -2), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
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
        Source = "shoot_iron",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.5,
        LHIKEaseOut = 0.4
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.15,
        LHIKEaseOut = 0.15
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_FAMAS.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_FAMAS.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/famas/famas_cliphit.wav"
})