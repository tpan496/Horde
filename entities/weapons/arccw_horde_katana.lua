if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_katana")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_katana", "vgui/hud/arccw_horde_katana", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Melee" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Katana"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Japanese Sword."
SWEP.Trivia_Manufacturer = "Arasaki"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Slashing Weapon"
SWEP.Trivia_Country = "Japan"
SWEP.Trivia_Year = 2020

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_katana.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 7, -5),
    ang = Angle(-10, 0, 180),
}
SWEP.WorldModel = "models/horde/weapons/c_katana.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 100
SWEP.Melee2Damage = 200

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 75
SWEP.MeleeAttackTime = 0.2
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.Melee2 = true
SWEP.Melee2Range = 80
SWEP.Melee2AttackTime = 0.5
SWEP.Melee2Time = 1.25
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.MaximumDurability = 1200
SWEP.MaxHits = 3 -- Change this number to change maximum target hits on the swep
SWEP.MaxHitsSecondary = 5
SWEP.MeleeBoundingBox = { -- If weapon has no bounding box, it will scale length based on MeleeRange and Melee2Range
    primary = {
        wide = 32,
        tall = 32,
        length = 95, -- 75 length ~ 2.5 meters and MeleeRange = 80 ~ 121 length
    },
    secondary = {
        wide = 32,
        tall = 32,
        length = 95,
    },
}

SWEP.MeleeSwingSound = {
    "horde/weapons/katana/katana_swing_miss1.ogg",
    "horde/weapons/katana/katana_swing_miss2.ogg"
}
SWEP.MeleeMissSound = {
    "horde/weapons/katana/katana_swing_miss1.ogg",
    "horde/weapons/katana/katana_swing_miss2.ogg"
}
SWEP.MeleeHitSound = {
    "horde/weapons/katana/katana_impact_world1.ogg",
    "horde/weapons/katana/katana_impact_world2.ogg"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/katana/melee_katana_01.ogg",
    "horde/weapons/katana/melee_katana_02.ogg",
    "horde/weapons/katana/melee_katana_03.ogg"
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
    ["draw"] = {
        Source = "deploy",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"swing_l", "swing_r2"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = {"swing_l2", "swing_r"},
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

function SWEP:Hook_HordePostCleaving(info)
    if not SERVER then return end
    local attacker = self:GetOwner()
    if !IsValid(attacker) then return end
    local enemy_tr = info.tr.Entity
    local headshot = info.tr.HitGroup
    local melee2 = info.melee2

    if IsValid(enemy_tr) and enemy_tr:IsNPC() and headshot == 1 and melee2 then
        if enemy_tr:Health() <= 0 then return end
        if enemy_tr.katana_ministunned then return end
        if enemy_tr.Horde_Stunned then return end
        enemy_tr.katana_ministunned = true
        
        if not enemy_tr.Base then
            enemy_tr:NextThink(CurTime() + 0.5)
        elseif enemy_tr.Base == "npc_vj_creature_base" or enemy_tr.Base == "npc_vj_human_base" then
            enemy_tr:SetSchedule(SCHED_NPC_FREEZE)
            enemy_tr:NextThink(CurTime() + 0.5)
            enemy_tr.Horde_Stunned = true
            timer.Create("Horde_RemoveStun" .. enemy_tr:GetCreationID(), 0.5, 1, function()
                if not enemy_tr:IsValid() then return end
                enemy_tr:SetCondition(68)
                enemy_tr.Horde_Stunned = nil
            end)
        end
    end
end