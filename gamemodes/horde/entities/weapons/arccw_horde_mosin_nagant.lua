if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_waw_mosin")
    killicon.Add("arccw_horde_mosin_nagant", "arccw/weaponicons/arccw_waw_mosin", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Mosin-Nagant M38"
SWEP.Trivia_Class = "Rifle"
SWEP.Trivia_Desc = "The standard soviet infantry rifle during World War 2. For some time there weren't enough issued to supply the whole army due to german intervention."
SWEP.Trivia_Manufacturer = "Tula Arms"
SWEP.Trivia_Calibre = "7.62x54mmR"
SWEP.Trivia_Mechanism = "Bolt Action"
SWEP.Trivia_Country = "Russian Empire"
SWEP.Trivia_Year = 1891

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/arccw/c_waw_mosin.mdl"
SWEP.WorldModel = "models/horde/weapons/arccw/w_waw_mosin.mdl"
SWEP.MirrorWorldModel = "models/horde/weapons/arccw/w_waw_mosin.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos        =    Vector(-5.5, 2, -7.5),
    ang        =    Angle(-10, 0, 180),
    bone    =    "ValveBiped.Bip01_R_Hand",
    scale   =   0.9
}
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0100000000"

SWEP.Damage = 250
SWEP.DamageMin = 250
SWEP.Range = 20
SWEP.Penetration = 30
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 850 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 5 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 17

SWEP.Recoil = 1.5
SWEP.RecoilSide = 1
SWEP.RecoilRise = 0.75
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 45-- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "BOLT",
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {
    "weapon_ar2",
    "weapon_crossbow",
}
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 100 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "mosin" -- the magazine pool this gun draws from

SWEP.ShootVol = 75 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "ArcCW_WAW.Mosin_Fire"
SWEP.ShootSoundSilenced = "weapons/fesiugmw2/fire/shot_sil.wav"
SWEP.DistantShootSound = "ArcCW_WAW.Mosin_Ringoff"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.3

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false
SWEP.ShotgunReload = false
SWEP.ManualAction = true

SWEP.CaseBones = {
    [0] = "tag_stripper",
    [1] = "tag_round1",
    [2] = "tag_round2",
}

SWEP.IronSightStruct = {
    Pos = Vector(-0.95, 0, 3.5),
    Ang = Angle(0.2, 1.575, 0),
    Magnification = 1.25,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(1.5, -5, 2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(10, -5, -2)
SWEP.SprintAng = Angle(-7.036, 45.016, 0)

SWEP.CustomizePos = Vector(20, 0, 0)
SWEP.CustomizeAng = Angle(15, 40, 25)

SWEP.HolsterPos = Vector(3, 0, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 30

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
    ["mount"] = {
        VMElements = {
            {
                Model = "models/horde/weapons/arccw/item/bo1_ak_rail.mdl",
                Bone = "tag_weapon",
                Scale = Vector(0.375, 0.375, 0.375),
                Offset = {
                    pos = Vector(5, 0.325, 0.8),
                    ang = Angle(0, 90, 0),
                }
            },
        },
    },
}

SWEP.Attachments = {
    { --1
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic", "optic_lp"}, -- what kind of attachments can fit here, can be string or table
        Bone = "tag_weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(5.5, 0, 1.95), -- 4.6 offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(4.5, 1.35, -5.4),
            wang = Angle(171, 179, 0)
        },
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 0, 0),
        InstalledEles = {"mount"},
    },
    { --2
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"muzzle"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(26.1, 0, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(0, 0, 0),
            wang = Angle(0, 0, 0)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(5, 0, -0.4), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(17.5, 1.125, -4.6),
            wang = Angle(172.5, -179, -1.5),
        },
    }, --3
    {
        PrintName = "Tactical",
        Slot = {"tac"},
        VMScale = Vector(0.75, 0.75, 0.75),
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(15, -0.6, 0.75), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 90),
        },
    }, --5
    {
        PrintName = "Ammo Type",
        Slot = {"go_ammo"}
    }, --6
    {
        PrintName = "Perk",
        Slot = {"go_perk"}
    }, --7
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-2, -0.8, -0.5),
            vang = Angle(0, 0, 0),
        },
    }, --8
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    local snipe = 0

    if snipe == 1 then
        wep.ActivePos = Vector(0.5, 1, -2)
        wep.ActiveAng = Angle(0, 0, 0)
        return anim .. "_snipe"
    elseif snipe == 0 then
        wep.ActivePos = Vector(1.5, 1, 2)
        wep.ActiveAng = Angle(0, 0, 0)
    end

    if wep:Clip1() == 0 then
        return anim .. "_empty"
    end

