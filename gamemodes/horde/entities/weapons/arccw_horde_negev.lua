if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_negev")
    killicon.Add("arccw_horde_negev", "arccw/weaponicons/arccw_go_negev", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Negev"
SWEP.Trivia_Class = "Squad Assault Weapon"
SWEP.Trivia_Desc = "7.62mm light machine gun based on the IWI Negev. Capable of laying down heavy fire over long range."
SWEP.Trivia_Manufacturer = "Israeli Weapons Industries"
SWEP.Trivia_Calibre = "7.62x51mm NATO"
SWEP.Trivia_Mechanism = "Gas-Operated Rotating Bolt"
SWEP.Trivia_Country = "Israel"
SWEP.Trivia_Year = 2012

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_mach_negev.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_mach_negev.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "0000000000"

SWEP.Damage = 45
SWEP.DamageMin = 25 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 22
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 75 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 925

SWEP.Recoil = 0.375
SWEP.RecoilSide = 0.375
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 5

SWEP.Delay = 60 / 625 -- 60 / RPM.
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
SWEP.NPCWeight = 15

SWEP.AccuracyMOA = 8 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 650 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "negev" -- the magazine pool this gun draws from

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/negev/negev_04.wav"
SWEP.ShootSoundSilenced = "arccw_go/mosin_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/negev/negev-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/negev/negev_draw.wav"
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

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.425
SWEP.ShootSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-7.87, -8.573, 2.25),
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

SWEP.CustomizePos = Vector(12, -4, 1)
SWEP.CustomizeAng = Angle(5, 40, 15)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["rs_none"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 8, bg = 1}},
    },
    ["fh_none"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_negev_belt_100"] = {
        VMBodygroups = {
            {ind = 0, bg = 1},
            {ind = 4, bg = 1},
            {ind = 3, bg = 1}
        },
    },
    ["go_negev_barrel_short"] = {
        VMBodygroups = {
        {ind = 1, bg = 1},
        {ind = 2, bg = 1}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -5.1, 19)},
        }
    },
    ["go_negev_barrel_long"] = {
        VMBodygroups = {
        {ind = 1, bg = 2},
        {ind = 2, bg = 2}},
        AttPosMods = {
            [5] = {vpos = Vector(0, -5.1, 29.5)},
        }
    },
    ["go_negev_stock_in"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {{ind = 7, bg = 2}},
    },
    ["go_stock"] = {
        VMBodygroups = {{ind = 7, bg = 2}},
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.negev_Parent",
                Offset = {
                    pos = Vector(0, -4.5, -3.5),
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
        Bone = "v_weapon.negev_Parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.04, -6.2, 1),
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
        Slot = "foregrip",
        Bone = "v_weapon.negev_Parent",
        Offset = {
            vpos = Vector(0, -2.75, 15),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.negev_Parent",
        Offset = {
            vpos = Vector(1.3, -4.65, 12.5),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_negev_barrel",
        DefaultAttName = "460mm SAW Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.negev_Parent",
        Offset = {
            vpos = Vector(0, -5.1, 24),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"fh_none"},
    },
    {
        PrintName = "Belt",
        Slot = "go_negev_belt",
        DefaultAttName = "75-Round NG-7 Belt"
    },
    {
        PrintName = "Stock",
        Slot = {"go_stock_none", "go_stock", "go_negev_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.negev_Parent",
        Offset = {
            vpos = Vector(0, -4.5, -3),
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
        Bone = "v_weapon.negev_Parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.85, -4, 2), -- offset that the attachment will be relative to the bone
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
    [1] = "v_weapon.bullet_18",
    [2] = "v_weapon.bullet_16",
    [3] = "v_weapon.bullet_14",
    [4] = "v_weapon.bullet_12",
    [5] = "v_weapon.bullet_10",
    [6] = "v_weapon.bullet_08",
    [7] = "v_weapon.bullet_06",
    [8] = "v_weapon.bullet_04",
    [9] = "v_weapon.bullet_02",
    [10] = "v_weapon.bullet_00",
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
    name = "ARCCW_GO_Negev.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_Negev.Coverup",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_coverup.wav"
})

sound.Add({
    name = "ARCCW_GO_Negev.Coverdown",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_coverdown.wav"
})

sound.Add({
    name = "ARCCW_GO_Negev.Boxout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_boxout.wav"
})

sound.Add({
    name = "ARCCW_GO_Negev.Boxin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_boxin.wav"
})

sound.Add({
    name = "ARCCW_GO_Negev.Pump",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_pump.wav"
})

sound.Add({
    name = "ARCCW_GO_Negev.Chain",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/negev/negev_chain.wav"
})