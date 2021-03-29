if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/weapon_l4d2_baseball_bat")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_bat", "vgui/hud/weapon_l4d2_baseball_bat", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Melee" -- edit this if you like
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

SWEP.ViewModel = "models/horde/weapons/v_bat.mdl"
SWEP.WorldModel = "models/horde/weapons/w_bat.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 135
SWEP.Melee2Damage = 80

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 60
SWEP.MeleeAttackTime = 0.1
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.1
SWEP.Melee2Time = 0.5
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/bat/bat_swing_miss1.wav",
    "horde/weapons/bat/bat_swing_miss2.wav"
}
SWEP.MeleeMissSound = {
    "horde/weapons/bat/bat_swing_miss1.wav",
    "horde/weapons/bat/bat_swing_miss2.wav"
}
SWEP.MeleeHitSound = {
    "horde/weapons/bat/bat_impact_world1.wav",
    "horde/weapons/bat/bat_impact_world2.wav"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/bat/melee_bat_01.wav",
    "horde/weapons/bat/melee_bat_02.wav",
    "horde/weapons/bat/melee_bat_03.wav"
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
        Source = {"swing_e_w_03"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = "secondary_swing",
        Time = 0.8,
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