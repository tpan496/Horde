if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_machete")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_machete", "vgui/hud/arccw_horde_machete", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Machete"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "A Machete that can cut shit."
SWEP.Trivia_Manufacturer = "ArcTech"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 1000

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_machete.mdl"
SWEP.WorldModel = "models/horde/weapons/c_machete.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModelOffset = {
    pos        =    Vector(-15, 6, -7),
    ang        =    Angle(-10, 0, 190),
    bone    =    "ValveBiped.Bip01_R_Hand",
}

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 55
SWEP.Melee2Damage = 105

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 60
SWEP.MeleeAttackTime = 0.3
SWEP.MeleeTime = 0.8
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.5
SWEP.Melee2Time = 1.1
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/machete/machete_swing_miss1.mp3",
    "horde/weapons/machete/machete_swing_miss2.mp3"
}
SWEP.MeleeMissSound = {
    "horde/weapons/machete/machete_swing_miss1.mp3",
    "horde/weapons/machete/machete_swing_miss2.mp3"
}
SWEP.MeleeHitSound = {
    "horde/weapons/machete/machete_impact_world1.mp3",
    "horde/weapons/machete/machete_impact_world2.mp3"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/machete/melee_machete_01.mp3",
    "horde/weapons/machete/melee_machete_02.mp3",
    "horde/weapons/machete/melee_machete_03.mp3"
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
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 0.8,
    },
    ["ready"] = {
        Source = "draw",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"attack1", "attack2", "attack3",},
        Time = 0.8,
    },
    ["bash2"] = {
        Source = "heavyattack",
        Time = 1,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(3, 4, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 0, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)