if not ArcCWInstalled then return end
SWEP.Base = "arccw_horde_gl_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M32"
SWEP.Trivia_Class = "Grenade Launcher"
SWEP.Trivia_Desc = "A six chambered revolving grenade launcher."
SWEP.Trivia_Manufacturer = "Milkor"
SWEP.Trivia_Calibre = "40mm"
SWEP.Trivia_Mechanism = "Double-action"
SWEP.Trivia_Country = "South Africa"
SWEP.Trivia_Year = 1983

SWEP.Slot = 3

SWEP.Spawnable = true


SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_m32.mdl"
SWEP.WorldModel = "models/horde/weapons/w_m79.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-5, 5, 15),
    ang = Angle(-90, 10, 180),
}
SWEP.ViewModelFOV = 60

SWEP.Damage = 35
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = "horde_projectile_he_round" -- entity to fire, if any
SWEP.MuzzleVelocity = 100000 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false
SWEP.ShotgunReload = true

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 6
SWEP.ReducedClipSize = 6

SWEP.Recoil = 2
SWEP.RecoilSide = 1
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 2

SWEP.Delay = 60 / 240 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "SMG1_Grenade" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "KF_m32.Fire"
SWEP.ShootSoundSilenced = nil
SWEP.DistantShootSound = nil

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 0.90
SWEP.SightedSpeedMult = 0.65
SWEP.SightTime = 0.2

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5, -2, 2.5),
    Ang = Angle(-1.201, 0, 0),
    ViewModelFOV = 65 / 2,
    Magnification = 2,
}

SWEP.HoldtypeHolstered = "ar2"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(-1, -2, 1.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(-2, -7.145, -11.561)
SWEP.HolsterAng = Angle(36.533, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(12, -8, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.SprintPos = Vector(5, 0, 0)
SWEP.SprintAng = Angle(0, 25, 0)

SWEP.AttachmentElements = {

}

SWEP.ExtraSightDist = 5

SWEP.RejectAttachments = {["go_homemade_auto"] = true, ["go_perk_burst"] = true}
SWEP.Attachments = {
    {
        PrintName = "Charms",
        Slot = "charm",
        Bone = "Lower_Receiver",
        Offset = {
            vpos = Vector(4, -0.5, 6),
            vang = Angle(0, 0, 0),
            wpos = Vector(7, 2, -4.5),
            wang = Angle(-5, 1, 180)
        },
    },
    {
        PrintName = "Ammo",
        Slot = "horde_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
}

SWEP.Animations = {
    ["idle"] = {
    Source = "idle",
    Time = 10,
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.5,
        SoundTable = {
            {
            s = "weapons/arccw/draw_secondary.wav",
            t = 0
            }
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.9,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.7,
        ShellEjectAt = 0,
    },
    ["sgreload_start"] = {
        Source = "start_reload",
        Time = 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        Time = 0.75,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "reload_end",
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
}

sound.Add({
	name = 			"KF_m32_open",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/gl/M32_Reload_000.mp3"
})
sound.Add({
	name = 			"KF_m32_close",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/gl/M32_Reload_280.mp3"
})
sound.Add({
	name = 			"KF_m32_insert",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 		"horde/weapons/gl/M32_Reload_049.mp3"
})
sound.Add({
	name = 			"KF_m32.Fire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"horde/weapons/gl/fire.mp3"
})