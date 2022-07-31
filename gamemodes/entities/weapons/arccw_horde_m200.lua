if not ArcCWInstalled then return end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "Intervention Obrez"
SWEP.Trivia_Class = "Sniper Rifle"
SWEP.Trivia_Desc = "Obrez bolt action."

if CLIENT then
SWEP.Trivia_Manufacturer = "CheyTac USA"
SWEP.Trivia_Calibre = ".408 Cheyenne Tactical"
SWEP.Trivia_Mechanism = "Bolt-Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2001
end

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_intervention_obrez.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 105
SWEP.DamageMin = 105
SWEP.Range = 2000
SWEP.Penetration = 11

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 10 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 10
SWEP.ReducedClipSize = 10

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 2
SWEP.RecoilSide = 2

SWEP.AccuracyMOA = 0.1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Delay = 60 / 600 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "BOLT",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_annabelle", "weapon_shotgun"}
SWEP.NPCWeight = 100

SWEP.ManualAction = true
SWEP.NoLastCycle = true -- do not cycle on last shot

SWEP.Primary.Ammo = "SniperPenetratedRound" -- what ammo type the gun uses

SWEP.ShootVol = 140 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/cheytac.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/cheytac.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/m4_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_6"
SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellPitch = 80
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.6
SWEP.SightTime = 0.2

SWEP.IronSightStruct = {
    Pos = Vector(-3.778, -3, 0.93),
    Ang = Angle(0.513, 0, 0),
    ViewModelFOV = 65 / 1.3,
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.AttachmentElements = {
    --[[["nors"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {},
    },]]
    ["nolaser"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {},
    },
    ["wepcamo-desert"]		= { VMSkin = 1 },
    ["wepcamo-arctic"]		= { VMSkin = 2 },
    ["wepcamo-woodland"]	= { VMSkin = 3 },
    ["wepcamo-digital"]		= { VMSkin = 4 },
    ["wepcamo-urban"]		= { VMSkin = 5 },
    ["wepcamo-bluetiger"]	= { VMSkin = 6 },
    ["wepcamo-redtiger"]	= { VMSkin = 7 },
    ["wepcamo-fall"]		= { VMSkin = 8 },
    ["wepcamo-whiteout"]	= { VMSkin = 9 },
    ["wepcamo-blackout"]        = { VMSkin = 10 },
    ["wepcamo-bushdweller"]     = { VMSkin = 11 },
    ["wepcamo-thunderstorm"]    = { VMSkin = 12 },
}

SWEP.BarrelLength = 30

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_sniper","optic"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(4.2, 0, 3),
            vang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(22, 0, 1.6),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
		VMScale = Vector(2, 1.25, 1.25)
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl", "bipod", "style_pistol"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(18.427, 0, -1.04),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
        SlideAmount = {
            vmin = Vector(8, 0, 0),
            vmax = Vector(17.8, 0, 0.7),
            wmin = Vector(15, 0.74, -4.301),
            wmax = Vector(15, 0.74, -4.301),
        },
    },	
    {
        PrintName = "Tactical",
        Slot = {"tac","mw2_hidelaser"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(14, 0, 2.6),
            vang = Angle(0, 0, 180),
            wpos = Vector(15.625, -0.253, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
        InstalledEles = {"nolaser"},
    },
    {
        PrintName = "Ammo Type",
        Slot = "ammo_bullet"
    },
    {
        PrintName = "Perk",
        Slot = "perk"
    },
    {
        PrintName = "Camouflage",
        DefaultAttName = "None",
        Slot = "mw2_wepcamo",
        FreeSlot = true,
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(4, -0.6, 1),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 101/30
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 20/30
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 30/40
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 10/30
    },
    ["draw"] = {
        Source = "pullout",
        Time = 25/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
    },
    ["holster"] = {
        Source = "putaway",
        Time = 20/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "fire",
        Time = 5/30,
		MinProgress = 5/30,
    },
    ["cycle"] = {
        Source = "rechamber",
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltunlock_v1.wav", 	t = (3/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltopen_v1.wav", 		t = (7/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltclose_v1.wav", 	t = (16/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltlock_v1.wav", 		t = (19/30)*0.8},
					},
        ShellEjectAt = (7/30)*0.8,
        Time = (29/30)*0.4,
    },
    ["reload"] = {
        Source = "reload_tac",
        Time = (69/30)*0.8,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_lift_v1.wav", 		t = (0)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_clipout_v1.wav", 	t = (18/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_clipin_v1.wav", 	t = (47/30)*0.8},
					},
        Checkpoints = {18, 47},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.3,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = (117/30)*0.8,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_lift_v1.wav", 			t = (0)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltunlock_v1.wav", 	t = (13/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltopen_v1.wav", 		t = (18/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_clipout_v1.wav", 		t = (54/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_clipin_v1.wav", 		t = (81/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltclose_v1.wav", 	t = (99/30)*0.8},
						{s = "weapons/fesiugmw2/foley/wpfoly_cheytech_reload_boltlock_v1.wav", 		t = (103/30)*0.8},
					},
        Checkpoints = {18, 54, 81, 99},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 1.5,
        LHIKOut = 0.8,
    },
}