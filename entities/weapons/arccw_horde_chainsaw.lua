if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_chainsaw")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_chainsaw", "vgui/hud/arccw_horde_chainsaw", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Chainsaw"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Brrrrrrrrrrrrrrrr"
SWEP.Trivia_Manufacturer = "Top Gear"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "Britain"
SWEP.Trivia_Year = 1949

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.SpeedMult = 0.85
SWEP.Primary.ClipSize = -1

SWEP.ViewModel = "models/horde/weapons/c_chainsaw.mdl"
SWEP.WorldModel = "models/horde/weapons/c_chainsaw.mdl"
SWEP.ViewModelFOV = 45

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 160
SWEP.Melee2Damage = 28

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 80
SWEP.MeleeAttackTime = 0.4
SWEP.MeleeTime = 1.2
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.Melee2 = true
SWEP.Melee2Range = 50
SWEP.Melee2AttackTime = 0
SWEP.Melee2Time = 0.15
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = ""
SWEP.MeleeMissSound = {
    "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
    "horde/weapons/chainsaw/chainsaw_deselect2.ogg"
}
SWEP.MeleeHitSound =
{"horde/weapons/chainsaw/chainsaw_impact_conc1.ogg",
"horde/weapons/chainsaw/chainsaw_impact_conc2.ogg",
"horde/weapons/chainsaw/chainsaw_impact_conc3.ogg",}
SWEP.MeleeHitNPCSound =
{"horde/weapons/chainsaw/chainsaw_impact_flesh1.ogg",
"horde/weapons/chainsaw/chainsaw_impact_flesh2.ogg",
"horde/weapons/chainsaw/chainsaw_impact_flesh3.ogg",}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.AttachmentElements = {
}

SWEP.Attachments = {
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 0.9,
    },
    ["draw"] = {
        Source = "draw",
        Time = 2,
        SoundTable = {
            {
            s = "horde/weapons/chainsaw/Chainsaw_FalseStart1.ogg",
            t = 0.1
            },
        },
    },
    ["bash"] = {
        Source = {"heavyattack1","heavyattack2"},
        Time = 1,
        --[[SoundTable = {
            {
            s = "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
            t = 0.1
            },
            {
            s = "horde/weapons/chainsaw/chainsaw_deselect2.ogg",
            t = 0.1
            },
        },]]--
    },
    ["bash2"] = {
        Source = "attack1",
        Time = 0.3,
        --[[SoundTable = {
            {
            s = "horde/weapons/chainsaw/chainsaw_deselect1.ogg",
            t = 0.1
            },
        },]]--
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(2, 5, -2)
SWEP.ActiveAng = Angle(-0, 0, -0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)