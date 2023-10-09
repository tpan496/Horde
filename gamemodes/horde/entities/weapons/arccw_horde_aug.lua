if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_aug")
    killicon.Add("arccw_horde_aug", "arccw/weaponicons/arccw_go_aug", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AUG A3"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "Bullpup assault rifle, whose design puts the mechanism behind the grip, allowing for a longer barrel without extending the effective length of the weapon. Good magazine capacity, poor recoil characteristics."
SWEP.Trivia_Manufacturer = "Steyr"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Austria"
SWEP.Trivia_Year = 2004

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_aug.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 28 * 1.25
SWEP.DamageMin = 21 * 1.25 -- damage done at maximum range
SWEP.Range = 120 -- in METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 36 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 970

SWEP.Recoil = 0.45
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
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

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 3 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 600 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/aug/aug_01.wav"
SWEP.ShootSound = "arccw_go/aug/aug_03.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/aug/aug-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_6"
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
    Pos = Vector(-3.618, -7, 0.7),
    Ang = Angle(-0.75, 0.02, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
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
    ["nors"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["nofh"] = {
        VMBodygroups = {{ind = 2, bg = 2}},
        WMBodygroups = {{ind = 2, bg = 2}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["go_aug_barrel_short"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
            {ind = 2, bg = 2},
        },
        WMBodygroups = {
            {ind = 4, bg = 1},
            {ind = 2, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.5, 12.75),
            }
        }
    },
    ["go_aug_barrel_long"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 4, bg = 2},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.5, 19.75),
            }
        }
    },
    ["go_aug_ammo_9mm"] = {
        NameChange = "AUG 9mm",
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
    pos = Vector(-11, 5, -3),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.aug_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -5, 4),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"nors"},
        CorrectiveAng = Angle(1.25, -0.1, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.aug_Parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -1.1, 9),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.aug_Parent",
        Offset = {
            vpos = Vector(-1.219, -3.727, 4.5),
            vang = Angle(90, 0, 132.5),
        },
    },
    {
        PrintName = "Barrel",
        Slot = "go_aug_barrel",
        DefaultAttName = "510mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.aug_Parent",
        Offset = {
            vpos = Vector(0, -3.5, 16),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"nofh"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_aug_9mm", "go_ammo_556_60"},
        DefaultAttName = "36-Round 5.56mm Poly"
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
        Bone = "v_weapon.aug_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1.25, -3.25, 0), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
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
        Source = "shoot",
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
        LHIKOut = 1,
        LHIKEaseOut = 0.7
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.5
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_AUG.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/aug/aug_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_AUG.Boltpull",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/aug/aug_boltpull.wav"
})

sound.Add({
    name = "ARCCW_GO_AUG.Boltrelease",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/aug/aug_boltrelease.wav"
})

sound.Add({
    name = "ARCCW_GO_AUG.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/aug/aug_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_AUG.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/aug/aug_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_AUG.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/aug/aug_cliphit.wav"
})