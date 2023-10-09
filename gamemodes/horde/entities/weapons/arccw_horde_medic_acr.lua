if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_acr")
    killicon.Add("arccw_horde_medic_acr", "arccw/weaponicons/arccw_mw2_acr", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.CamAttachment = 3

SWEP.PrintName = "ACR Medic Grenadier"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "Fully automatic, all purpose weapon."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_acr_2.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-5, 3, -5.5),
    ang = Angle(-10, 0, 180),
    scale = 1.125
}
SWEP.WorldModel = "models/weapons/w_rif_sg552.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 34
SWEP.DamageMin = 20
SWEP.RangeMin = 1800 * 0.025 -- GAME UNITS * 0.025 = METRES
SWEP.Range = 2300 * 0.025 -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 45
SWEP.ReducedClipSize = 15

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.33
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.1

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

SWEP.AccuracyMOA = 2.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 500 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/acr.wav"
SWEP.ShootMechSound =       ArcCW_MW2_Mech
--SWEP.DistantShootSound =	"weapons/fesiugmw2/fire_distant/acr.wav"
SWEP.ShootSoundSilenced =	"weapons/fesiugmw2/fire/acr_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 90, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.IronSightStruct = {
    Pos = Vector(-3.101, -3.1, 0.2),
    Ang = Angle(-0.301, 0, 0),
    ViewModelFOV = 65 / 1.3,
    Magnification = 1.3,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(6.639, 0, -2.26)
SWEP.CustomizeAng = Angle(16, 32, 4)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.SprintPos = Vector(0, 0, 1)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 27

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
            ["mw2_ubgl_m203"] = {
                VMBodygroups = {{ind = 2, bg = 1}},
            },
            ["mw2_ubgl_masterkey"] = {
                VMBodygroups = {{ind = 2, bg = 2}},
            },
            ["horde_ubgl_medic"] = {
                VMBodygroups = {{ind = 2, bg = 1}},
            },
}

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(3.7, 0, 2.12),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(23.628, 0, 0.56),
            vang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl", "bipod", "medic_ubgl"},
        Bone = "tag_weapon",
        Offset = {
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(8, 0, -1),
            vmax = Vector(14, 0, -1),
        },
        Installed = "horde_ubgl_medic"
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vang = Angle(0, 0, 90),
        },
        SlideAmount = {
            vmin = Vector(10.5, -1.5, 0.75),
            vmax = Vector(15, -1.5, 0.75),
        }
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
            vpos = Vector(2.85, -0.55, 0.25),
            vang = Angle(0, 0, 0),
            wpos = Vector(15.625, -0.253, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
    },
}



SWEP.Hook_TranslateAnimation = function(wep, anim)
	local attached = wep.Attachments[3].Installed
	
	-- m203 is 1, masterkey is 2, fgrip is 3
	local attthing
		if 		attached == "mw2_ubgl_m203" 		then attthing = 1
		elseif 	attached == "mw2_ubgl_masterkey" 	then attthing = 2
		else 											 attthing = 0
	end
	
	-- when entering ubgl
	if anim == "enter_ubgl" then
		if attthing == 1 then
			return "switch2_alt_m203"
		elseif attthing == 2 then
			return "switch2_alt_masterkey"
		end
	elseif anim == "exit_ubgl" then
		if attthing == 1 then
			return "switch2_gun_m203"
		elseif attthing == 2 then
			return "switch2_gun_masterkey"
		end
	end
	
    if attthing == 1 and wep:GetInUBGL() then
        return "alt_" .. anim .. "_m203"
		elseif attthing == 1 then
			return anim .. "_m203"
		
	elseif attthing == 2 and wep:GetInUBGL() then
        return "alt_" .. anim .. "_masterkey"
		elseif attthing == 2 then
			return anim .. "_masterkey"
		
    end
end

