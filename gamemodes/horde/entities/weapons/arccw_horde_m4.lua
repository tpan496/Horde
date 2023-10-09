if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m4")
    killicon.Add("arccw_horde_m4", "arccw/weaponicons/arccw_go_m4", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M4A1"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "A popular American assault rifle based on Eugene Stoner's AR-15 system. Well-balanced with good all-round characteristics."
SWEP.Trivia_Manufacturer = "FN USA"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1993

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_m4a1.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "010000100000"

SWEP.Damage = 30 * 1.25
SWEP.DamageMin = 22 * 1.25 -- damage done at maximum range
SWEP.Range = 3000 * 0.025 -- in METRES
SWEP.Penetration = 10
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 900

SWEP.Recoil = 0.325
SWEP.RecoilSide = 0.215
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2

SWEP.Delay = 60 / 725 -- 60 / RPM.
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

SWEP.AccuracyMOA = 4 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/m4a1/m4a1_03.wav"
SWEP.ShootSound = "arccw_go/m4a1/m4a1_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/m4a1/m4a1-1-distant.wav"

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

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-5.223, -8.573, 0.707),
    Ang = Angle(0.143, -0.267, -1.951),
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
    ["rs_closed"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["rs_low"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        WMBodygroups = {{ind = 1, bg = 2}},
    },
    ["rs_none"] = {
        VMBodygroups = {{ind = 1, bg = 3}},
        WMBodygroups = {{ind = 1, bg = 3}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 6, bg = 0}},
        WMBodygroups = {{ind = 6, bg = 0}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["go_m4_stock_m16"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
    },
    ["go_m4_stock_ergo"] = {
        VMBodygroups = {
            {ind = 4, bg = 3},
        },
        WMBodygroups = {
            {ind = 4, bg = 3},
        },
    },
    ["go_m4_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 4, bg = 4},
        },
        WMBodygroups = {
            {ind = 4, bg = 4},
        },
    },
    ["go_m4_barrel_stub"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
            {ind = 6, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
            {ind = 6, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.05, 8.5),
            }
        }
    },
    ["go_m4_barrel_short"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
            {ind = 6, bg = 3},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
            {ind = 6, bg = 3},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.05, 15),
            }
        }
    },
    ["go_m4_barrel_med"] = {
        VMBodygroups = {
            {ind = 3, bg = 3},
            {ind = 6, bg = 4},
        },
        WMBodygroups = {
            {ind = 3, bg = 3},
            {ind = 6, bg = 4},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.06, 21),
            }
        }
    },
    ["go_m4_barrel_long"] = {
        VMBodygroups = {
            {ind = 3, bg = 4},
            {ind = 6, bg = 5},
        },
        WMBodygroups = {
            {ind = 3, bg = 4},
            {ind = 6, bg = 5}
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -5.06, 23.5),
            }
        }
    },
    ["go_m4_barrel_sd"] = {
        VMBodygroups = {
            {ind = 3, bg = 5},
            {ind = 6, bg = 6},
        },
    },
    ["go_m4_mag_10_50"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["go_m4_mag_20"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
        WMBodygroups = {
            {ind = 2, bg = 2},
        },
    },
    ["go_m4_mag_30_9mm"] = {
        NameChange = "R0991",
        VMBodygroups = {
            {ind = 2, bg = 3},
        },
        WMBodygroups = {
            {ind = 2, bg = 3},
        },
    },
    ["go_m4_mag_21_9mm"] = {
        NameChange = "R0991",
        VMBodygroups = {
            {ind = 2, bg = 5},
        },
        WMBodygroups = {
            {ind = 2, bg = 5},
        },
    },
    ["go_556_ammo_60round"] = {
        VMBodygroups = {
            {ind = 2, bg = 4},
        },
        WMBodygroups = {
            {ind = 2, bg = 4},
        },
    }
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-11, 5.5, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

-- calculates which front sight we should see
SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    local barrel = 0
    local lp = false

    for i, k in pairs(eles or {}) do
        if k == "go_m4_barrel_stub" then
            barrel = 1
        elseif k == "go_m4_barrel_short" then
            barrel = 2
        elseif k == "go_m4_barrel_med" then
            barrel = 3
        elseif k == "go_m4_barrel_long" then
            barrel = 4
        elseif k == "go_m4_barrel_sd" then
            barrel = 5
        elseif k == "rs_none" then
            lp = true
        end
    end

    local fs = barrel * 2
    if lp then
        fs = fs + 1
    end

    vm:SetBodygroup(5, fs)
end

SWEP.RejectAttachments = {
    ["go_stock_contractor"] = true
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.M4A1_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -6.3, 2),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1.1, 1.1, 1.1),
        InstalledEles = {"rs_none"},
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -4, 9),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(-1.15, -5, 10),
            vang = Angle(90, 0, 180),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        ExcludeFlags = {"go_m4_barrel_stub"}
    },
    {
        PrintName = "Barrel",
        Slot = "go_m4_barrel",
        DefaultAttName = "260mm CQBR Barrel",
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -5.05, 18.25),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
        ExcludeFlags = {"go_m4_barrel_sd"}
    },
    {
        PrintName = "Magazine",
        Slot = {"go_m4_mag", "go_ammo_556_60"},
        DefaultAttName = "30-Round 5.56mm USGI"
    },
    {
        PrintName = "Stock",
        Slot = {"go_m4_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.M4A1_Parent",
        Offset = {
            vpos = Vector(0, -5, -3),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1, 1, 1)
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
        Bone = "v_weapon.M4A1_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -3.25, 4), -- offset that the attachment will be relative to the bone
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
        Source = {"shoot1", "shoot2", "shoot3"},
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
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
        LHIKEaseOut = 0.6
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.6
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
        LHIKEaseOut = 0.6
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LHIKEaseOut = 0.6
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_M4A1.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_cliphit.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_M4A1.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m4a1/m4a1_boltback.wav"
})