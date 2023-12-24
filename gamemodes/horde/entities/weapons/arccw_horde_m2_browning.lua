if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_fes_m2")
    killicon.Add("arccw_horde_m2_browning", "arccw/weaponicons/arccw_fes_m2", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false
SWEP.PrintName = "M2 Browning"
SWEP.TrueName = "M2 Browning"
SWEP.Trivia_Class = "Heavy Machine Gun"
SWEP.Trivia_Desc = "High-caliber heavy machine gun firing .50 BMG cartridges. Although it is used primarily as a vehicle weapon or as aircraft armament, you decided to be an absolute badass and carry it with two hands."
SWEP.Trivia_Manufacturer = "Gryphon Arms"
SWEP.Trivia_Calibre = ".50 BMG"
SWEP.Trivia_Mechanism = "Short Recoil-Operated"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1957

SWEP.Slot = 2

SWEP.UseHands = true
SWEP.ViewModel = "models/horde/weapons/arccw/c_50cal_10.mdl"
SWEP.WorldModel = "models/horde/weapons/arccw/w_50cal_12.mdl"
SWEP.ViewModelFOV = 60
SWEP.DefaultBodygroups = "0000000"

SWEP.Damage = 100
SWEP.DamageMin = 80 -- damage done at maximum range
SWEP.Range = 500 -- in METRES
SWEP.Penetration = 50
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 890 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3
SWEP.ChamberSize = 0 -- how many rounds can be chambered.

SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 150
SWEP.ReducedClipSize = 50

SWEP.Recoil = 0.7
SWEP.RecoilSide = 0.7
SWEP.MaxRecoilBlowback = 0.7
SWEP.RecoilPunch = 0

SWEP.Delay = 0.12 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.

SWEP.Firemodes = {
    {
        Mode = 2
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_ar2", "weapon_shotgun"}
SWEP.NPCWeight = 50

SWEP.AccuracyMOA = 4 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 600 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "AlyxGun"
SWEP.MagID = "m2" -- the magazine pool this gun draws from
SWEP.ShootVol = 145 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound
SWEP.ShootSound = "weapons/arccw/50cal/50cal_fire.wav"
SWEP.ShootSoundSilenced = "arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "weapons/arccw/50cal/50cal_fire_trail.wav"

SWEP.MuzzleEffect = "muzzleflash_5"

SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellPitch = 60
SWEP.ShellScale = 2

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.SpeedMult = 0.7
SWEP.ShootSpeedMult = 0.6
SWEP.SightedSpeedMult = 0.3
SWEP.SightTime = 0.55

SWEP.IronSightStruct = {
    Pos = Vector(-5.902, -10.653, 4.796),
    Ang = Angle(-1.114, 0, 3.075),
    Magnification = 1.1,
    SwitchToSound = "" -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "crossbow"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 2, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(18, -10, 0)
SWEP.CustomizeAng = Angle(15, 40, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 34

SWEP.ExtraSightDist = 8

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic", "optic_sniper", "optic_lp"}, -- what kind of attachments can fit here, can be string or table
        Bone = "M2.MassiveGun", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, -3.08, -7.7),
            vang = Angle(90, 0, -90),
            wpos = Vector(19.718, -0.589, -4.927),
            wang = Angle(-172.377, -166.458, -19.223)
        },
        SlideAmount = { -- how far this attachment can slide in both directions.
            -- overrides Offset.
            vmin = Vector(0, -3.08, -7.7),
            vmax = Vector(0, -3.08, 5.5),
            wmin = Vector(19.718, -0.589, -4.927),
            wmax = Vector(19.718, -0.589, -4.927),
        },
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(4, 0, 0)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "M2.MassiveGun.Barrel",
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(90, 0, 0),
            wpos = Vector(70.475, -13.466, -10.509),
            wang = Angle(172.377, -194.458, -49.223)
        },
		VMScale = Vector(2.3, 2.3, 2.3),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl", "bipod", "style_pistol"},
        Bone = "M2.Base",
        Offset = {
            vpos = Vector(0, 0.5, 10.394),
            vang = Angle(90, 0, -90),
            wpos = Vector(25.138, -2.809, -1.441),
            wang = Angle(-5.161, 13.355, 166.748)
        },
        SlideAmount = { -- how far this attachment can slide in both directions.
            -- overrides Offset.
            vmin = Vector(0, 0.5, 0.394),
            vmax = Vector(0, 0.5, 10.394),
            wmin = Vector(25.138, -2.809, -1.441),
            wmax = Vector(25.138, -2.809, -1.441),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "M2.Base",
        Offset = {
            vpos = Vector(0, 0, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, 90),
            wpos = Vector(20.25, -1.575, -0.48),
            wang = Angle(-5.161, 13.355, 166.748)
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "so heavy",
        Time = 1
    },
    ["draw"] = {
        Source = "pull out this whore",
        SoundTable = {
            {
                s = "weapons/arccw/m249/m249_draw.wav",
                t = 0
            }
        },
        Time = 0.87,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
    },
    ["ready"] = {
        Source = "meet the whore",
        Time = 1.275,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
    ["fire"] = {
        Source = "cya",
        Time = .64,
        ShellEjectAt = 0
    },
    ["fire_iron"] = {
        Source = "cya zoom",
        Time = .2,
        ShellEjectAt = 0
    },
    ["reload"] = {
        Source = "the answer is the ammunition",
        Mult = 1.3,
        Time = 3.44,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {20, 60, 80, 145, 170},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    }
}


sound.Add({
    name = "Weapon_ARCCW_M2.Charge",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/50cal/50cal_charge.wav"
})

sound.Add({
    name = "Weapon_ARCCW_M2.Lift",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/50cal/50cal_lift.wav"
})

sound.Add({
    name = "Weapon_ARCCW_M2.MagSlap",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/50cal/50cal_magslap.wav"
})

sound.Add({
    name = "Weapon_ARCCW_M2.Magin",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/50cal/50cal_magin.wav"
})

sound.Add({
    name = "Weapon_ARCCW_M2.MagLift",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/50cal/50cal_lift.wav"
})