SWEP.Animations = {
		["enter_ubgl"] = {
			Source = "idle",
			Time = 0/30
		},
		["exit_ubgl"] = {
			Source = "idle",
			Time = 0/30
		}, 						-- Fuck you.
    ["idle"] = {
        Source = "idle",
        Time = 1/30
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
        Time = 27/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 20/30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["ready"] = {
        Source = "pullout_first",
        Time = 36/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_chamber_v1.wav", 	t = 15/30},
					},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
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
        Time = 56/30,
        MinProgress = 1.1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipin_v1.wav", 		t = 32/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 74/30,
        MinProgress = 1.1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipin_v1.wav", 		t = 32/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_chamber_v1.wav", 	t = 52/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1.4,
    },
------------------------------------------------
------ Here lies M203 ANIMATIONS ... AWESOME ---
------------------------------------------------
    ["idle_m203"] = {
        Source = "idle_m203",
        Time = 1/30
    },
    ["enter_sprint_m203"] = {
        Source = "sprint_in_m203",
        Time = 10/30
    },
    ["idle_sprint_m203"] = {
        Source = "sprint_loop_m203",
        Time = 30/40
    },
    ["exit_sprint_m203"] = {
        Source = "sprint_out_m203",
        Time = 10/30
    },
    ["draw_m203"] = {
        Source = "pullout_m203",
        Time = 27/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["holster_m203"] = {
        Source = "putaway_m203",
        Time = 20/30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["ready_m203"] = {
        Source = "pullout_first_m203",
        Time = 36/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_chamber_v1.wav", 	t = 15/30},
					},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire_m203"] = {
        Source = "fire_m203",
        Time = 7/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_m203"] = {
        Source = "fire_ads_m203",
        Time = 7/30,
        ShellEjectAt = 0,
    },
    ["reload_m203"] = {
        Source = "reload_m203",
        Time = 56/30,
        MinProgress = 1.1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipin_v1.wav", 		t = 32/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty_m203"] = {
        Source = "reload_empty_m203",
        Time = 74/30,
        MinProgress = 1.1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipin_v1.wav", 		t = 32/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_chamber_v1.wav", 	t = 52/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1.4,
    },
------------------------------------------------
------ Here lies M203 IN THE ANIMATIONS........... ... AWESOME ---
------------------------------------------------
    ["alt_idle_m203"] = {
        Source = "alt_idle_m203",
        Time = 1/30
    },
    ["alt_enter_sprint_m203"] = {
        Source = "alt_sprint_in_m203",
        Time = 10/30
    },
    ["alt_idle_sprint_m203"] = {
        Source = "alt_sprint_loop_m203",
        Time = 30/40
    },
    ["alt_exit_sprint_m203"] = {
        Source = "alt_sprint_out_m203",
        Time = 10/30
    },
    ["alt_draw_m203"] = {
        Source = "alt_pullout_m203",
        Time = 33/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
    },
    ["alt_holster_m203"] = {
        Source = "alt_putaway_m203",
        Time = 20/30,
    },
    ["alt_fire_m203"] = {
        Source = "alt_fire_m203",
        Time = 10/30,
    },
    ["alt_reload_m203"] = {
        Source = "alt_reload_m203",
        Time = 78/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_m203_chamber_open_v12.wav", 		t = 12/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m203_load_v12.wav", 	t = 39/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_m203_chamber_close_v12.wav", 	t = 60/30},
					},
    },
------------------------------------------------
------ Here lies MASTERKEY ANIMATIONS ... AWESOME ---
------------------------------------------------
    ["idle_masterkey"] = {
        Source = "idle_masterkey",
        Time = 1/30
    },
    ["enter_sprint_masterkey"] = {
        Source = "sprint_in_masterkey",
        Time = 10/30
    },
    ["idle_sprint_masterkey"] = {
        Source = "sprint_loop_masterkey",
        Time = 30/40
    },
    ["exit_sprint_masterkey"] = {
        Source = "sprint_out_masterkey",
        Time = 10/30
    },
    ["draw_masterkey"] = {
        Source = "pullout_masterkey",
        Time = 27/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["holster_masterkey"] = {
        Source = "putaway_masterkey",
        Time = 20/30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["ready_masterkey"] = {
        Source = "pullout_first_masterkey",
        Time = 36/30,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_chamber_v1.wav", 	t = 15/30},
					},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire_masterkey"] = {
        Source = "fire_masterkey",
        Time = 7/30,
        ShellEjectAt = 0,
    },
    ["fire_iron_masterkey"] = {
        Source = "fire_ads_masterkey",
        Time = 7/30,
        ShellEjectAt = 0,
    },
    ["reload_masterkey"] = {
        Source = "reload_masterkey",
        Time = 56/30,
        MinProgress = 1.1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipin_v1.wav", 		t = 32/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty_masterkey"] = {
        Source = "reload_empty_masterkey",
        Time = 74/30,
        MinProgress = 1.1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_lift_v1.wav", 		t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipout_v1.wav", 	t = 10/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_clipin_v1.wav", 		t = 32/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_masada_reload_chamber_v1.wav", 	t = 52/30},
					},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1.4,
    },

