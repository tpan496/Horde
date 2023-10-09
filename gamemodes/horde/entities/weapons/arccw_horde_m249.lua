if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m249para")
    killicon.Add("arccw_horde_m249", "arccw/weaponicons/arccw_go_m249para", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M249 SAW"
SWEP.Trivia_Class = "Squad Assault Weapon"
SWEP.Trivia_Desc = "US main light machine gun used by the Army and Marine Corps for laying down suppressive fire."
SWEP.Trivia_Manufacturer = "FN USA"
SWEP.Trivia_Calibre = "5.56x45mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated Rotating Bolt"
SWEP.Trivia_Country = "Belgium"
SWEP.Trivia_Year = 1976

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_mach_m249para.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000000"

SWEP.Damage = 35
SWEP.DamageMin = 25 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 15
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 650

SWEP.Recoil = 0.245
SWEP.RecoilSide = 0.245
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 5

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 20

SWEP.AccuracyMOA = 7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 450 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "m249" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/m249/m249-1.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "arccw_go/m249/m249-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_minimi"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.425
SWEP.ShootSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-7.835, -8.573, 1.62),
    Ang = Angle(-0.5, -0.36, -1.5),
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
    ["rs_none"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["foregrip"] = {
        VMBodygroups = {{ind = 4, bg = 2}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_m249_bipod"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["go_m249_barrel_short"] = {
        VMBodygroups = {
        {ind = 1, bg = 1},
        {ind = 2, bg = 1}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -4.4, 23.5)},
        }
    },
    ["go_m249_barrel_long"] = {
        VMBodygroups = {
        {ind = 1, bg = 2},
        {ind = 2, bg = 2}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -4.4, 34.5)},
        }
    },
    ["go_m249_mag_9_200"] = {
        NameChange = "SMG-249/9",
        VMBodygroups = {
            {ind = 0, bg = 1},
            {ind = 3, bg = 1},
            {ind = 6, bg = 2}
        },
    },
    ["go_m249_mag_12g_45"] = {
        NameChange = "Minimi-12",
        VMBodygroups = {
            {ind = 0, bg = 2},
            {ind = 3, bg = 2},
            {ind = 6, bg = 3}
        },
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 8, bg = 1}
        },
    },
    ["go_stock"] = {
        VMBodygroups = {{ind = 8, bg = 1}},
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.m249_parent",
                Offset = {
                    pos = Vector(0, -4, -3),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-19, 8, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic",
        Bone = "v_weapon.topHinge",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.04, -0.4, -5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1.1, 1.1, 1.1),
        InstalledEles = {"rs_none"},
        CorrectiveAng = Angle(1, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "m249_bipod"},
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(0, -1.15, 15),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(1.15, -4.3, 15.75),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_m249_barrel",
        DefaultAttName = "460mm SAW Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(0, -4.4, 30),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_m249_mag",
        DefaultAttName = "100-Round 5.56mm Belt"
    },
    {
        PrintName = "Stock",
        Slot = {"go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.m249_Parent",
        Offset = {
            vpos = Vector(0, -4, -3),
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
        Bone = "v_weapon.m249_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -3.25, 4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.Jamming = nil
SWEP.HeatCapacity = 50
SWEP.HeatDissipation = 50
SWEP.HeatLockout = true
SWEP.HeatDelayTime = 1

SWEP.BulletBones = {
    [1] = "v_weapon.bullet12",
    [2] = "v_weapon.bullet11",
    [3] = "v_weapon.bullet10",
    [4] = "v_weapon.bullet09",
    [5] = "v_weapon.bullet08",
    [6] = "v_weapon.bullet07",
    [7] = "v_weapon.bullet06",
    [8] = "v_weapon.bullet05",
    [9] = "v_weapon.bullet04",
    [10] = "v_weapon.bullet03",
    [11] = "v_weapon.bullet02",
    [12] = "v_weapon.bullet01",
}

SWEP.CaseBones = {}

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
    },
    ["ready"] = {
        Source = "ready",
    },
    ["fix"] = {
        Source = "fix",
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
        LastClip1OutTime = 2,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
        LastClip1OutTime = 2,
    },
}

sound.Add({
    name = "ARCCW_GO_M249.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_M249.Coverup",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_coverup.wav"
})

sound.Add({
    name = "ARCCW_GO_M249.Coverdown",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_coverdown.wav"
})

sound.Add({
    name = "ARCCW_GO_M249.Boxout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_boxout.wav"
})

sound.Add({
    name = "ARCCW_GO_M249.Boxin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_boxin.wav"
})

sound.Add({
    name = "ARCCW_GO_M249.Pump",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_pump.wav"
})

sound.Add({
    name = "ARCCW_GO_M249.Chain",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/m249/m249_chain.wav"
})