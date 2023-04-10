if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = Material("items/hl2/weapon_shotgun.png")
    killicon.AddAlias("arccw_horde_shotgun", "weapon_shotgun")
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Arccw - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Pump-Action"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "A standard 12-gauge shotgun."
SWEP.Trivia_Manufacturer = "Resistance"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "Resistance"
SWEP.Trivia_Year = 2007

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModelOffset = {
    pos = Vector(-20, 10, -10),
    ang = Angle(0, 0, 180),
    scale = 1
}

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 8
SWEP.DamageMin = 4 -- damage done at maximum range
SWEP.Num = 6
SWEP.Range = 31 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 350

SWEP.Recoil = 3
SWEP.RecoilSide = 3
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2

SWEP.ManualAction = true
SWEP.ShotgunReload = true
SWEP.Delay = 300 / 300 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "PUMP"
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 45 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 75 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = {"weapons/shotgun/shotgun_fire6.wav", "weapons/shotgun/shotgun_fire7.wav"}
SWEP.ShootSoundSilenced = "arccw_go/m590_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/sawedoff/sawedoff-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-9, -5, 4.3),
    Ang = Angle(0, 0.05, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.Holdtype = "shotgun"
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "shotgun"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Buckshot Shells"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle01",
    },
    ["draw"] = {
        Source = "draw",
        FrameRate = 30,
    },
    ["fire"] = {
        Source = "fire",
        Time = 1,
    },
    ["cycle"] = {
        Source = "pump",
        Time = 0.5,
    },
    ["sgreload_start"] = {
        Source = "reload1",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "reload2",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        SoundTable = {
            {s = {"weapons/shotgun/shotgun_reload1.wav", "weapons/shotgun/shotgun_reload2.wav", "weapons/shotgun/shotgun_reload3.wav"}, t = 0},
        },
        Time = 0.5,
    },
    ["sgreload_finish"] = {
        Source = "reload3",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
        SoundTable = {
            {s = "weapons/shotgun/shotgun_cock.wav", t = 0},
        },
    },
    ["sgreload_finish_empty"] = {
        Source = "reload3",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
    },
}

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIcon)

    surface.DrawTexturedRect(x, y, w, w / 2)
end