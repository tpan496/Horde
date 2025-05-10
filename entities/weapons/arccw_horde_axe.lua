if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_axe")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_axe", "vgui/hud/arccw_horde_axe", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Melee" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Fireaxe"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "A Fireaxe, used by the Firemen."
SWEP.Trivia_Manufacturer = "Top Gear"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Sharp Edge"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 1900

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_fireaxe.mdl"
SWEP.WorldModel = "models/horde/weapons/c_fireaxe.mdl"
SWEP.ViewModelFOV = 45
SWEP.WorldModelOffset = {
    pos        =    Vector(-20, 6, -20),
    ang        =    Angle(-60, 50, 110),
    bone    =    "ValveBiped.Bip01_R_Hand",
}

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 80
SWEP.Melee2Damage = 160

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 70
SWEP.MeleeAttackTime = 0.5
SWEP.MeleeTime = 1
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.6
SWEP.Melee2Time = 1.25
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MaximumDurability = 1000
SWEP.MaxHits = 2
SWEP.MeleeBoundingBox = {
    primary = {
        wide = 32,
        tall = 32,
        length = 85, -- 75 length ~ 2.5 meters and MeleeRange = 80 ~ 121 length
    },
    secondary = {
        wide = 16,
        tall = 32,
        length = 100,
    },
}

SWEP.MeleeSwingSound = {
    "horde/weapons/fireaxe/fireaxe_fire01.ogg",
    "horde/weapons/fireaxe/fireaxe_fire02.ogg"
}
SWEP.MeleeMissSound = {
    "horde/weapons/fireaxe/fireaxe_fire01.ogg",
    "horde/weapons/fireaxe/fireaxe_fire02.ogg"
}
SWEP.MeleeHitSound = {
    "horde/weapons/fireaxe/fireaxe_hitwall01.ogg",
    "horde/weapons/fireaxe/fireaxe_hitwall02.ogg"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/fireaxe/fireaxe_hitflesh01.ogg",
    "horde/weapons/fireaxe/fireaxe_hitflesh02.ogg"
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
        Time = 10,
    },
    ["draw"] = {
        Source = "draw",
        Time = 1,
    },
    ["bash"] = {
        Source = {"attack1", "attack2", "attack3"},
        Time = 1.2,
    },
    ["bash2"] = {
        Source = "heavyattack",
        Time = 1.2,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(0, -0, 0)
SWEP.ActiveAng = Angle(0, -90, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)

function SWEP:Hook_HordePostCleaving(info)
    if not SERVER then return end
    local attacker = self:GetOwner()
    if !IsValid(attacker) then return end
    local enemy_tr = info.tr.Entity
    local headshot = info.tr.HitGroup
    local melee2 = info.melee2

    if IsValid(enemy_tr) and enemy_tr:IsNPC() and headshot == 1 and melee2 then
        if enemy_tr:Health() <= 0 then return end
        if enemy_tr.fireaxe_stunned then return end
        if enemy_tr.Horde_Debuff_Cooldown and enemy_tr.Horde_Debuff_Cooldown[HORDE.Status_Stun] then return end
        if enemy_tr.Horde_Stunned then return end
        enemy_tr.fireaxe_stunned = true
        enemy_tr:Horde_AddDebuffBuildup(HORDE.Status_Stun, 500, attacker)
    end
end
