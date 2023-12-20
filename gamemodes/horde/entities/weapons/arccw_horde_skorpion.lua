if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_bo1_skorpion")
    killicon.Add("arccw_horde_skorpion", "arccw/weaponicons/arccw_bo1_skorpion", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Skorpion"
SWEP.TrueName = "Skorpion Vz. 65"
SWEP.Trivia_Class = "Machine Pistol"
SWEP.Trivia_Desc = "Soviet Submachine Gun designed for security forces which found use by low ranking army staff, vehicle drivers and personnel, and special forces."
SWEP.Trivia_Manufacturer = "KBP"
SWEP.Trivia_Calibre = "9x18mm Makarov"
SWEP.Trivia_Mechanism = "Blowback"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = 1959

SWEP.Slot = 1

SWEP.ViewModel = "models/horde/weapons/arccw/c_bo1_skorpion.mdl"
SWEP.WorldModel = "models/horde/weapons/arccw/c_bo1_skorpion.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos        =    Vector(-7.25, 4.5, -4.1),
    ang        =    Angle(-7.5, 1, 180),
    bone    =    "ValveBiped.Bip01_R_Hand",
    scale = 1.15,
}
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000"

SWEP.Damage = 26
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 80
SWEP.RangeMin = 15

SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 320 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 35

SWEP.Recoil = 0.22
SWEP.RecoilSide = 0.27
SWEP.RecoilRise = 0.75
SWEP.VisualRecoilMult = 0.2
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 850 -- 60 / RPM.
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

SWEP.NPCWeaponType = {"weapon_pistol", "weapon_smg1"}
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 6 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 240 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "skorpion" -- the magazine pool this gun draws from

SWEP.ShootVol = 115 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

--SWEP.FirstShootSound = "ArcCW_BO1.Skorpion_Fire"
SWEP.ShootSound = "ArcCW_BO1.Skorpion_Fire"
SWEP.ShootSoundSilenced = "ArcCW_BO2.Pistol_Sil"
SWEP.DistantShootSound = {"ArcCW_BO1.Skorpion_RingOff_F", "ArcCW_BO1.Skorpion_RingOff_R"}

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1.25
SWEP.ShellMaterial = "models/weapons/arcticcw/shell_556_steel"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.2

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-2.915, 0, 0.625),
    Ang = Angle(0.775, 0.035, 0),
    Magnification = 1.1,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(1, 3, 0.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 3, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(15, 2, -2)
SWEP.CustomizeAng = Angle(15, 40, 20)

SWEP.HolsterPos = Vector(3, 0, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 10

SWEP.ExtraSightDist = 0

SWEP.AttachmentElements = {
    ["skorpion_ext"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
    },
    ["light_stock"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["ammo_papunch"] = {
        NamePriority = 10,
        NameChange = "Vicious Zeta-115",
        Mult_RPM = 1.1,
    },
}

SWEP.RejectAttachments = {
    ["bo1_stock_medium"] = true,
}

SWEP.Attachments = {
    { --1
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = "optic", -- what kind of attachments can fit here, can be string or table
        Bone = "tag_weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, -0.125, 2.25), -- 4.6 offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
        },
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0),
    },
    { --2
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        VMScale = Vector(1, 1, 1),
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(8, 0-0.125, 1.45), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
        },
    },
    { --3
        PrintName = "Tactical",
        Slot = "tac",
        VMScale = Vector(0.75, 0.75, 0.75),
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0, -0.5, 1.75), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 90),
            wpos = Vector(8, 0.4, -4.5),
            wang = Angle(-7.5, 0, 85)
        },
    },
    { --7
        PrintName = "Ammo Type",
        Slot = {"go_ammo"}
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(7, -0.5, 2),
            vang = Angle(0, 0, 0),
        },
    },
}


SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 30,
    },
    ["idle_empty"] = {
        Source = "idle_empty",
        Time = 1 / 30,
    },
    ["holster"] = {
        Source = "holster",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
    },
    ["draw"] = {
        Source = "draw",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
    },
    ["draw_stock"] = {
        Source = "first_draw_stock",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_Futz", t = 6 / 30},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 12 / 30},
        },
    },
    ["draw_stock_ext"] = {
        Source = "first_draw_stock",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_Futz", t = 6 / 30},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 12 / 30},
        },
    },
    ["ready"] = {
        Source = "draw",
        Time = 1,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
    },
    ["ready_stock"] = {
        Source = "first_draw_stock",
        Time = 1.5,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_Futz", t = 12 / 30},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 18 / 30},
        },
    },
    ["ready_stock_ext"] = {
        Source = "first_draw_stock",
        Time = 1.5,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.25,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_Futz", t = 12 / 30},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 18 / 30},
        },
    },
    ["fire"] = {
        Source = {"fire"},
        Time = 7 / 30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire_ads"},
        Time = 7 / 30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 90 / 35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Framerate = 30,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_MagOut", t = 15 / 35},
            {s = "ArcCW_BO1.Skorpion_Futz", t = 45 / 30},
            {s = "ArcCW_BO1.Skorpion_MagIn", t = 56 / 35}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 120 / 35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Framerate = 30,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_MagOut", t = 16 / 35},
            {s = "ArcCW_BO1.Skorpion_Futz", t = 45 / 30},
            {s = "ArcCW_BO1.Skorpion_MagIn", t = 56 / 35},
            {s = "ArcCW_BO1.Skorpion_BoltBack", t = 75 / 35},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 81 / 35},
        },
    },
    ["reload_ext"] = {
        Source = "reload_ext",
        Time = 90 / 35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Framerate = 30,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_MagOut", t = 15 / 35},
            {s = "ArcCW_BO1.Skorpion_Futz", t = 45 / 30},
            {s = "ArcCW_BO1.Skorpion_MagIn", t = 56 / 35}
        },
    },
    ["reload_empty_ext"] = {
        Source = "reload_empty_ext",
        Time = 120 / 35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Framerate = 30,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_MagOut", t = 16 / 35},
            {s = "ArcCW_BO1.Skorpion_Futz", t = 45 / 30},
            {s = "ArcCW_BO1.Skorpion_MagIn", t = 56 / 35},
            {s = "ArcCW_BO1.Skorpion_BoltBack", t = 75 / 35},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 81 / 35},
        },
    },
    ["reload_stock_ext"] = {
        Source = "reload_ext",
        Time = 90 / 35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Framerate = 30,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_MagOut", t = 15 / 35},
            {s = "ArcCW_BO1.Skorpion_Futz", t = 45 / 30},
            {s = "ArcCW_BO1.Skorpion_MagIn", t = 56 / 35}
        },
    },
    ["reload_empty_stock_ext"] = {
        Source = "reload_empty_ext",
        Time = 120 / 35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Framerate = 30,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "ArcCW_BO1.Skorpion_MagOut", t = 16 / 35},
            {s = "ArcCW_BO1.Skorpion_Futz", t = 45 / 30},
            {s = "ArcCW_BO1.Skorpion_MagIn", t = 56 / 35},
            {s = "ArcCW_BO1.Skorpion_BoltBack", t = 75 / 35},
            {s = "ArcCW_BO1.Skorpion_BoltFwd", t = 81 / 35},
        },
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 10 / 30
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 30 / 40
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 10 / 30
    },
}

sound.Add( {
    name = "ArcCW_BO1.Skorpion_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/fire1.wav",
        "^weapons/arccw/bo1_skorpion/fire2.wav",
        "^weapons/arccw/bo1_skorpion/fire3.wav",
        "^weapons/arccw/bo1_skorpion/fire4.wav",
        "^weapons/arccw/bo1_skorpion/fire5.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_RingOff_F",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/ringoff_f.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_RingOff_R",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/ringoff_r.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_MagIn",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/in.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_MagOut",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/out.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_BoltBack",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/pull.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_BoltFwd",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/fwd.wav",
    }
} )
sound.Add( {
    name = "ArcCW_BO1.Skorpion_Futz",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    --pitch = {95, 110},
    sound = {
        "^weapons/arccw/bo1_skorpion/futz.wav",
    }
} )