------------------------------------------------
------ Here lies MASTERKEY IN THE ANIMATIONS........... ... AWESOME ---
------------------------------------------------
    ["alt_idle_masterkey"] = {
        Source = "alt_idle_masterkey",
        Time = 1/30
    },
    ["alt_enter_sprint_masterkey"] = {
        Source = "alt_sprint_in_masterkey",
        Time = 10/30
    },
    ["alt_idle_sprint_masterkey"] = {
        Source = "alt_sprint_loop_masterkey",
        Time = 30/40
    },
    ["alt_exit_sprint_masterkey"] = {
        Source = "alt_sprint_out_masterkey",
        Time = 10/30
    },
    ["alt_draw_masterkey"] = {
        Source = "alt_pullout_masterkey",
        Time = 25/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
    },
    ["alt_holster_masterkey"] = {
        Source = "alt_putaway_masterkey",
        Time = 25/30,
    },
    ["alt_fire_masterkey"] = {
        Source = "alt_fire_masterkey",
        Time = 10/30,
    },
    ["alt_cycle_masterkey"] = {
        Source = "alt_cycle_masterkey",
        SoundTable = {{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_pump_v1.wav", 		t = 3/30}},
        Time = 15/30,
    },
    ["alt_reload_start_masterkey"] = {
        Source = "alt_reload_start_masterkey",
        Time = 35/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "weapons/fesiugmw2/foley/wpfoly_shotattach_reload_lift_v1.wav", 		t = 0/30},
						{s = "MW2Common.Masterkey_Load", 		t = 26/30},
					},
    },
    ["alt_reload_loop_masterkey"] = {
        Source = "alt_reload_loop_masterkey",
        Time = 33/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						{s = "MW2Common.Masterkey_Load", 	t = 24/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_shotattach_reload_end_v1.wav", 	t = 33/30}, -- end
					},
    },
    ["alt_reload_finish_masterkey"] = {
        Source = "alt_reload_finish_masterkey",
        Time = 50/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
						--{s = "MW2Common.Masterkey_Load", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_shotattach_reload_end_v1.wav", 	t = 0/30},
						{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_pump_v1.wav", 	t = 22/30},
					},
    },
-----------------------------------------------------
    ["switch2_gun_m203"] = {
        Source = "switch2_gun_m203",
        SoundTable = {{s = "MW2Common.Underbarrel", 		t = 0}},
        Time = 24/30
    },
    ["switch2_alt_m203"] = {
        Source = "switch2_alt_m203",
        SoundTable = {{s = "MW2Common.Underbarrel", 		t = 0}},
        Time = 24/30
    },
    ["switch2_gun_masterkey"] = {
        Source = "switch2_gun_masterkey",
        SoundTable = {{s = "MW2Common.Underbarrel", 		t = 0}},
        Time = 22/30
    },
    ["switch2_alt_masterkey"] = {
        Source = "switch2_alt_masterkey",
        SoundTable = {
						{s = "MW2Common.Underbarrel", 		t = 0},
						{s = "weapons/fesiugmw2/foley/wpfoly_winchester_reload_pump_v1.wav", 		t = 14/30},
					},
        Time = 25/30
    },
}


function SWEP:ChangeFiremode(pred)
    if self:GetNextSecondaryFire() > CurTime() then return end
    if !self.CanBash and !self:GetBuff_Override("Override_CanBash") then return end
    if CLIENT then return end
    local ply = self:GetOwner()
    local tr = util.TraceLine(util.GetPlayerTrace(ply))
    if tr.Hit then
        local effectdata = EffectData()
        effectdata:SetOrigin(tr.HitPos)
        effectdata:SetRadius(50)
        util.Effect("horde_heal_mist", effectdata)

        local attacker = self

        if self.Owner:IsValid() then
            attacker = self.Owner
        end

        for _, ent in pairs(ents.FindInSphere(tr.HitPos, 100)) do
            if ent:IsPlayer() then
                local healinfo = HealInfo:New({amount=20, healer=self.Owner})
                HORDE:OnPlayerHeal(ent, healinfo)
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New({amount=20, healer=self.Owner})
                HORDE:OnAntlionHeal(ent, healinfo)
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage(50)
                dmg:SetDamageType(DMG_NERVEGAS)
                dmg:SetAttacker(self.Owner)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(tr.HitPos)
                ent:TakeDamageInfo(dmg)
            end
        end
    end

    ply:EmitSound("horde/weapons/mp7m/heal.ogg", 125, 100, 1, CHAN_AUTO)

    self:SetNextSecondaryFire(CurTime() + 1.5)
    self:SetNextPrimaryFire(CurTime() + 0.25)
    return true
end

function SWEP:Hook_Think()
    if SERVER then return end
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-20, -20, -8),
        maxs = Vector(20, 20, 8),
        mask = MASK_SHOT_HULL
    })

    if tr.Hit and tr.Entity and tr.Entity:IsPlayer()then
        self.Horde_HealTarget = tr.Entity
    else
        self.Horde_HealTarget = nil
    end
end

local function nv_center(ent)
	return ent:LocalToWorld(ent:OBBCenter())
end

function SWEP:Hook_DrawHUD()
    if self.Horde_HealTarget then
        local pos = nv_center(self.Horde_HealTarget):ToScreen()
		surface.SetDrawColor(Color(50, 200, 50))
        surface.DrawCircle(pos.x, pos.y, 30)
        --surface.DrawLine(pos.x, 0, pos.x, ScrH())
        --surface.DrawLine(0, pos.y, ScrW(), pos.y)
        draw.DrawText(self.Horde_HealTarget:Health(), "Trebuchet24",
        pos.x - 15, pos.y - 15, Color(50, 200, 50), TEXT_ALIGN_LEFT)
    end
end

function SWEP:Hook_PostFireRocket(rocket)
    rocket.ImpactFuse = true
end