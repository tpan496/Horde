if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_anaconda")
    killicon.Add("arccw_horde_anaconda", "arccw/weaponicons/arccw_horde_anaconda", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "Anaconda (Horde)"
SWEP.Trivia_Class = "Handgun"
SWEP.Trivia_Desc = "Revolver."

SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = ".44 Magnum"
SWEP.Trivia_Mechanism = "Double-Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1990

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_anaconda.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 95
SWEP.DamageMin = 75
SWEP.RangeMin = 500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Range = 1250 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 12
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 9
SWEP.ReducedClipSize = 3

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.80
SWEP.RecoilSide = 0.50
SWEP.RecoilRise = 0

SWEP.Delay = 0.08 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
		PrintName = "DACT",
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.NPCWeaponType = {"weapon_ar2", "weapon_smg1"}
SWEP.NPCWeight = 150

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/anaconda.wav"
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/anaconda.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/usp45_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.125

SWEP.CaseBones = {
    [1] = "1",
    [2] = "2",
    [3] = "3",
    [4] = "4",
    [5] = "5",
    [6] = "6",
}

SWEP.IronSightStruct = {
    Pos = Vector(-1.6, 2.134, 0.518),
    Ang = Angle(-0.358, 0, 0),
    ViewModelFOV = 65,
    Magnification = 1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(13.92, 1, -1.08)
SWEP.CustomizeAng = Angle(6.8, 37.7, 10.3)

SWEP.HolsterPos = Vector(3, 0, 0)
SWEP.HolsterAng = Angle(-10, 25, 0)

SWEP.SprintPos = Vector(0, 0, 1)
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
    ["altirons"] = {
        Override_IronSightStruct = {
			Pos = Vector(-1.7, 0, -0.7),
			Ang = Angle(-0.358, 0, 0),
            ViewModelFOV = 65,
            Magnification = 1,
        }
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

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    if wep.Attachments[3].Installed == "mw2_tacticalknife" then
        return anim .. "_knife"
    end
end
SWEP.Hook_TranslateAnimation = function(wep, anim)
    if wep.Attachments[3].Installed == "mw2_tacticalknife" then
        return anim .. "_knife"
    end
end

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic_lp",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(2.5, 0, 2.313),
            vang = Angle(0, 0, 0),
            wang = Angle(-1.783, -22.088, -170.842),
        },
        ExcludeFlags = {"arcticfixyoshit1"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(9.8, 0, 1.45),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.692, 5.258, -4.367),
            wang = Angle(-0.884, -22.088, 180),
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip_pistol", "style_pistol", "mw2_tacknife"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(3.5, 0, -0.5),
            vang = Angle(0, 0, 0),
            wpos = Vector(7.374, 3.032, -2.007),
            wang = Angle(-1.783, -22.088, -170.842),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(7.6285, 0, 0.666),
            vang = Angle(0, 0, 0),
            wang = Angle(-1.783, -22.088, -170.842),
            wmax = Vector(9.826, 3.565, -3.132),
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
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
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
        Time = 29/30 /4,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 33/30 /4,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire"] = {
        Source = "fire",
        Time = 12/30,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 12/30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 92/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_clipout_v1.wav", 	t = 20/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_clipin_v1.wav", 	t = 50/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_chamber_v1.wav", 	t = 66/30},
					},
        Checkpoints = {24, 97, 131},
        FrameRate = 37,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.6,
        LastClip1OutTime = 1.5,
    },
---------------------------------------------------------
--------- LE TACTICAL KNIFE XDXDXDXD---------------------
---------------------------------------------------------
		["idle_knife"] = {
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
			Time = 12/30,
		},
		["fire_iron_knife"] = {
			Source = "fire_ads_knife",
			Time = 12/30,
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
			Time = 33/30 /4,
			LHIK = true,
			LHIKIn = 0,
			LHIKOut = 0.35,
		},
		["reload_knife"] = {
			Source = "reload_knife",
			Time = 92/30,
			TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
			SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_clipout_v1.wav", 	t = 20/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_clipin_v1.wav", 	t = 50/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_anaconda_reload_chamber_v1.wav", 	t = 67/30},
						},
			Checkpoints = {24, 97},
			FrameRate = 30,
			LHIK = true,
			LHIKIn = 0.5,
			LHIKOut = 0.4,
		},
		["bash_knife"] = {
			Source = "melee_knife",
			SoundTable = {{s = "MW2Common.Melee.Swing", 		t = 0}},
			Time = 97/120 / 1.6, -- damn you universal
			LHIK = true,
		},
}