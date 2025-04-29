if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_lockpick")
    killicon.Add("arccw_horde_lockpick", "arccw/weaponicons/weapon_lockpick", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true
SWEP.Category = "Horde - Shotguns"
SWEP.AdminOnly = false
SWEP.CamAttachment = 3

SWEP.PrintName = "Lockpick (Horde)"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "Break Action Shotgun."

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_slog_long_ranger.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-8, 3, -4),
    ang = Angle(-10, 0, 180),
    scale = 1.125
}
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFOV = 65

--SWEP.Horde_Locational_DMG = true
SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 0.75,
    [HITGROUP_RIGHTARM] = 0.75,
    [HITGROUP_LEFTLEG] = 0.5,
    [HITGROUP_RIGHTLEG] = 0.5,
}

SWEP.Damage = 50
SWEP.DamageMin = 25
SWEP.Range = 60  -- GAME UNITS * 0.025 = METRES
SWEP.RangeMin = 10  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 2 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 2
SWEP.ReducedClipSize = 2

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 4
SWEP.RecoilSide = 2
SWEP.RecoilPunch = 1.5

SWEP.Delay = 0.009 -- 60 / RPM.
SWEP.Num = 12 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 3,
        PrintName = "Double Shot",
        RunAwayBurst = true
    },
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 50 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 0 -- dispersion that remains even in sights

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 80 -- pitch of shoot sound

SWEP.ShootSound =			"weapons/fesiugmw2/fire/longranger.wav"
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

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.3

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.IronSightStruct = {
    Pos = Vector(-2.8, -1.8, 2.6),
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

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {},
    },
}

SWEP.RejectAttachments = {
    ["go_homemade_auto"] = true, 
    ["go_perk_burst"] = true,
    ["go_perk_rapidfire"] = true
}

SWEP.Attachments = {
	{
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "j_reload",
        Offset = {
            vpos = Vector(-2, 0, 1.9),
            vang = Angle(0, 0, 0),
            wang = Angle(-9.738, 0, 180)
        },
        ExcludeFlags = {"arcticfixyoshit1","cantuseshitinakimboyet"},
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "choke",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(23, 0, 1.44),
            vang = Angle(0, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
        ExcludeFlags = {"arcticfixyoshit1","cantuseshitinakimboyet"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "j_reload",
        Offset = {
            vpos = Vector(0, 0, -0.7),
            vang = Angle(0, 0, 0),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
        SlideAmount = {
            vmin = Vector(-3, 0, -0.7),
            vmax = Vector(2, 0, -0.7),
        },
    ----MergeSlots = {7},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
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
        Slot = "horde_go_shotgun_ammo", --go_ammo
        DefaultAttName = "Dank Buckshot Shells"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
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

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 100/30,
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
        Time = 24/30,
        SoundTable = {{s = "MW2Common.Deploy", 		t = 0}},
    },
    ["holster"] = {
        Source = "putaway",
        Time = 17/30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["fire"] = {
        Source = "fire",
        Time = 12/30,
    },
    ["reload"] = {
        Source = "reload",
        SoundTable = {
                        {s = "weapons/fesiugmw2/foley/wpfoly_ranger_reload_lift_v1.wav", 		t = 0.01},
                        {s = "weapons/fesiugmw2/foley/wpfoly_ranger_reload_open_v1.wav", 		t = 7/30},
                        {s = "weapons/fesiugmw2/foley/wpfoly_ranger_reload_clipout_v1.wav", 		t = 13/30},
                        {s = "weapons/fesiugmw2/foley/wpfoly_ranger_reload_clip1in_v1.wav", 		t = 30/30},
                        {s = "weapons/fesiugmw2/foley/wpfoly_ranger_reload_clip2in_v1.wav", 		t = 41/30},
                        {s = "weapons/fesiugmw2/foley/wpfoly_ranger_reload_chamber_v1.wav", 		t = 63/30},
                    },
        MinProgress = 1.549,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
}

-- notverycreativenowarewe
local nvcnaw = 7
local nvcnaw2 = 3.5

 -- hipfire
 -- maximum accuracy
    SWEP.Inaccuracy_Hip_Max_Stand	= nvcnaw
    SWEP.Inaccuracy_Hip_Max_Duck	= nvcnaw
    SWEP.Inaccuracy_Hip_Max_Prone	= nvcnaw
 -- minimum accuracy
    SWEP.Inaccuracy_Hip_Min_Stand   = nvcnaw2
    SWEP.Inaccuracy_Hip_Min_Duck    = nvcnaw2
    SWEP.Inaccuracy_Hip_Min_Prone   = nvcnaw2

 -- sighted fire
 -- yeah
    SWEP.Inaccuracy_ADS = 5.5

 -- inaccuracy when you're... i don't remember
SWEP.Inaccuracy_Add_ADS			= 0
SWEP.Inaccuracy_Add_Hip			= 0
SWEP.Inaccuracy_Add_Move		= 0.1
--[[
function SWEP:Hook_ShouldNotFireFirst()
    if self:GetCurrentFiremode().Mode == 3 then
        self.Num = 32
        self.AmmoPerShot = 2
    else
        self.Num = 16
        self.AmmoPerShot = 1
    end
end

function SWEP:Hook_ModifyRecoil()
    if self:GetCurrentFiremode().Mode == 3 then
        self.Recoil = 6
        self.RecoilSide = 3
        self.RecoilPunch = 2
    else
        self.Recoil = 4
        self.RecoilSide = 2
        self.RecoilPunch = 1.5
    end
end
]]
