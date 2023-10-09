if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_zweihander")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_zweihander", "vgui/hud/arccw_horde_zweihander", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Zweihander"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Double hand sword."
SWEP.Trivia_Manufacturer = "Arasaki"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Slashing Weapon"
SWEP.Trivia_Country = "Japan"
SWEP.Trivia_Year = 2020

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_zweihander.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 10, -8),
    ang = Angle(-10, 0, 180),
}
SWEP.WorldModel = "models/horde/weapons/c_zweihander.mdl"
SWEP.ViewModelFOV = 75

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 175
SWEP.Melee2Damage = 350

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 85
SWEP.MeleeAttackTime = 0.5
SWEP.MeleeTime = 1

SWEP.Melee2 = true
SWEP.Melee2Range = 90
SWEP.Melee2AttackTime = 0.75
SWEP.Melee2Time = 1.5

SWEP.MeleeSwingSound = {
    "horde/weapons/zweihander/swing_hard_1.ogg",
    "horde/weapons/zweihander/swing_hard_2.ogg"
}
SWEP.MeleeMissSound = {
    "horde/weapons/zweihander/swing_hard_1.ogg",
    "horde/weapons/zweihander/swing_hard_2.ogg"
}
SWEP.MeleeHitSound = {
    "horde/weapons/katana/katana_impact_world1.ogg",
    "horde/weapons/katana/katana_impact_world2.ogg"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/zweihander/hitflesh_1.ogg",
    "horde/weapons/zweihander/hitflesh_2.ogg",
    "horde/weapons/zweihander/hitflesh_3.ogg"
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
    ["idle"] =  {
        Source = "idle",
    },
    ["equip"] = {
        Source = "draw",
        Time = 0.8,
    },
    ["bash"] = {
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE,
        Source = {"atk_r", "atk_l", "atk_f", "atk_b"},
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["bash2"] = {
        TPAnim = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2,
        Source = {"atk_h_f", "atk_h_b"},
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
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