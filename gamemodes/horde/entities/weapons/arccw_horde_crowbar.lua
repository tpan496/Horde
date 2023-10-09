if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = Material("items/hl2/weapon_crowbar.png")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.AddAlias("arccw_horde_crowbar", "weapon_crowbar")
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Crowbar"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Crowbar."
SWEP.Trivia_Manufacturer = "James May"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Blunt Weapon"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 2004

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFOV = 55
SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 60
SWEP.Melee2Damage = 90

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 60
SWEP.MeleeAttackTime = 0.15
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.15
SWEP.Melee2Time = 1
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/crowbar/cbar_miss1.wav",
}
SWEP.MeleeMissSound = {
    "horde/weapons/crowbar/cbar_miss1.wav",
}
SWEP.MeleeHitSound = {
    "weapons/crowbar/crowbar_impact1.wav",
    "weapons/crowbar/crowbar_impact2.wav",
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/crowbar/cbar_hitbod1.wav",
    "horde/weapons/crowbar/cbar_hitbod2.wav",
    "horde/weapons/crowbar/cbar_hitbod3.wav",
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
        Source = "idle01",
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"hitcenter1", "hitcenter2", "hitcenter3"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = {"misscenter2", "misscenter1"},
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(-3, -10, 5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)