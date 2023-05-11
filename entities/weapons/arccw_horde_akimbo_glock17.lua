if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_akimbo_glock17")
    killicon.Add("arccw_horde_akimbo_glock17", "arccw/weaponicons/arccw_horde_akimbo_glock17", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - MW2 - Unofficial"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "G17"
SWEP.Trivia_Class = "Handgun"
SWEP.Trivia_Desc = "Semi-automatic (single fire)\nUnofficial."

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_glock17_1.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-9, 3, -3.5),
    ang = Angle(-7, 0, 180),
    scale = 1.25
}
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 40
SWEP.DamageMin = 20
SWEP.Range = 740 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 17 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 33
SWEP.ReducedClipSize = 10

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.2

SWEP.Delay = 0.079 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_pistol"}
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 7 / 2 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 125 / 2.5 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 105 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/glock.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/glock.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/usp45_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.125


SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.IronSightStruct = {
    Pos = Vector(-1.998, 0, 1.563),
    Ang = Angle(-1.112, 0, 0),
    ViewModelFOV = 65,
    Magnification = 1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 1.34)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(3, 0, -1)
SWEP.CustomizeAng = Angle(10, 19, 0)

SWEP.CrouchPos = Vector(-2.764, -0.927, -0.202)
SWEP.CrouchAng = Angle(1.12, -1, -21.444)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1.34)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 18

SWEP.ExtraSightDist = 5

-----[ Tactical knife sheet ]------
	SWEP.CanBash				= true -- Tac knife will save us
	--SWEP.MeleeDamage			= 100
	--SWEP.MeleeRange				= 16
	--SWEP.MeleeDamageType		= DMG_CLUB
	--SWEP.MeleeTime				= 0.8
	SWEP.MeleeGesture			= ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
	--SWEP.MeleeAttackTime		= 0.079
	SWEP.MeleeMissSound			= ""
	SWEP.MeleeHitSound			= "MW2Common.Melee.HitWorld"
	SWEP.MeleeHitNPCSound		= "MW2Common.Melee.HitFleshy_Slice"

SWEP.AttachmentElements = {
    ["railthegrind"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw/fesiugmw2/atts/pistolrail_1.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector(0, -0.025, -0.7),
                    ang = Angle(0, 0, 0),
                }
            }
        },
    },
    ["altirons"] = {
        Override_IronSightStruct = {
            Pos = Vector(-1.71, -2.346, 0.12),
            Ang = Angle(0.4, 0, 0),
            ViewModelFOV = 65,
            Magnification = 1,
        }
    },
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic_lp",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(-0.8, -0.01, 1.9),
            vang = Angle(0, 0, 0),
        },
        ExcludeFlags = {"arcticfixyoshit1","cantuseshitinakimboyet"},
        InstalledEles = {"railthegrind"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(3.7, 0, 0.9),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
		VMScale = Vector(0.67, 0.67, 0.67),
        ExcludeFlags = {"cantuseshitinakimboyet"},
    },
    {
        PrintName = "Underbarrel",
		Slot = {"foregrip_pistol", "style_pistol", "mw2_tacknife"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(1.5, 0, -0.5),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
        MergeSlots = {8},
    },
    {
        PrintName = "Tactical",
        Slot = "tac_pistol",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(2.5, 0, 0),
            vang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG",
        ExcludeFlags = {"cantuseshitinakimboyet"},
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
        PrintName = "Akimbotest",
        DefaultAttName = "No LH",
        Slot = "akimboglock",
        Bone = "tag_view",
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, 0, 0),
        },
        Hidden = true,
        Installed = "horde_akimbo_glock",
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(1, -0.45, 0.4),
            vang = Angle(0, 0, 0),
            wpos = Vector(8, 2.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    if wep.Attachments[3].Installed == "mw2_tacticalknife" then
        return anim .. "_knife"
    elseif wep.Attachments[8].Installed then
        return anim .. "_akimbo_right"
    end
end
SWEP.Hook_TranslateAnimation = function(wep, anim)
    if wep.Attachments[3].Installed == "mw2_tacticalknife" then
        return anim .. "_knife"
    elseif wep.Attachments[8].Installed then
        return anim .. "_akimbo_right"
    end
end

function SWEP:Hook_OnDeploy()
    timer.Simple(0, function ()
        if !IsValid(self) then return end
        self:Attach(9, "horde_akimbo_glock")
    end)
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 2/30
    },
    ["idle_empty"] = {
        Source = "idle_empty",
        Time = 2/30
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
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        Time = 31/30 /4,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 32/30 /4,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["draw_empty"] = {
        Source = "pullout_empty",
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        Time = 31/30 /4,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster_empty"] = {
        Source = "putaway_empty",
        Time = 30/30 /4,
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
        Time = 13/30,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "lastfire",
        Time = 9/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "lastfire",
        Time = 9/30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 51/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_lift_v1.wav", 	t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipout_v1.wav", 	t = 9/24},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipin_v1.wav", 	t = 27/24},
					},
        Checkpoints = {24, 97},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.4,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 60/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_lift_v1.wav", 	t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipout_v1.wav", 	t = 9/24},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipin_v1.wav", 	t = 27/24},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_chamber_v1.wav", 	t = 36/24},
					},
        Checkpoints = {24, 97, 131},
        FrameRate = 37,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.6,
    },
