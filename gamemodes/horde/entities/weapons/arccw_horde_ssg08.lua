if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_ssg08")
    killicon.Add("arccw_horde_ssg08", "arccw/weaponicons/arccw_go_ssg08", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SSG08"
SWEP.Trivia_Class = "Sniper Rifle"
SWEP.Trivia_Desc = "Precision sniper rifle for police and military use, also popular among civilian hunters."
SWEP.Trivia_Manufacturer = "Steyr Mannlicher"
SWEP.Trivia_Calibre = ".308 Winchester"
SWEP.Trivia_Mechanism = "Bolt-Action"
SWEP.Trivia_Country = "Austria"
SWEP.Trivia_Year = 2008

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_snip_ssg08.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_snip_ssg08.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "011000000000"
SWEP.DefaultWMBodygroup = "011000000000"

SWEP.Damage = 300
SWEP.DamageMin = 300 -- damage done at maximum range
SWEP.Range = 20 -- in METRES
SWEP.Penetration = 29
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 1400

SWEP.Recoil = 1.500
SWEP.RecoilSide = 0.550
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.ManualAction = true
SWEP.NoLastCycle = true -- do not cycle on last shot

SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "FIRE"
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_crossbow"
SWEP.NPCWeight = 150

SWEP.AccuracyMOA = 0.1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "SniperPenetratedRound" -- what ammo type the gun uses
SWEP.MagID = "ssg08" -- the magazine pool this gun draws from

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/ssg08/ssg08_01.wav"
SWEP.ShootSoundSilenced = "arccw_go/mosin_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/awp/awp1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 85
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.9
SWEP.SightTime = 0.2

SWEP.IronSightStruct = {
    Pos = Vector(-5.65, -8.573, 1.65),
    Ang = Angle(0, 0.2, -0.55),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW

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
    ["rs_none"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
        WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        WMBodygroups = {{ind = 2, bg = 3}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
        WMBodygroups = {{ind = 6, bg = 1}},
    },
    ["go_ssg08_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 0},
            {ind = 2, bg = 0}
        },
        WMBodygroups = {
            {ind = 1, bg = 0},
            {ind = 2, bg = 0}
        },
        AttPosMods = {
            [5] = {vpos = Vector(0.2, -2.2, 23)}
        }
    },
    ["go_ssg08_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2}
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2}
        },
        AttPosMods = {
            [5] = {vpos = Vector(0.2, -2.3, 32)}
        }
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 5, bg = 1}
        },
        WMBodygroups = {
            {ind = 5, bg = 1}
        }
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.ssg08_Parent",
                Offset = {
                    pos = Vector(0.5, 0, -2.75),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_ssg08_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 5, bg = 2}
        },
        WMBodygroups = {
            {ind = 5, bg = 2}
        }
    },
    ["go_ssg08_stock_contractor"] = {
        VMBodygroups = {
            {ind = 5, bg = 3}
        },
        WMBodygroups = {
            {ind = 5, bg = 3}
        }
    },
    ["go_ssg08_mag_10"] = {
        VMBodygroups = {
            {ind = 4, bg = 1}
        },
        WMBodygroups = {
            {ind = 4, bg = 1}
        }
    },
    ["go_ssg08_mag_5_338"] = {
        VMBodygroups = {
            {ind = 4, bg = 2}
        },
        WMBodygroups = {
            {ind = 4, bg = 2}
        }
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-11, 6, -6),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.ssg08_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.2, -3.2, 9),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        Installed = "go_optic_schmidt",
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rs_none"},
        CorrectiveAng = Angle(0.25, 0, 0),
        CorrectivePos = Vector(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.ssg08_parent",
        Offset = {
            vpos = Vector(0.2, 0, 17),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.ssg08_parent",
        Offset = {
            vpos = Vector(1.3, -1.45, 15),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_ssg08_barrel",
        DefaultAttName = "500mm Sniper Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.ssg08_parent",
        Offset = {
            vpos = Vector(0.2, -2.3, 27),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_ssg08_mag",
        DefaultAttName = "10-Round .308 SSG"
    },
    {
        PrintName = "Stock",
        Slot = {"go_ssg08_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.ssg08_parent",
        Offset = {
            vpos = Vector(0.5, 0, -2.75),
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
        Bone = "v_weapon.ssg08_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.8, 1.25, 4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
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
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
    },
    ["cycle"] = {
        Source = "cycle",
        ShellEjectAt = 0.25,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_SSG08.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ssg08/ssg08_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_SSG08.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ssg08/ssg08_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_SSG08.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ssg08/ssg08_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_SSG08.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ssg08/ssg08_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_SSG08.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ssg08/ssg08_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_SSG08.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ssg08/ssg08_boltback.wav"
})