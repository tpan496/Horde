if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mag7")
    killicon.Add("arccw_horde_mag7", "arccw/weaponicons/arccw_go_mag7", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Shotguns" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MAG-7"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "South African combat shotgun that accepts minishells in a magazine located in the pistol grip. It was created to combine the features of a submachine gun and a pump shotgun. Featured in the 1996 film 'Romeo and Juliet' starring Leonardo DiCaprio."
SWEP.Trivia_Manufacturer = "Techno Arms"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "South Africa"
SWEP.Trivia_Year = 1995

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_shot_mag7.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_shot_mag7.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

--SWEP.Horde_Locational_DMG = true
SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.75,
    [HITGROUP_RIGHTARM] = 0.75,
    [HITGROUP_LEFTLEG] = 0.5,
    [HITGROUP_RIGHTLEG] = 0.5,
}

SWEP.Damage = 18
SWEP.DamageMin = 9 -- damage done at maximum range
SWEP.Num = 10
SWEP.Range = 30 -- in METRES
SWEP.RangeMin = 5 -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 200 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 5 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 350

SWEP.Recoil = 4
SWEP.RecoilSide = 2
SWEP.RecoilRise = 0.1
--SWEP.RecoilPunch = 1.5

SWEP.ManualAction = true
SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "PUMP"
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 60 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 25 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25
SWEP.JumpDispersion = 0

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses
SWEP.MagID = "mag7" -- the magazine pool this gun draws from

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/mag7/mag7_01.wav"
SWEP.ShootSoundSilenced = "arccw_go/m590_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/mag7/mag7-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-6.36, -5, 3.4),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.ActivePos = Vector(-1, 0, -1)
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
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["nors"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
    },
    ["go_mag7_mag_3"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["go_mag7_mag_7"] = {
        VMBodygroups = {{ind = 2, bg = 2}},
    },
    ["horde_go_mag7_mag_3"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["horde_go_mag7_mag_7"] = {
        VMBodygroups = {{ind = 2, bg = 2}},
    },
    ["go_mag7_barrel_short"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -4.15, 16.5),}
        }
    },
    ["go_mag7_barrel_long"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -4.15, 23.5),}
        }
    },
    ["go_mag7_stock_heavy"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
    },
    ["go_stock"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.mag7_Parent",
                Offset = {
                    pos = Vector(0, -3.5, -5),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-18, 7, -6),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.mag7_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.05, -5.5, 3),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        InstalledEles = {"rail", "nors"},
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.pump",
        Offset = {
            vpos = Vector(-0.05, -1.5, -0.75),
            vang = Angle(0, -90, 0),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.mag7_Parent",
        Offset = {
            vpos = Vector(1.3, -4.5, 10),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_mag7_barrel",
        DefaultAttName = "320mm Standard Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.mag7_Parent",
        Offset = {
            vpos = Vector(0, -4.15, 19),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"no_fh"}
    },
    {
        PrintName = "Magazine",
        Slot = "horde_go_mag7_mag",
        DefaultAttName = "5-Round 12-Gauge Mag"
    },
    {
        PrintName = "Stock",
        Slot = {"go_mag7_stock", "go_stock"},
        DefaultAttName = "QD Sling",
        Bone = "v_weapon.mag7_Parent",
        Offset = {
            vpos = Vector(0, -3.5, -5),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "horde_go_shotgun_ammo", --go_ammo
        DefaultAttName = "Buckshot Shells"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.mag7_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1, -3.75, -4), -- offset that the attachment will be relative to the bone
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
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.5,
    },
    ["cycle"] = {
        Source = "cycle",
        ShellEjectAt = 0.25,
        Time = 0.55, -- 0.75
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        LHIKEaseOut = 0.35
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        LHIKEaseOut = 0.35
    },
    ["reload_longmag"] = {
        Source = "reload_longmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        LHIKEaseOut = 0.35
    },
    ["reload_longmag_empty"] = {
        Source = "reload_longmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        LHIKEaseOut = 0.35
    },
}

sound.Add({
    name = "ArcCW_GO_MAG7.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mag7/mag7_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_MAG7.PumpBack",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mag7/mag7_pump_back.wav"
})

sound.Add({
    name = "ARCCW_GO_MAG7.PumpForward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mag7/mag7_pump_forward.wav"
})

sound.Add({
    name = "ARCCW_GO_MAG7.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mag7/mag7_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_MAG7.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mag7/mag7_clipin.wav"
})
