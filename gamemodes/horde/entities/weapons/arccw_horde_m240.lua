if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_m240")
    killicon.Add("arccw_horde_m240", "arccw/weaponicons/arccw_mw2_m240", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.CamAttachment = 3

SWEP.PrintName = "M240"
SWEP.Trivia_Class = "Light Machine Gun"
SWEP.Trivia_Desc = "Fully automatic, large magazines."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_m240_1.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-6, 3, -6),
    ang = Angle(-10, 0, 180),
    scale = 1.125
}
SWEP.WorldModel = "models/weapons/arccw/fesiugmw2_2/c_m240_1.mdl"
SWEP.ViewModelFOV = 65
SWEP.Bipod_Integral = true
SWEP.BipodDispersion = 0.5
SWEP.BipodRecoil = 0.5

SWEP.Damage = 46
SWEP.DamageMin = 31
SWEP.Range = 1500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 200
SWEP.ReducedClipSize = 50

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.35
SWEP.RecoilRise = 1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 650 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_ar2", "weapon_smg1"}
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 8 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 600 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 70 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/m240.wav"
SWEP.ShootMechSound =       ArcCW_MW2_Mech
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/m240.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/m240_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = "models/shells/shell_762nato.mdl"
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.35
SWEP.SightTime = 0.425
SWEP.ShootSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-3.426, -2.9, 0.579),
    Ang = Angle(-0.1, 0, 0),
    ViewModelFOV = 65 / 1.3,
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(9.76, 0, -1.88)
SWEP.CustomizeAng = Angle(7.8, 27.7, 11.699)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 32

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {},
    },
    ["grip"] = {
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

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    [14] = "j_ammo_014",
    [13] = "j_ammo_013",
    [12] = "j_ammo_012",
    [11] = "j_ammo_011",
    [10] = "j_ammo_010",
    [9] = "j_ammo_09",
    [8] = "j_ammo_08",
    [7] = "j_ammo_07",
    [6] = "j_ammo_06",
    [5] = "j_ammo_05",
    [4] = "j_ammo_04",
    [3] = "j_ammo_03",
    [2] = "j_ammo_02",
    [1] = "j_ammo_01",
}

SWEP.ExtraSightDist = 5
SWEP.Bipod_Integral = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "j_ammo_cover",
        Offset = {
            vpos = Vector(-8.5, 0, 0.8),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(-8.5, 0, 0.8),
            vmax = Vector(-5, 0, 0.8),
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(30, 0, 2.0),
            vang = Angle(0, 0, 0),
        },
		VMScale = Vector(2, 1.5, 1.5),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl", "bipod", "foregrip_mw2exclusive"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(18.427, 0, -1.04),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(14, 0, -0.5),
            vmax = Vector(18, 0, -0.5),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(20, -1.4, 1.4),
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
        Slot = "go_ammo"
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
            vpos = Vector(4, -0.75, 1.5),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    if wep.Attachments[3].Installed then
        return anim .. "_grip"
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 200/30
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 10/30
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
        Time = 41/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 18/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire"] = {
        Source = "fire",
        Time = 9/30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 9/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 291/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        MinProgress = 5,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_lift_v1.wav", 			t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_chamber_v1.wav", 		t = 16/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_open_v1.wav", 			t = 79/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_clipout_v1.wav", 		t = 104/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_clipin_v1.wav", 		t = 148/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_close_v1.wav", 			t = 209/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_hit_v1.wav", 			t = 225/30},
					},
        LastClip1OutTime = 2.5,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
    },
------------------
    ["idle_grip"] = {
        Source = "idle_grip",
        Time = 200/30
    },
    ["enter_sprint_grip"] = {
        Source = "sprint_in_grip",
        Time = 10/30
    },
    ["idle_sprint_grip"] = {
        Source = "sprint_loop_grip",
        Time = 30/40
    },
    ["exit_sprint_grip"] = {
        Source = "sprint_out_grip",
        Time = 10/30
    },
    ["draw_grip"] = {
        Source = "pullout_grip",
        Time = 41/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster_grip"] = {
        Source = "putaway_grip",
        Time = 18/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire_grip"] = {
        Source = "fire_grip",
        Time = 9/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_grip"] = {
        Source = "fire_ads_grip",
        Time = 9/30,
        ShellEjectAt = 0,
    },
    ["reload_grip"] = {
        Source = "reload_grip",
        Time = 291/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        MinProgress = 5,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_lift_v1.wav", 			t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_chamber_v1.wav", 		t = 16/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_open_v1.wav", 			t = 79/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_clipout_v1.wav", 		t = 104/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_clipin_v1.wav", 		t = 148/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_close_v1.wav", 			t = 209/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_rpd_reload_hit_v1.wav", 			t = 225/30},
					},
        LastClip1OutTime = 2.5,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
    },
}