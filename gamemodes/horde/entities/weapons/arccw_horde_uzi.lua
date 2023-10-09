if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_miniuzi")
    killicon.Add("arccw_horde_uzi", "arccw/weaponicons/arccw_mw2_miniuzi", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "Mini-Uzi"
SWEP.Trivia_Class = "Sub Machine Gun"
SWEP.Trivia_Desc = "Fully automatic, close range."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_miniuzi_2a.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-9, 3, -3.5),
    ang = Angle(-7, 0, 180),
    scale = 1.25
}
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 28
SWEP.DamageMin = 20
SWEP.Range = 1000 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 3
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 32 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 48
SWEP.ReducedClipSize = 16

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.60
SWEP.RecoilSide = 0.55
SWEP.RecoilRise = 0

SWEP.Delay = 0.09 -- 60 / RPM.
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

SWEP.NPCWeaponType = {"weapon_ar2", "weapon_smg1"}
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 30 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/miniuzi.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/miniuzi.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/usp45_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.80
SWEP.SightTime = 0.2

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.IronSightStruct = {
    Pos = Vector(-3.21, -2.254, -0.044),
    Ang = Angle(1.900, 0, 0),
    ViewModelFOV = 65 / 1.18,
    Magnification = 1.18,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(10.479, 0, -3.321)
SWEP.CustomizeAng = Angle(18.2, 39.4, 14.8)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 18

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
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

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-4, 0, 2.48),
            vang = Angle(0, 0, 0),
            wpos = Vector(1.998, 0.17, -5.025),
            wang = Angle(-3.074, -23.004, -172.249)
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(6, 0, 1.1),
            vang = Angle(0, 0, 0),
            wpos = Vector(12.057, 4.317, -3.858),
            wang = Angle(-3.074, -23.004, 0)
        },
		VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "bipod"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(3, 0, 0),
            vang = Angle(0, 0, 0),
            wpos = Vector(8.425, 2.96, -2.54),
            wang = Angle(-3.074, -23.004, -172.249)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-2, -0.8, 1.4),
            vang = Angle(0, 0, 90),
            wpos = Vector(8.425, 3.891, -4.147),
            wang = Angle(-3.074, -23.004, -77.301)
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
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
            vpos = Vector(0.5, -0.6, 0.75),
            vang = Angle(0, 0, 0),
            wpos = Vector(7.625, 2.4, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 0/30,
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 11/30
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 31/40
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 11/30
    },
    ["draw"] = {
        Source = "pullout",
        Time = 26/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 14/30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
    },
    ["fire"] = {
        Source = "fire",
        Time = 7/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 7/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 76/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_clipout_v2.wav", 	t = 15/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_clipin_v1.wav", 	t = 56/30},
					},
        LHIK = true,
	LHIKEaseIn = 0.31,
        LHIKIn = 0.4,
        LHIKEaseOut = 0.25,
        LHIKOut = 0.3,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 102/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_clipout_v2.wav", 	t = 15/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_clipin_v1.wav", 	t = 56/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_chamber_v1.wav", 	t = 76/30},
					},
        LHIK = true,
	LHIKEaseIn = 0.31,
        LHIKIn = 0.4,
        LHIKEaseOut = 0.25,
        LHIKOut = 0.3,
    },
}