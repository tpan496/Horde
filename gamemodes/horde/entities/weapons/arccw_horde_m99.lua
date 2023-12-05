if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_kf1m99")
    killicon.Add("arccw_horde_m99", "arccw/weaponicons/arccw_kf1m99", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde (Custom)" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Barrett M99"
SWEP.TrueName = "Barrett M99"
SWEP.Trivia_Class = "Anti-Material Rifle"
SWEP.Trivia_Desc = "The M99 is an Anti-Material Sniper rifle that can destroy anything in its path."
SWEP.Trivia_Manufacturer = "Barrett FC"
SWEP.Trivia_Calibre = ".50 BMG"
SWEP.Trivia_Mechanism = "Bolt Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1999

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
end

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_kf_m99.mdl"
SWEP.WorldModel = "models/horde/weapons/c_kf_m99.mdl"
SWEP.ViewModelFOV = 45

SWEP.Damage = 1400
SWEP.DamageMin = 1400 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 1000
SWEP.DamageType = DMG_SNIPER
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 5
SWEP.RecoilSide = 5
SWEP.VisualRecoilMult = 5
SWEP.RecoilRise = 5
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 75 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 0.01 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 100 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 800

SWEP.Primary.Ammo = "SniperPenetratedRound" -- what ammo type the gun uses

SWEP.ShootVol = 500 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "KF_m99.Fire"
SWEP.ShootSoundSilenced = "weapons/fesiugmw2/fire/sniper_sil.wav"
SWEP.DistantShootSound = "KF_m99.Fire"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellScale = 5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SightTime = 0.175

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.4

SWEP.BarrelLength = 30
SWEP.Bipod_Integral = true

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5, 0, 2),
    Ang = Angle(-0, 0, 0),
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, -7, 2.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(-2, -7.145, -11.561)
SWEP.HolsterAng = Angle(36.533, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(12, -8, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.AttachmentElements = {

}

SWEP.WorldModelOffset = {
    pos = Vector(0, 5, -8),
    ang = Angle(-10, 0, 180),
    scale = 1
}

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Ironsights",
        Slot = {"optic", "optic_sniper"},
        Bone = "M99_Sniper",
        Offset = {
            vpos = Vector(7, 0.1, 5.9),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.36, 0.539, -7.801),
            wang = Angle(-9.738, 0, 180)
        },
        VMScale = Vector(1.2, 1.2, 1.2),
		Installed = "optic_m82scope",
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "M99_Sniper",
        Offset = {
            vpos = Vector(20, 0, 2),
            vang = Angle(0, 0, 0),
            wpos = Vector(25.625, -0.253, -8.298),
            wang = Angle(-8.829, -0.556, 90)
        },
        VMScale = Vector(1, 1, 1),
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
        Bone = "M99_Sniper",
        Offset = {
            vpos = Vector(8, -1, 4),
            vang = Angle(0, 0, 0),
            wpos = Vector(11, 1.5, -3),
            wang = Angle(-10, 0, 180)
        },
    },
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
    ["reload"] = {
        Source = "reload",
        Mult = 0.75,
        Time = 2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.2,
    },
}

sound.Add({
	name = 			"KF_m99_Boltback",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_BoltBack.wav"
})
sound.Add({
	name = 			"KF_m99_Bullet_Insert",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_Bullet_Insert.wav"
})
sound.Add({
	name = 			"KF_m99_Select",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_Select.wav"
})
sound.Add({
	name = 			"KF_m99_Boltforward",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_BoltForward.wav"
})
sound.Add({
	name = 			"KF_m99_Bullet",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_Bullet.wav"
})
sound.Add({
	name = 			"KF_m99_BoltDown",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_BoltDown.wav"
})
sound.Add({
	name = 			"KF_m99_BoltUp",
	channel = 		CHAN_STATIC,
	volume = 		1.0,
	sound = 			"weapons/kf_m99/M99_BoltUp.wav"
})
sound.Add({
	name = 			"KF_m99.Fire",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			{ "weapons/kf_m99/M99_Fire_S.wav"}
})
