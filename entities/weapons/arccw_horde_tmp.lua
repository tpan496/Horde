if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_tmp")
    killicon.Add("arccw_horde_tmp", "arccw/weaponicons/arccw_mw2_tmp", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "TMP"
SWEP.Trivia_Class = "Machine Pistol"
SWEP.Trivia_Desc = "Fully automatic, close range."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_mp9_2.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-9, 4, -3.5),
    ang = Angle(-7, 0, 180),
    scale = 1.25
}
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 21
SWEP.DamageMin = 18
SWEP.Range = 500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 30
SWEP.ReducedClipSize = 30

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.23

SWEP.Delay = 60 / 857 -- 60 / RPM.
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
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 175

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/miniuzi.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/miniuzi.wav"
SWEP.ShootSoundSilenced =	"horde/weapons/tmp/tmp_fire.ogg"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.2

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.IronSightStruct = {
    Pos = Vector(-3.2, -2.485, 0.9),
    Ang = Angle(0.629, 0, 0),
    ViewModelFOV = 65 / 1.18,
    Magnification = 1.18,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1.1, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(7, 1, -2)
SWEP.CustomizeAng = Angle(10, 30, 0)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 18

SWEP.ExtraSightDist = 0

SWEP.AttachmentElements = {
    ["stock2"] = {
        VMBodygroups =  {{ind = 1, bg = 1}},
    },
    ["grip2"] = {
        VMBodygroups =  {{ind = 2, bg = 1}},
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

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic","optic_lp"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(-3, -0.025, 2.15),
            vmax = Vector(1, -0.025, 2.15),
        },
        InstalledEles = {"stock2"},
		ExtraSightDist = 5,
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(5, 0, 0.9),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
		VMScale = Vector(1, 1, 1),
        Installed = "go_supp_tgpa",
    },
    {
        PrintName = "Underbarrel",
		Slot = {"foregrip", "bipod","style_pistol"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(3, 0, -0.35),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
        InstalledEles = {"stock2","grip2"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0, -1.1, 1.4),
            vang = Angle(0, 0, 90),
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
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
            vpos = Vector(0, -0.8, 1.25),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Animations = { 
    ["idle"] = {
        Source = "idle",
        Time = 2/30,
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
        LHIKIn = 0,
        LHIKOut = 0.9,
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
        Time = 63/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_mp9_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_mp9_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_mp9_reload_clipin_v1.wav", 	t = 32/30},
					},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 89/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_miniuzi_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_mp9_reload_clipout_v1.wav", 	t = 9/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_mp9_reload_clipin_v1.wav", 	t = 32/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_mp9_reload_chamber_v1.wav", 	t = 59/30},
					},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.5,
    },
}