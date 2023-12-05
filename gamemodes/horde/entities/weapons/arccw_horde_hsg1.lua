if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_kf1ksg")
    killicon.Add("arccw_horde_hsg1", "arccw/weaponicons/arccw_kf1ksg", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "HSG-1"
SWEP.TrueName = "KSG"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "A rather powerful pump-action shotgun that reloads with magazines."
SWEP.Trivia_Manufacturer = "Kel-tec"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2011

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_kf_ksg.mdl"
SWEP.WorldModel = "models/weapons/arccw/w_tf2convent.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos        =    Vector(-15, 5, -8),
    ang        =    Angle(-6, -2.5, 180),
    bone    =    "ValveBiped.Bip01_R_Hand",
}
SWEP.ViewModelFOV = 45

SWEP.Damage = 35
SWEP.DamageMin = 20
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 2
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 12 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 14
SWEP.ReducedClipSize = 8

SWEP.Recoil = 3
SWEP.RecoilSide = 3
SWEP.VisualRecoilMult = 3
SWEP.RecoilRise = 3
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 60 -- 60 / RPM.
SWEP.Num = 10 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
		PrintName = "PUMP",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 80 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 100 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "KF_Ksg.Fire"
SWEP.ShootSoundSilenced = "weapons/fesiugmw2/fire/shot_sil.wav"
SWEP.DistantShootSound = "KF_Ksg.Fire"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellScale = 2

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}
SWEP.ManualAction = true

SWEP.IronSightStruct = {
    Pos = Vector(-5, 0, 2),
    Ang = Angle(-0.2, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(-1, -2, 1.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(-2, -7.145, -11.561)
SWEP.HolsterAng = Angle(36.533, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(12, -8, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.AttachmentElements = {

}

SWEP.ExtraSightDist = 8

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Ironsights",
        Slot = "optic",
        Bone = "KSG_Shotgun",
        Offset = {
            vpos = Vector(6, 0, 5.9),
            vang = Angle(0, 0, 0),
            wpos = Vector(10, 0.8, -5.5),
            wang = Angle(-5, 1, 180)
        },
        VMScale = Vector(1.2, 1.2, 1.2),
    },
	{
	PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "Pump",
        Offset = {
            vpos = Vector(0, 0, -0.7),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
        SlideAmount = {
            vmin = Vector(-4, 0, -0.7),
            vmax = Vector(3, 0, -0.7),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "KSG_Shotgun",
        Offset = {
            vpos = Vector(20, 0.1, 4.5),
            vang = Angle(0, 0, 0),
            wpos = Vector(10, 0.8, -5.5),
            wang = Angle(-5, 1, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Pump",
        Offset = {
            vpos = Vector(5, 0, -1),
            vang = Angle(0, 0, 0),
            wpos = Vector(9, 1, -4.5),
            wang = Angle(-5, 1, 180)
        },
        VMScale = Vector(1.2, 1.2, 1.2),
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
	{
        PrintName = "Charms",
        Slot = "charm",
        Bone = "Pump",
        Offset = {
            vpos = Vector(-8, -1.2, 0),
            vang = Angle(0, 0, 0),
            wpos = Vector(7, 2, -4.5),
            wang = Angle(-5, 1, 180)
        },
    }
}

SWEP.Animations = {
    ["idle"] = {
    Source = "idle",
    Time = 10,
    },
    ["enter_sight"] = {
        Source = "idle",
        Time = 0,
        },
    ["idle_sights"] = {
        Source = "idle",
        Time = 0,
        },
        ["exit_sight"] = {
            Source = "idle",
            Time = 0,
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
        Source = "idle",
        Time = 10,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 10,
        ShellEjectAt = 0,
    },
    ["cycle"] = {
        Source = "shoot",
        Time = 1,
        ShellEjectAt = 0,
    },
    ["cycle_iron"] = {
        Source = "shoot",
        Time = 1,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
    },
}

sound.Add({
	name = 			"KF_Ksg.pullforward",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_ksg/KSG_Pullfwd.wav"
})
sound.Add({
	name = 			"KF_Ksg.pullback",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_ksg/KSG_Pullback.wav"
})
sound.Add({
	name = 			"KF_Ksg.magout",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_ksg/KSG_Magout.wav"
})
sound.Add({
	name = 			"KF_Ksg.magin",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_ksg/KSG_Magin.wav"
})
sound.Add({
	name = 			"KF_Ksg.Fire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			{ "weapons/kf_ksg/KSG_Fire_S.wav"}
})