---------------------------------------------------------
--------- LE TACTICAL KNIFE XDXDXDXD---------------------
---------------------------------------------------------
		["idle_knife"] = {
			Source = "idle_knife",
			Time = 300/30
		},
		["idle_empty_knife"] = {
			Source = "idle_knife",
			Time = 300/30
		},
		["enter_sprint_knife"] = {
			Source = "sprint_in_knife",
			Time = 10/30
		},
		["idle_sprint_knife"] = {
			Source = "sprint_loop_knife",
			Time = 30/40
		},
		["exit_sprint_knife"] = {
			Source = "sprint_out_knife",
			Time = 10/30
		},
		["fire_knife"] = {
			Source = "fire_knife",
			Time = 8/30,
			ShellEjectAt = 0,
		},
		["fire_iron_knife"] = {
			Source = "fire_ads_knife",
			Time = 8/30,
			ShellEjectAt = 0,
		},
		["fire_empty_knife"] = {
			Source = "lastfire_knife",
			Time = 8/30,
			ShellEjectAt = 0,
		},
		["fire_iron_empty_knife"] = {
			Source = "lastfire_knife",
			Time = 8/30,
			ShellEjectAt = 0,
		},
		["draw_knife"] = {
			Source = "pullout_knife",
			SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
			Time = 29/30 /4,
			LHIK = true,
			LHIKIn = 0,
			LHIKOut = 0.35,
		},
		["holster_knife"] = {
			Source = "putaway_knife",
			Time = 31/30 /4,
			LHIK = true,
			LHIKIn = 0,
			LHIKOut = 0.35,
		},
		["draw_empty_knife"] = {
			Source = "pullout_knife",
			SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
			Time = 29/30 /4,
			LHIK = true,
			LHIKIn = 0,
			LHIKOut = 0.35,
		},
		["holster_empty_knife"] = {
			Source = "putaway_knife",
			Time = 31/30 /4,
			LHIK = true,
			LHIKIn = 0,
			LHIKOut = 0.35,
		},
		["reload_knife"] = {
			Source = "reload_knife",
			Time = 51/24,
			TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
			SoundTable = {
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_lift_v1.wav", 	t = 0},
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipout_v1.wav", 	t = 7/24},
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipin_v1.wav", 	t = 25/24},
						},
			Checkpoints = {24, 97},
			FrameRate = 30,
			LHIK = true,
			LHIKIn = 0.5,
			LHIKOut = 0.4,
		},
		["reload_empty_knife"] = {
			Source = "reload_empty_knife",
			Time = 46/24,
			TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
			SoundTable = {
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_lift_v1.wav", 	t = 0},
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipout_v1.wav", 	t = 6/24},
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipin_v1.wav", 	t = 25/24},
							{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_chamber_v1.wav", 	t = 37/24},
						},
			Checkpoints = {24, 97, 131},
			FrameRate = 37,
			LHIK = true,
			LHIKIn = 0.5,
			LHIKOut = 0.6,
		},
		["bash_knife"] = {
			Source = "melee_knife",
			SoundTable = {{s = "MW2Common.Melee.Swing", 		t = 0}},
			Time = 97/120 / 1.6, -- damn you universal
			LHIK = true,
		},

---------------------------------------------------------
--------- LE akimbo gun ---------------------
---------------------------------------------------------
    ["idle_akimbo_right"] = {
        Source = "idle_akimbo_right",
        Time = 2/30
    },
    ["idle_empty_akimbo_right"] = {
        Source = "idle_empty_akimbo_right",
        Time = 2/30
    },
    ["enter_sprint_akimbo_right"] = {
        Source = "sprint_in_akimbo_right",
        Time = 11/30
    },
    ["idle_sprint_akimbo_right"] = {
        Source = "sprint_loop_akimbo_right",
        Time = 31/40
    },
    ["exit_sprint_akimbo_right"] = {
        Source = "sprint_out_akimbo_right",
        Time = 11/30
    },
    ["draw_akimbo_right"] = {
        Source = "pullout_akimbo_right",
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        Time = 26/30 /4,
    },
    ["holster_akimbo_right"] = {
        Source = "putaway_akimbo_right",
        Time = 26/30 /4,
    },
    ["fire_akimbo_right"] = {
        Source = "fire_akimbo_right",
        Time = 6/30,
        ShellEjectAt = 0,
    },
    ["fire_empty_akimbo_right"] = {
        Source = "fire_last_akimbo_right",
        Time = 6/30,
        ShellEjectAt = 0,
    },
    ["reload_akimbo_right"] = {
        Source = "reload_akimbo_right",
        Time = 70/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_lift_v1.wav", 	t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipout_v1.wav", 	t = 4/40},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipin_v1.wav", 	t = 39/40},
					},
    },
    ["reload_empty_akimbo_right"] = {
        Source = "reload_empty_akimbo_right",
        Time = 89/40,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_lift_v1.wav", 	t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipout_v1.wav", 	t = 4/40},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_clipin_v1.wav", 	t = 45/40},
						{s = "weapons/fesiugmw2/foley/wpfoly_glock_reload_chamber_v1.wav", 	t = 65/40},
					},
    },
}