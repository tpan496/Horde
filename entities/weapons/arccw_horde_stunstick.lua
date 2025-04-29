if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = Material("items/hl2/weapon_stunstick.png")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.AddAlias("arccw_horde_stunstick", "weapon_stunstick")
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Melee" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Stunstick"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Stunstick."
SWEP.Trivia_Manufacturer = "James May"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Blunt Weapon"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 2004

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ViewModelFOV = 55

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 60
SWEP.Melee2Damage = 80

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 50
SWEP.MeleeAttackTime = 0.15
SWEP.MeleeTime = 0.65
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 50
SWEP.Melee2AttackTime = 0.15
SWEP.Melee2Time = 1
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MaximumDurability = 600
SWEP.MaxHits = 1
SWEP.MaxHitsSecondary = 2
SWEP.MeleeBoundingBox = {
    primary = {
        wide = 8,
        tall = 8,
        length = 100, -- 75 length ~ 2.5 meters and MeleeRange = 80 ~ 121 length
    },
    secondary = {
        wide = 8,
        tall = 8,
        length = 100,
    },
}

SWEP.MeleeSwingSound = {
    "weapons/stunstick/stunstick_swing1.wav",
    "weapons/stunstick/stunstick_swing2.wav",
}
SWEP.MeleeMissSound = {
    "weapons/stunstick/stunstick_swing1.wav",
    "weapons/stunstick/stunstick_swing2.wav",
}
SWEP.MeleeHitSound = {
    "weapons/stunstick/stunstick_impact1.wav",
    "weapons/stunstick/stunstick_impact2.wav",
}
SWEP.MeleeHitNPCSound = {
    "weapons/stunstick/stunstick_fleshhit1.wav",
    "weapons/stunstick/stunstick_fleshhit2.wav",
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

function SWEP:Hook_PostBash(info)
    if not SERVER then return end
    local attacker = self:GetOwner()
    if !IsValid(attacker) then return end
    local enemy_tr = info.tr.Entity
    local cleave = info.cleave
    local headshot = info.tr.HitGroup
    local melee2 = info.melee2

    local shock_dmg = 25
    if melee2 then
        shock_dmg = 35
    end
    local shock_buildup = shock_dmg * 0.8
    if cleave[1] ~= nil then
        for _, entities in ipairs(cleave) do
            if HORDE:IsPlayerOrMinion(entities) == true then continue end
            if entities:IsNPC() and entities ~= enemy_tr then
                entities:Horde_AddDebuffBuildup(HORDE.Status_Shock, shock_buildup, attacker)
                
                local dmg = DamageInfo()
                    dmg:SetDamage(shock_dmg)
                    dmg:SetDamageType(DMG_SHOCK)
                    dmg:SetAttacker(attacker)
                    dmg:SetInflictor(self)
                    dmg:SetDamagePosition(entities:GetPos() + entities:OBBCenter())
                    dmg:SetDamageCustom(HORDE.DMG_SPLASH)
                entities:TakeDamageInfo(dmg)
            end
        end
    end
    if headshot == 1 then
        shock_dmg = shock_dmg * 2
        shock_buildup = shock_buildup * 2
    end

    if IsValid(enemy_tr) and enemy_tr:IsNPC() then
        enemy_tr:Horde_AddDebuffBuildup(HORDE.Status_Shock, shock_buildup, attacker)
        
        local enemy_pos = info.tr.HitPos
        local dmginfo = DamageInfo()
            dmginfo:SetAttacker(attacker)
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageForce(attacker:GetRight() * -4912 + attacker:GetForward() * 9989)
            dmginfo:SetDamageType(DMG_SHOCK)
            dmginfo:SetDamagePosition(enemy_pos)
            dmginfo:SetDamage(shock_dmg)
            dmginfo:SetDamageCustom(HORDE.DMG_SPLASH)
        enemy_tr:TakeDamageInfo(dmginfo)
    end
end

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIcon)

    surface.DrawTexturedRect(x, y, w, w / 2)
end