end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 30,
    },
    ["draw"] = {
        Source = "draw",
        Mult = 0.5,
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["holster"] = {
        Source = "holster",
        Mult = 0.5,
        Time = 0.5,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = "first_draw",
        Time = 31 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = {"fire"},
        Time = 7 / 30,
        {s = "ArcCW_WAW.Mosin_Mech", t = 1 / 30},
    },
    ["cycle"] = {
        Source = {"cycle"},
        Time = 28 / 30,
        ShellEjectAt = 10 / 30,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Up", t = 5 / 30},
            {s = "ArcCW_WAW.Mosin_Back", t = 10 / 30},
            {s = "ArcCW_WAW.Mosin_Fwd", t = 20 / 30},
            {s = "ArcCW_WAW.Mosin_Down", t = 22 / 30},
        },
    },
    ["fire_iron"] = {
        Source = {"fire_ads"},
        Time = 7 / 30,
        {s = "ArcCW_WAW.Mosin_Mech", t = 1 / 30},
    },
    ["cycle_ads"] = {
        Source = {"cycle_ads"},
        Time = 28 / 30,
        ShellEjectAt = 10 / 30,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Up", t = 5 / 30},
            {s = "ArcCW_WAW.Mosin_Back", t = 10 / 30},
            {s = "ArcCW_WAW.Mosin_Fwd", t = 20 / 30},
            {s = "ArcCW_WAW.Mosin_Down", t = 22 / 30},
        },
    },
    ["reload"] = {
        Source = "reload",
        Time = 2.366 * 1.25,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Up", t = 0.15 * 1.25},
            {s = "ArcCW_WAW.Mosin_Back", t = 0.3 * 1.25},
            {s = "ArcCW_WAW.Mosin_Rechamber", t = 0.5 * 1.25},
            {s = "ArcCW_WAW.Mosin_Fwd", t = 1.67 * 1.25},
            {s = "ArcCW_WAW.Mosin_Eject", t = 1.69 * 1.25},
            {s = "ArcCW_WAW.Mosin_Down", t = 1.71 * 1.25},
        },
    },

    ["idle_snipe"] = {
        Source = "idle_snipe",
        Time = 1 / 30,
    },
    ["draw_snipe"] = {
        Source = "draw_snipe",
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["holster_snipe"] = {
        Source = "holster_snipe",
        Time = 0.5,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["ready_snipe"] = {
        Source = "first_draw_snipe",
        Time = 45 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["fire_snipe"] = {
        Source = {"fire_snipe"},
        Time = 7 / 30,
        {s = "ArcCW_WAW.Mosin_Mech", t = 1 / 30},
    },
    ["cycle_snipe"] = {
        Source = {"cycle_snipe"},
        Time = 30 / 30,
        ShellEjectAt = 10 / 30,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Up", t = 5 / 30},
            {s = "ArcCW_WAW.Mosin_Back", t = 10 / 30},
            {s = "ArcCW_WAW.Mosin_Fwd", t = 20 / 30},
            {s = "ArcCW_WAW.Mosin_Down", t = 25 / 30},
        },
    },
    ["fire_iron_snipe"] = {
        Source = {"fire_snipe"},
        Time = 7 / 30,
        {s = "ArcCW_WAW.Mosin_Mech", t = 1 / 30},
    },
    ["cycle_iron_snipe"] = {
        Source = {"cycle_snipe"},
        Time = 25 / 30,
        ShellEjectAt = 3 / 30,
    },
    ["sgreload_start"] = {
        Source = "reload_in",
        Time = 60 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        RestoreAmmo = 1, -- loads a shell since the first reload has a shell in animation
        MinProgress = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Up", t = 5 / 30},
            {s = "ArcCW_WAW.Mosin_Back", t = 10 / 30},
            {s = "ArcCW_WAW.Mosin_Bullet", t = 27 / 30},
        },
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        Time = 26 / 40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
        MinProgress = 3 / 30,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Bullet", t = 3 / 30},
        }
    },
    ["sgreload_finish"] = {
        Source = "reload_out",
        Time = 26 / 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Fwd", t = 5 / 30},
            {s = "ArcCW_WAW.Mosin_Down", t = 10 / 30},
        },
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_out",
        Time = 26 / 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
        SoundTable = {
            {s = "ArcCW_WAW.Mosin_Fwd", t = 5 / 30},
            {s = "ArcCW_WAW.Mosin_Down", t = 10 / 30},
        },
    },

    ["bash"] = {
        Source = "stab",
        Time = 30 / 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
    },
    ["bash_bayo"] = {
        Source = "stab",
        Time = 30 / 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 4,
    },

    -- M7 GRENADE LAUNCHER --
    ["idle_ubgl"] = {
        Source = "idle_glsetup",
        Time = 1 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["idle_ubgl_empty"] = {
        Source = "idle_glsetup_empty",
        Time = 1 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["enter_ubgl"] = {
        Source = "glsetup_in",
        Time = 80 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
        SoundTable = {
            {s = "ArcCW_WAW.RGren_Futz", t = 34 / 30},
            {s = "ArcCW_WAW.RGren_Load", t = 40 / 30},
            {s = "ArcCW_WAW.RGren_Click", t = 41 / 30},
        }
    },
    ["exit_ubgl"] = {
        Source = "glsetup_out",
        Time = 90 / 40,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
        SoundTable = {
            {s = "ArcCW_WAW.RGren_Click", t = 24 / 40},
            {s = "ArcCW_WAW.RGren_Remove", t = 36 / 40},
            {s = "ArcCW_WAW.RGren_Futz", t = 38 / 40},
        }
    },
    ["enter_ubgl_empty"] = {
        Source = "glsetup_in_empty",
        Time = 19 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["exit_ubgl_empty"] = {
        Source = "glsetup_out_empty",
        Time = 10 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["fire_ubgl"] = {
        Source = "fire_glsetup",
        Time = 7 / 30,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER,
        TPAnimStartTime = 0,
    },
    ["reload_ubgl"] = {
        Source = "reload_glsetup",
        Time = 64 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.1,
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
        SoundTable = {
            {s = "ArcCW_WAW.RGren_Futz", t = 16 / 30},
            {s = "ArcCW_WAW.RGren_Load", t = 19 / 30},
            {s = "ArcCW_WAW.RGren_Click", t = 24 / 30},
        }
    },
    ["reload_ubgl_soh"] = {
        Source = "reload_glsetup",
        Time = 64 / 60,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.1,
        LHIK = true,
        LHIKIn = 0.125,
        LHIKOut = 0.125,
        SoundTable = {
            {s = "ArcCW_WAW.RGren_Futz", t = 16 / 60},
            {s = "ArcCW_WAW.RGren_Load", t = 19 / 60},
            {s = "ArcCW_WAW.RGren_Click", t = 24 / 60},
        }
    },
}

sound.Add( {
    name = "ArcCW_WAW.Mosin_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/mono_00.wav",
        "^weapons/arccw/waw_mosin/mono_01.wav",
        "^weapons/arccw/waw_mosin/mono_02.wav",
        "^weapons/arccw/waw_mosin/mono_03.wav",
    }
} )
sound.Add( {
name = "ArcCW_WAW.Mosin_Ringoff",
channel = CHAN_WEAPON,
volume = 1.0,
level = 100,
sound = {
    "^weapons/arccw/waw_mosin/ringoff.wav",
}
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Mech",
    channel = CHAN_USER_BASE + 6,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/mech.wav",
    }
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Up",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/up.wav",
    }
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Back",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/back.wav",
    }
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Fwd",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/fwd.wav",
    }
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Rechamber",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/rechamber.wav",
    }
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Eject",
    channel = CHAN_USER_BASE + 1,
    volume = 0.5,
    level = 20,
    sound = {
        "^weapons/arccw/waw_mosin/eject.wav",
    }
} )
sound.Add( {
    name = "ArcCW_WAW.Mosin_Bullet",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 100,
    sound = {
        "^weapons/arccw/waw_mosin/bullet.wav",
    }
} )

