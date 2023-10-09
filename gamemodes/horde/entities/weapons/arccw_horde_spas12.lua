if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_spas12")
    killicon.Add("arccw_horde_spas12", "arccw/weaponicons/arccw_mw2_spas12", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "SPAS-12"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Pump action."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_spas12.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-6, 4, -5),
    ang = Angle(-10, 0, 180),
    scale = 1.125
}
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 35
SWEP.DamageMin = 20
SWEP.RangeMin = 300 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Range = 700 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 16
SWEP.ReducedClipSize = 4

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 3
SWEP.RecoilSide = 3

SWEP.ShotgunReload = true
SWEP.ManualAction = true

SWEP.Delay = 60 / 290 -- 60 / RPM.
SWEP.Num = 8 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "PUMP",
        Mode = 1,
    },
    {
        Mode = 0,
    },
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 100 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 110 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/shot_ranger.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/shot_ranger.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/shot_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_m3"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.3

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.IronSightStruct = {
    Pos = Vector(-3.45, -3.9, 1.3),
    Ang = Angle(0.5, 0, 0),
    ViewModelFOV = 65 / 1.18,
    Magnification = 1.18,
}


SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(5.479, -5, -1.321)
SWEP.CustomizeAng = Angle(18.2, 39.4, 14.8)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
    ["grip"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {},
    },
    ["nors"] = {
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

SWEP.Attachments = {
	{
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(2, 0, 2.35),
            vang = Angle(0, 0, 0),
            wang = Angle(-9.738, 0, 180)
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle_shotgun",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(23, 0, 1.44),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "foregrip_mw2exclusive", "ubgl"},
        Bone = "j_pump",
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
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "j_pump",
        Offset = {
            vpos = Vector(3, -1, 0.5),
            vang = Angle(0, 0, 90),
            wpos = Vector(15.625, -0.253, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
		VMScale = Vector(1, 1, 1),
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
            vpos = Vector(2.5, -0.45, 0.75),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    if wep.Attachments[3].Installed then
        return anim .. "_fgrip"
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 2/30,
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
        Time = 19/30,
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
        Time = 12/30,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 12/30,
    },
    ["cycle"] = {
        Source = "rechamber",
        Time = 28/30,
		MinProgress = 0.55,
        SoundTable = {
						--{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 4/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 10/30},
					},
        ShellEjectAt = 2/30,
    },
    ["cycle_iron"] = {
        Source = "rechamber_ads",
        Time = 28/30,
		MinProgress = 0.6,
        SoundTable = {
						--{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 1/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 8/30},
					},
        ShellEjectAt = 2/30,
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 30/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
		RestoreAmmo = 1, -- loads a shell since the first reload has a shell in animation
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", 	t = 24/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
		MinProgress = 0.6,
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        Time = 20/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", 		t = 3/30}},
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
		MinProgress = 1,
    },
    ["sgreload_finish"] = {
        Source = "reload_finish",
        Time = 30/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 12/30},
					},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_finish",
        Time = 30/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 12/30},
					},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
    },
---------------------------------------
---------------------------------------
---------------------------------------
	["idle_fgrip"] = {
        Source = "idle_fgrip",
        Time = 2/30,
    },
    ["enter_sprint_fgrip"] = {
        Source = "sprint_in_fgrip",
        Time = 10/30
    },
    ["idle_sprint_fgrip"] = {
        Source = "sprint_loop_fgrip",
        Time = 30/40
    },
    ["exit_sprint_fgrip"] = {
        Source = "sprint_out_fgrip",
        Time = 10/30
    },
    ["draw_fgrip"] = {
        Source = "pullout_fgrip",
        Time = 19/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["holster_fgrip"] = {
        Source = "putaway_fgrip",
        Time = 14/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["fire_fgrip"] = {
        Source = "fire_fgrip",
        Time = 12/30,
		MinProgress = 0.433,
    },
    ["fire_iron_fgrip"] = {
        Source = "fire_ads_fgrip",
        Time = 12/30,
		MinProgress = 0.433,
    },
    ["cycle_fgrip"] = {
        Source = "rechamber_fgrip",
        Time = 28/30,
		MinProgress = 0.469,
        SoundTable = {
						--{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 4/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 10/30},
					},
        ShellEjectAt = 2/30,
    },
    ["cycle_iron_fgrip"] = {
        Source = "rechamber_ads_fgrip",
        Time = 28/30,
		MinProgress = 0.469,
        SoundTable = {
						--{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 1/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 8/30},
					},
        ShellEjectAt = 2/30,
    },
    ["sgreload_start_fgrip"] = {
        Source = "reload_start_fgrip",
        Time = 40/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
		RestoreAmmo = 1, -- only used by shotgun empty insert reload
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", 	t = 24/30},
					},
    },
    ["sgreload_insert_fgrip"] = {
        Source = "reload_loop_fgrip",
        Time = 26/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_loop_v1.wav", 		t = 3/30}},
        TPAnimStartTime = 0.3,
    },
    ["sgreload_finish_fgrip"] = {
        Source = "reload_finish_fgrip",
        Time = 30/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 12/30},
					},
    },
    ["sgreload_finish_empty_fgrip"] = {
        Source = "reload_finish_fgrip",
        Time = 30/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_spas12_reload_close_v1.wav", 	t = 12/30},
					},
    },
}

 -- Super fucky temp!
 -- S H U T  U P    A N D   K E E P  T H E M   P I N N E D  D O W N  

-- notverycreativenowarewe
local nvcnaw = 5

 -- hipfire
 -- maximum accuracy
    SWEP.Inaccuracy_Hip_Max_Stand	= nvcnaw
    SWEP.Inaccuracy_Hip_Max_Duck	= nvcnaw
    SWEP.Inaccuracy_Hip_Max_Prone	= nvcnaw
 -- minimum accuracy
    SWEP.Inaccuracy_Hip_Min_Stand   = nvcnaw
    SWEP.Inaccuracy_Hip_Min_Duck    = nvcnaw
    SWEP.Inaccuracy_Hip_Min_Prone   = nvcnaw

 -- sighted fire
 -- yeah
    SWEP.Inaccuracy_ADS = 5.5

 -- inaccuracy when you're... i don't remember
SWEP.Inaccuracy_Add_ADS			= 0
SWEP.Inaccuracy_Add_Hip			= 0
SWEP.Inaccuracy_Add_Move		= 0.1