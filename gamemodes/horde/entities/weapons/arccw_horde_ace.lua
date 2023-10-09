if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ace")
    killicon.Add("arccw_horde_ace", "arccw/weaponicons/arccw_go_ace", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "ACE 22"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "A low-recoil, highly controllable rifle designed for the Israeli Defense Force."
SWEP.Trivia_Manufacturer = "Israeli Weapon Industries"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = ""
SWEP.Trivia_Country = "Israel"
SWEP.Trivia_Year = 1993

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_ace.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_ace.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000000"

SWEP.Damage = 24 * 1.1
SWEP.DamageMin = 19 * 1.1 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 10
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 35 -- DefaultClip is automatically set.

SWEP.RecoilPunch = 2.5

SWEP.PhysBulletMuzzleVelocity = 800

SWEP.Recoil = 0.200
SWEP.RecoilSide = 0.105
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

SWEP.AccuracyMOA = 8 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 120

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/galilar/galil_03.wav"
SWEP.ShootSound = "arccw_go/galilar/galil_04.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/galilar/galil-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_3"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.94
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.42

SWEP.IronSightStruct = {
    Pos = Vector(-5.32, -8, 1.58226),
    Ang = Angle(0, 0, 0),
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
    ["ubrms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
        WMBodygroups = {{ind = 6, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
        WMBodygroups = {{ind = 7, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 4}},
        WMBodygroups = {{ind = 2, bg = 4}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
            {ind = 4, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 1},
            {ind = 4, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_ak_stock_skeleton"] = {
        VMBodygroups = {
            {ind = 5, bg = 2},
            {ind = 4, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 2},
            {ind = 4, bg = 1},
        },
    },
    ["go_ak_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 5, bg = 3},
        },
        WMBodygroups = {
            {ind = 5, bg = 3},
        },
    },
    ["go_ak_stock_contractor"] = {
        VMBodygroups = {
            {ind = 5, bg = 4},
        },
        WMBodygroups = {
            {ind = 5, bg = 4},
        },
    },
    ["go_ace_barrel_short"] = {
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
                vpos = Vector(0, -3.25, 16),
            }
        }
    },
    ["go_ace_barrel_med"] = {
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
                vpos = Vector(0, -3.25, 19.5),
            }
        }
    },
    ["go_ace_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 3},
            {ind = 2, bg = 3},
        },
        WMBodygroups = {
            {ind = 1, bg = 3},
            {ind = 2, bg = 3},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.25, 23.5),
            }
        }
    },
    ["go_ace_mag_20"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_ace_mag_10_762"] = {
        NameChange = "ACE 32",
        VMBodygroups = {
            {ind = 3, bg = 3},
        },
        WMBodygroups = {
            {ind = 3, bg = 3},
        },
    },
    ["go_ace_mag_30_762"] = {
        NameChange = "ACE 32",
        VMBodygroups = {
            {ind = 3, bg = 4},
        },
        WMBodygroups = {
            {ind = 3, bg = 4},
        },
    },
    ["go_ace_mag_40_762"] = {
        NameChange = "ACE 32",
        VMBodygroups = {
            {ind = 3, bg = 5},
        },
        WMBodygroups = {
            {ind = 3, bg = 5},
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
    pos = Vector(-11, 7, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.galilar_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -4.85, 3),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1.1, 1.1, 1.1),
        CorrectivePos = Vector(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.galilar_parent",
        Offset = {
            vpos = Vector(0, -1.6, 12),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.galilar_parent",
        Offset = {
            vpos = Vector(1.15, -3.3, 10),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_ace_barrel",
        DefaultAttName = "340mm ACE Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.galilar_parent",
        Offset = {
            vpos = Vector(0, -3.25, 17.5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = {"go_ace_mag", "go_ammo_556_60"},
        DefaultAttName = "35-Round 5.56mm Galil"
    },
    {
        PrintName = "Stock",
        Slot = {"go_ak47_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.galilar_parent",
        Offset = {
            vpos = Vector(0, -2.85, 0),
            vang = Angle(90, 0, -90),
        },
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
        Bone = "v_weapon.galilar_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.75, -2.5, 7), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
    end
end

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
    ["fix"] = {
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
        LHIKOut = 0.7,
        LHIKEaseOut = 0.4
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.4
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_GALIL.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_GALIL.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_GALIL.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_GALIL.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_GALIL.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/galilar/galil_boltback.wav"
})