if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_tec9")
    killicon.AddAlias("arccw_horde_tec9", "arccw/weaponicons/arccw_go_tec9", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Pistols" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "TEC-9"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Cheap open bolt pistol originally created for the Swedish special forces market. However, the Swedish market for budget special forces submachine guns wasn't very big, so they exported the design to the United States where it became infamous as a cheap pistol that could be easily converted into full auto. As a result, it was the direct target of several 'assault weapon' bans."
SWEP.Trivia_Manufacturer = "Intratec"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Straight Blowback"
SWEP.Trivia_Country = "Sweden"
SWEP.Trivia_Year = 1984

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_tec9.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_tec9.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 28
SWEP.DamageMin = 21 -- damage done at maximum range
SWEP.Range = 40 -- in METRES
SWEP.Penetration = 6
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 24 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 300

SWEP.Recoil = 0.400
SWEP.RecoilSide = 0.325
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 750 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "tec9" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/tec9/tec9-1.wav"
SWEP.ShootSoundSilenced = "arccw_go/usp/usp_02.wav"
SWEP.DistantShootSound = "arccw_go/tec9/tec9_distant_01.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.275

SWEP.IronSightStruct = {
    Pos = Vector(-5.1, -7, 2.55),
    Ang = Angle(0, 0.175, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

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
    ["go_tec9_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.35, 8)
            }
        }
    },
    ["go_tec9_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.35, 15.5)
            }
        }
    },
    ["go_tec9_mag_10"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["go_tec9_mag_32"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
    },
    ["rail"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["tacms"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["ubrms"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 6, -4.5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.tec9_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.0225, -4.3, 3),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(-0.2, 0, 0)
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.tec9_parent",
        Offset = {
            vpos = Vector(1.31, -3.25, 8.5),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"tacms"},
        ExcludeFlags = {"go_tec9_barrel_short"},
        MergeSlots = {3}
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.tec9_parent",
        Offset = {
            vpos = Vector(0, -2, 9),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
        ExcludeFlags = {"go_tec9_barrel_short"},
        Hidden = true
    },
    {
        PrintName = "Barrel",
        Slot = "go_tec9_barrel",
        DefaultAttName = "130mm TEC-9 Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.tec9_parent",
        Offset = {
            vpos = Vector(0, -3.35, 11),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Magazine",
        Slot = "go_tec9_mag",
        DefaultAttName = "24-Round 9mm TEC-9"
    },
    {
        PrintName = "Stock",
        Slot = "go_stock_pistol_bt",
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.tec9_parent",
        Offset = {
            vpos = Vector(0, -2.75, -1),
            vang = Angle(90, 0, -90),
        }
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_homemade_auto", "go_perk_pistol"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.tec9_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -2.5, 3), -- offset that the attachment will be relative to the bone
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
        Source = {"shoot1", "shoot2"},
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.4,
    },
}

sound.Add({
    name = "ARCCW_GO_TEC9.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/tec9/tec9_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_TEC9.boltpull",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/tec9/tec9_boltpull.wav"
})

sound.Add({
    name = "ARCCW_GO_TEC9.boltrelease",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/tec9/tec9_boltrelease.wav"
})

sound.Add({
    name = "ARCCW_GO_TEC9.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/tec9/tec9_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_TEC9.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/tec9/tec9_clipin.wav"
})