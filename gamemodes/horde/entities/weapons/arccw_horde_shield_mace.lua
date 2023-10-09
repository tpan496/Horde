if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_mjollnir")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_mjollnir", "vgui/hud/arccw_horde_mjollnir", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Shield Mace"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Warhammer."
SWEP.Trivia_Manufacturer = "Asgard"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Club Weapon"
SWEP.Trivia_Country = "Asgard"
SWEP.Trivia_Year = 2018

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_shield_mace.mdl"
SWEP.WorldModel = "models/horde/weapons/c_shield_mace.mdl"
SWEP.ViewModelFOV = 100

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 140
SWEP.Melee2Damage = 0

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 50
SWEP.MeleeAttackTime = 0.4
SWEP.MeleeTime = 0.8
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.1
SWEP.Melee2Time = 0.5
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "horde/weapons/mjollnir/swing_1.ogg",
    "horde/weapons/mjollnir/swing_2.ogg"
}
SWEP.MeleeMissSound = {
    "horde/weapons/mjollnir/swing_1.ogg",
    "horde/weapons/mjollnir/swing_2.ogg"
}
SWEP.MeleeHitSound = {
    "horde/weapons/mjollnir/hitwall_1.ogg",
    "horde/weapons/mjollnir/hitwall_2.ogg"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/mjollnir/hitflesh_1.ogg",
    "horde/weapons/mjollnir/hitflesh_2.ogg"
}
SWEP.ChargeSound = Sound("horde/weapons/mjollnir/charge.ogg")
SWEP.ChargeLoopSound = Sound("horde/weapons/mjollnir/charge_loop.ogg")
SWEP.ChargeLoopCooldown = 3.5
SWEP.ChargeHitSound = Sound("ambient/explosions/explode_2.wav")

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
        Time = 1,
    },
    ["bash"] = {
        Source = {"atk_r", "atk_l", "atk_f", "atk_b"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = {"atk_h_r", "atk_h_l", "atk_h_f", "atk_h_b"},
        Time = 0.8,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(2, -6, 4)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)

SWEP.Charged = nil
SWEP.ChargeEffect = nil

function SWEP:SecondaryAttack()
    if self:GetNextSecondaryFire() > CurTime() then return end
	self.Weapon:SetNextSecondaryFire(CurTime() + 1.5)
end

function SWEP:Hook_PostBash(info)
    self.Weapon:SetNextSecondaryFire(CurTime() + 1.5)
end

function SWEP:Hook_Think()

end
