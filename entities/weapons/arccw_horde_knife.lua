if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_melee_knife")
    killicon.Add("arccw_horde_knife", "arccw/weaponicons/arccw_go_melee_knife", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Bayonet"
SWEP.Trivia_Class = "Knife"
SWEP.Trivia_Desc = "Sharp metal blade for stabbing and slashing. Usually found attached to a firearm."
SWEP.Trivia_Manufacturer = "Cold Steel"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2006

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_knife_bayonet.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_knife_bayonet.mdl"
SWEP.ViewModelFOV = 60

SWEP.WorldModelOffset = {
    pos = Vector(-10, -15, 0),
    ang = Angle(-30, 0, 180 + 90)
}

SWEP.PrimaryBash = true

SWEP.MeleeDamage = 30
SWEP.MeleeRange = 32
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeTime = 0.5
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
SWEP.MeleeAttackTime = 0.1

SWEP.Melee2 = true
SWEP.Melee2Damage = 50
SWEP.Melee2Range = 32
SWEP.Melee2Time = 1
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.Melee2AttackTime = 0.1

SWEP.MeleeSwingSound = {
    "arccw_go/knife/knife_slash1.wav",
    "arccw_go/knife/knife_slash2.wav"
}
SWEP.MeleeHitSound = {
    "arccw_go/knife/knife_hitwall1.wav",
    "arccw_go/knife/knife_hitwall2.wav",
    "arccw_go/knife/knife_hitwall3.wav",
    "arccw_go/knife/knife_hitwall4.wav"
}
SWEP.MeleeHitNPCSound = {
    "arccw_go/knife/knife_hit1.wav",
    "arccw_go/knife/knife_hit2.wav",
    "arccw_go/knife/knife_hit3.wav",
    "arccw_go/knife/knife_hit4.wav",
}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "knife"

SWEP.Primary.ClipSize = -1

SWEP.Animations = {
    ["draw"] = {
        Source = "draw",
        Time = 0.5,
    },
    -- ["idle"] = {
    --     Source = {"idle1", "idle2"}
    -- },
    ["idle"] = false,
    ["bash"] = {
        Source = {"light_hit1", "light_hit2", "light_backstab"},
        Time = 1,
    },
    ["bash2"] = {
        Source = {"heavy_hit1", "heavy_backstab"},
        -- Source = "draw",
        Time = 1.75
    }
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(0, -2, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 5, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(10, -10, 0)

SWEP.HolsterPos = Vector(0, -1, 2)
SWEP.HolsterAng = Angle(-15, 0, 0)