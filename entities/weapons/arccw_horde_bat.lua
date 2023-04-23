if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_bat")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_bat", "vgui/hud/arccw_horde_bat", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Bat"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Baseball bat."
SWEP.Trivia_Manufacturer = "James May"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Blunt Weapon"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 2004

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_bat.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 8, -10),
    ang = Angle(20, 0, 180),
    scale = 1,
}
SWEP.WorldModel = "models/horde/weapons/c_bat.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 120
SWEP.Melee2Damage = 160

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 70
SWEP.MeleeAttackTime = 0.15
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 75
SWEP.Melee2AttackTime = 0.6
SWEP.Melee2Time = 1.35
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/bat/bat_swing_miss1.mp3",
    "horde/weapons/bat/bat_swing_miss2.mp3"
}
SWEP.MeleeMissSound = {
    "horde/weapons/bat/bat_swing_miss1.mp3",
    "horde/weapons/bat/bat_swing_miss2.mp3"
}
SWEP.MeleeHitSound = {
    "horde/weapons/bat/bat_impact_world1.mp3",
    "horde/weapons/bat/bat_impact_world2.mp3"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/bat/melee_bat_01.mp3",
    "horde/weapons/bat/melee_bat_02.mp3",
    "horde/weapons/bat/melee_bat_03.mp3"
}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.Primary.ClipSize = -1

SWEP.AttachmentElements = {
}

SWEP.Attachments = {
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "deploy",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"swinghard_n", "swing_w_e_02", "swing_ne2sw_02"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = {"swing_e_w_03"},
        Time = 1.5,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(-0, -1, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)