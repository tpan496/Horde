if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_awp")
    killicon.Add("arccw_horde_awp", "arccw/weaponicons/arccw_go_awp", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = false -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AWSM"
SWEP.Trivia_Class = "Sniper Rifle"
SWEP.Trivia_Desc = "The Arctic Warfare Super Magnum is a cold-weather sniper rifle for police and military using a high-caliber round."
SWEP.Trivia_Manufacturer = "Accuracy International"
SWEP.Trivia_Calibre = ".338 Lapua Magnum"
SWEP.Trivia_Mechanism = "Bolt-Action"
SWEP.Trivia_Country = "United Kingdom"
SWEP.Trivia_Year = 1996

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_snip_awp.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 550
SWEP.DamageMin = 550 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 30
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 1400

SWEP.Recoil = 3.300
SWEP.RecoilSide = 0.550
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.ManualAction = true
SWEP.NoLastCycle = true -- do not cycle on last shot

SWEP.Delay = 60 / 400 -- 60 / RPM.
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
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 0.06 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 800 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "SniperPenetratedRound" -- what ammo type the gun uses
SWEP.MagID = "awp" -- the magazine pool this gun draws from

SWEP.ShootVol = 140 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/awp/awp_01.wav"
SWEP.ShootSoundSilenced = "arccw_go/mosin_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/awp/awp1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_m82"
SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellPitch = 80
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.50
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-4.9109, -8.573, 1.80253),
    Ang = Angle(0.060123, 0.26674, -0.55),
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
    ["tacms"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
        WMBodygroups = {{ind = 7, bg = 1}},
    },
    ["go_awp_barrel_short"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1}
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1}
        },
        AttPosMods = {
            [5] = {vpos = Vector(0, -3.4, 20)}
        }
    },
    ["go_awp_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2}
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2}
        },
        AttPosMods = {
            [5] = {vpos = Vector(0, -3.4, 38)}
        }
    },
    ["go_awp_barrel_bull"] = {
        VMBodygroups = {
            {ind = 1, bg = 3},
            {ind = 2, bg = 3}
        },
        WMBodygroups = {
            {ind = 1, bg = 3},
            {ind = 2, bg = 3}
        },
    },
    ["go_awp_stock_obrez"] = {
        VMBodygroups = {
            {ind = 5, bg = 1}
        },
    },
    ["go_awp_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 5, bg = 2}
        },
        WMBodygroups = {
            {ind = 5, bg = 2}
        }
    },
    ["go_awp_stock_contractor"] = {
        VMBodygroups = {
            {ind = 5, bg = 3}
        },
        WMBodygroups = {
            {ind = 5, bg = 3}
        }
    },
    ["go_awp_mag_5"] = {
        VMBodygroups = {
            {ind = 4, bg = 1}
        },
        WMBodygroups = {
            {ind = 4, bg = 1}
        }
    },
    ["go_awp_mag_15"] = {
        VMBodygroups = {
            {ind = 4, bg = 2}
        },
        WMBodygroups = {
            {ind = 4, bg = 2}
        }
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 5, bg = 1}
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.awp_parent",
                Offset = {
                    pos = Vector(0, -2.25, -1.2),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12, 6, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.awp_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.05, -4.2, 6),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        Installed = "go_optic_awp",
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rs_none"},
        CorrectiveAng = Angle(0.25, 0, 0),
        CorrectivePos = Vector(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.awp_parent",
        Offset = {
            vpos = Vector(0, -1.0, 14),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.awp_parent",
        Offset = {
            vpos = Vector(1.0, -2.85, 17),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_awp_barrel",
        DefaultAttName = "500mm Sniper Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.awp_parent",
        Offset = {
            vpos = Vector(0, -3.4, 28),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_awp_mag",
        DefaultAttName = "10-Round .338 AWM"
    },
    {
        PrintName = "Stock",
        Slot = {"go_stock", "go_awp_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.awp_parent",
        Offset = {
            vpos = Vector(0, -2.25, -1.2),
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
        Bone = "v_weapon.awp_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.75, -2.5, 4), -- offset that the attachment will be relative to the bone
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
        ShellEjectAt = 2.75
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_AWP.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/awp/awp_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_AWP.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/awp/awp_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_AWP.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/awp/awp_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_AWP.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/awp/awp_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_AWP.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/awp/awp_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_AWP.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/awp/awp_boltback.wav"
})

function SWEP:Hook_OnDeploy()
    timer.Simple(0, function ()
        if !IsValid(self) then return end
        self:Attach(1, "go_optic_awp")
    end)
end
