if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_scar")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_scarh", "arccw/weaponicons/arccw_go_scar", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SCAR-H"
SWEP.Trivia_Class = "Battle Rifle"
SWEP.Trivia_Desc = "High-class battle rifle designed to serve the needs of special forces in modern warfare."
SWEP.Trivia_Manufacturer = "Fabrique National Herstale"
SWEP.Trivia_Calibre = "7.62x51mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated Rotating Bolt"
SWEP.Trivia_Country = "Belgium"
SWEP.Trivia_Year = 2009

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_scar.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_scar.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000000"

SWEP.Damage = 74
SWEP.DamageMin = 60 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 23
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 700

SWEP.Recoil = 0.670
SWEP.RecoilSide = 0.345
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0.2

SWEP.Delay = 60 / 650 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 1.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 285 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/scar20/scar20_01.wav"
SWEP.ShootSound = "arccw_go/scar20/scar20_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/scar20/scar20_distant_01.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_3"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 85
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.96
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.2

SWEP.IronSightStruct = {
    Pos = Vector(-5.1, -8.573, 0.8),
    Ang = Angle(-0.4, 0.825, -1.951),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

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

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    local fs = false
    local barrel = 0

    for i, k in pairs(eles or {}) do
        if k == "go_scar_barrel_stub" then
            barrel = 2
        elseif k == "go_scar_barrel_long" then
            barrel = 1
        elseif k == "fs_down" then
            fs = true
        end
    end

    local i = 0

    if fs then
        i = (barrel * 2) + 1
    else
        i = (barrel * 2)
    end

    vm:SetBodygroup(3, i)
end

SWEP.AttachmentElements = {
    ["fs_down"] = {},
    ["rs_down"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 4}},
        WMBodygroups = {{ind = 2, bg = 4}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 6, bg = 1},
        },
        WMBodygroups = {
            {ind = 6, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 6, bg = 5},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.SCAR_Parent",
                Offset = {
                    pos = Vector(0, -4.5, -3.5),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_scar_stock_sniper"] = {
         VMBodygroups = {
            {ind = 6, bg = 2},
        },
        WMBodygroups = {
            {ind = 6, bg = 2},
        },
    },
    ["go_scar_stock_basilisk"] = {
         VMBodygroups = {
            {ind = 6, bg = 3},
        },
        WMBodygroups = {
            {ind = 6, bg = 3},
        },
    },
    ["go_scar_stock_contractor"] = {
         VMBodygroups = {
            {ind = 6, bg = 4},
        },
        WMBodygroups = {
            {ind = 6, bg = 4},
        },
    },
    ["go_scar_barrel_stub"] = {
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
                vpos = Vector(0, -4.5, 11),
            },
            [2] = {
                vpos = Vector(0, -3.5, 8),
            }
        }
    },
    ["go_scar_barrel_short"] = {
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
                vpos = Vector(0, -4.5, 15),
            },
        }
    },
    ["go_scar_barrel_long"] = {
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
                vpos = Vector(0, -4.5, 25),
            }
        }
    },
    ["go_scar_mag_10"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_scar_mag_30"] = {
        VMBodygroups = {
            {ind = 5, bg = 2},
        },
        WMBodygroups = {
            {ind = 5, bg = 2},
        },
    },
    ["go_scar_mag_20_556"] = {
        NameChange = "SCAR-L",
        VMBodygroups = {
            {ind = 5, bg = 3},
            {ind = 0, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 3},
            {ind = 0, bg = 1},
        },
    },
    ["go_scar_mag_30_556"] = {
        NameChange = "SCAR-L",
        VMBodygroups = {
            {ind = 5, bg = 4},
            {ind = 0, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 4},
            {ind = 0, bg = 1},
        },
    },
    ["go_scar_mag_60_556"] = {
        NameChange = "SCAR-L",
        VMBodygroups = {
            {ind = 5, bg = 5},
            {ind = 0, bg = 1},
        },
        WMBodygroups = {
            {ind = 5, bg = 5},
            {ind = 0, bg = 1},
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-13, 5.5, -6),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.SCAR_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -6.4, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rs_down", "fs_down"},
        CorrectiveAng = Angle(1, 0, 0),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.SCAR_Parent",
        Offset = {
            vpos = Vector(0, -3.5, 10),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.SCAR_Parent",
        Offset = {
            vpos = Vector(-0.5, -4.75, 10),
            vang = Angle(90, -1, 180),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_scar_barrel",
        DefaultAttName = "450mm STD Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.SCAR_Parent",
        Offset = {
            vpos = Vector(0, -4.5, 20),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"fh_none"},
        ExcludeFlags = {"go_g3_barrel_sd"}
    },
    {
        PrintName = "Magazine",
        Slot = "go_scar_mag",
        DefaultAttName = "20-Round 7.62mm SCAR"
    },
    {
        PrintName = "Stock",
        Slot = {"go_scar_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.SCAR_Parent",
        Offset = {
            vpos = Vector(0, -4.5, -3.5),
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
        Slot = "go_perk",
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.SCAR_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, -4.75, 3), -- offset that the attachment will be relative to the bone
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
    ["idle_empty"] = {
        Source = "idle_empty"
    },
    ["enter_sight_empty"] = {
        Source = "idle_empty"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["draw_empty"] = {
        Source = "draw_empty",
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
    ["fire_empty"] = {
        Source = "shoot_empty",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_iron_empty",
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
        LHIKEaseOut = 0.35
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.35
    },
    ["reload_longmag"] = {
        Source = "reload_longmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
        LHIKEaseOut = 0.35
    },
    ["reload_longmag_empty"] = {
        Source = "reload_longmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.35
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_SCAR.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/scar20/scar20_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_SCAR.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/scar20/scar20_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_SCAR.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/scar20/scar20_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_SCAR.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/scar20/scar20_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_SCAR.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/scar20/scar20_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_SCAR.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/scar20/scar20_boltback.wav"
})