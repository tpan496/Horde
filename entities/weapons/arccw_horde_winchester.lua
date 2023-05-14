if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_winchester")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_winchester", "vgui/hud/arccw_horde_winchester", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.CamAttachment = 3

SWEP.PrintName = "M1873 Winchester LAR"
SWEP.Trivia_Class = "Rifle"
SWEP.Trivia_Desc = "Lever-action."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_m1887_1.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos = Vector(16, 0, -3.3),
    ang = Angle(-12, 180, 180),
    scale = 1
}
--SWEP.WorldModelOffset = {
--    pos = Vector(-4, 3, -6),
--    ang = Angle(-10, 0, 180),
--    scale = 1.125
--}
SWEP.ViewModelFOV = 65

SWEP.Damage = 100
SWEP.DamageMin = 90
SWEP.Range = 1500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8
SWEP.ReducedClipSize = 8

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 1.5
SWEP.RecoilSide = 1

SWEP.ShotgunReload = true
SWEP.ManualAction = true

SWEP.Delay = 12/100 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "lever",
        Mode = 1,
    },
    {
        Mode = 0,
    },
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 110 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/shot_w1200.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/shot_ranger.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/shot_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_6"
SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.5
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
    Pos = Vector(-3.07, -1.8, 1.8),
    Ang = Angle(0, 0, 0),
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

SWEP.ManualAction = true
SWEP.NoLastCycle = true -- do not cycle on last shot

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {},
    },
}

SWEP.Attachments = {
	{
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(8, 0, 2.95),
            vang = Angle(0, 0, 0),
            wang = Angle(-9.738, 0, 180)
        },
        ExcludeFlags = {"arcticfixyoshit1","cantuseshitinakimboyet"},
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle_shotgun",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(26, 0, 2.23),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
        ExcludeFlags = {"arcticfixyoshit1","cantuseshitinakimboyet"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0, 0, -0.7),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
        SlideAmount = {
            vmin = Vector(6, 0, 0.5),
            vmax = Vector(12, 0, 0.5),
        },
        MergeSlots = {7},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(14, -0.8, 1.75),
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
        PrintName = "Akimbotest",
        DefaultAttName = "No LH",
        Slot = "akimbotest",
        Bone = "tag_view",
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, 0, 0),
        },
        Hidden = true,
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

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    if wep.Attachments[7].Installed then
        return anim .. "_akimbo_right"
    end
end
SWEP.Hook_TranslateAnimation = function(wep, anim)
    if wep.Attachments[7].Installed then
        return anim .. "_akimbo_right"
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1/30,
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
    ["ready"] = {
        Source = "pullout_first",
        Time = 47/30,
        SoundTable = {
                        {s = "MW2Common.Deploy",                                            t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 12/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 24/30},
					},
    },
    ["draw"] = {
        Source = "pullout",
        Time = 25/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
    },
    ["holster"] = {
        Source = "putaway",
        Time = 25/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["fire"] = {
        Source = "fire",
        Time = 12/45,
		MinProgress = 0,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 12/45,
		MinProgress = 0,
    },
    ["cycle"] = {
        Source = "rechamber",
        Time = 35/45,
		MinProgress = 0.65,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 16/30},
					},
    },
    ["cycle_iron"] = {
        Source = "rechamber_ads",
        Time = 35/45,
		MinProgress = 0.65,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 16/30},
					},
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 59/60,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
		RestoreAmmo = 1, -- loads a shell since the first reload has a shell in animation
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 8/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_shell_v1.wav", 	t = 53/30},
					},
		MinProgress = 1.45,
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        Time = 33/60,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_shell_v1.wav", 		t = 27/40}},
        TPAnimStartTime = 0.3,
		MinProgress = 0.6,
    },
    ["sgreload_finish"] = {
        Source = "reload_finish",
        Time = 41/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 15/30},
					},
    },
-- akimbo
    ["idle_akimbo_right"] = {
        Source = "idle_r",
        Time = 1/30,
    },
    ["enter_sprint_akimbo_right"] = {
        Source = "sprint_in_r",
        Time = 10/30
    },
    ["idle_sprint_akimbo_right"] = {
        Source = "sprint_loop_r",
        Time = 30/40
    },
    ["exit_sprint_akimbo_right"] = {
        Source = "sprint_out_r",
        Time = 10/30
    },
    ["ready_akimbo_right"] = {
        Source = "pullout_first_r",
        Time = 47/30,
        SoundTable = {
                        {s = "MW2Common.Deploy",                                            t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 7/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 23/30},
					},
    },
    ["draw_akimbo_right"] = {
        Source = "pullout_r",
        Time = 25/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
    },
    ["holster_akimbo_right"] = {
        Source = "putaway_r",
        Time = 25/30,
    },
    ["fire_akimbo_right"] = {
        Source = "fire_r",
        Time = 12/30,
		MinProgress = 0.433,
    },
    ["cycle_akimbo_right"] = {
        Source = "rechamber_r",
        Time = 35/30,
		MinProgress = 0.85,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 6/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 16/30},
					},
    },
    ["sgreload_start_akimbo_right"] = {
        Source = "reload_start_r",
        Time = 59/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
		RestoreAmmo = 1, -- loads a shell since the first reload has a shell in animation
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_lift_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_open_v1.wav", 	t = 14/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_shell_v1.wav", 	t = 54/30},
					},
		MinProgress = 1.45,
    },
    ["sgreload_insert_akimbo_right"] = {
        Source = "reload_loop_r",
        Time = 33/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_shell_v1.wav", 		t = 18/40}},
        TPAnimStartTime = 0.3,
		MinProgress = 0.6,
    },
    ["sgreload_finish_akimbo_right"] = {
        Source = "reload_finish_r",
        Time = 41/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m1887_reload_close_v1.wav", 	t = 15/30},
					},
    },
}