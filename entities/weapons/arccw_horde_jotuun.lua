if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_serpent")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_jotuun", "vgui/hud/arccw_horde_serpent", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Melee" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Jötunn"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Spiked mace with ice-related abilities."
SWEP.Trivia_Manufacturer = "Jötunn"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Blunt Weapon"
SWEP.Trivia_Country = "???"
SWEP.Trivia_Year = 0

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_mace.mdl"
SWEP.WorldModel = "models/horde/weapons/c_mace.mdl"
SWEP.ViewModelFOV = 40
SWEP.WorldModelOffset = {
    pos = Vector(-4, 10, -5),
    ang = Angle(90, 0, 180),
    scale = 2
}

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 120
SWEP.Melee2Damage = 100

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 75
SWEP.MeleeAttackTime = 0.5
SWEP.MeleeTime = 0.75
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 75
SWEP.Melee2AttackTime = 0.5
SWEP.Melee2Time = 1.25
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MaximumDurability = 1600
SWEP.MaxHits = 3 -- Change this number to change maximum target hits on the swep
--SWEP.MaxHitsSecondary = 3
SWEP.MeleeBoundingBox = { -- If weapon has no bounding box, it will scale length based on MeleeRange and Melee2Range
    primary = {
        wide = 32,
        tall = 32,
        length = 85, -- 75 length ~ 2.5 meters and MeleeRange = 80 ~ 121 length
    },
    secondary = {
        wide = 8,
        tall = 8,
        length = 125,
    },
}

SWEP.MeleeSwingSound = {
    "horde/weapons/jotuun/attack.ogg",
}
SWEP.MeleeMissSound = {
    "horde/weapons/jotuun/attack.ogg",
}
SWEP.MeleeHitSound = {
    "horde/weapons/jotuun/strike.ogg",
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/jotuun/hit0.ogg",
    "horde/weapons/jotuun/hit1.ogg",
}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

function SWEP:GetCurrentFiremode()
    return {Mode = 1, PrintName = "MELEE"}
end

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
        Source = "first_raise",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"slash1", "slash3"},
        Time = 1.5,
    },
    ["bash2"] = {
        Source = {"slash2"},
        Time = 2,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(0, 5, 0)
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
    local cleave = info.cleave
    local headshot = info.tr.HitGroup
    local melee2 = info.melee2
    
    local frost_dmg = 35
    if melee2 then
        frost_dmg = 150
    end
    local frost_buildup_p = 15
    local frost_buildup_e = frost_dmg * 0.15
    if cleave[1] ~= nil then
        if melee2 then
            for _, entities in ipairs(cleave) do
                if entities:IsNPC() and entities ~= enemy_tr then
                    local e = EffectData()
                    e:SetOrigin(entities:GetPos() + entities:OBBCenter())
                    util.Effect("horde_jotuun_ice_explosion", e)
                end
                for _, ent in pairs(ents.FindInSphere(entities:GetPos(), 75)) do
                    if HORDE:IsPlayerOrMinion(ent) == true then continue end
                    if ent:IsNPC() and ent ~= enemy_tr then
                        if ent.hit_by_frost_dmg_aoe then continue end
                        
                        if not attacker.hit_by_frost_dmg_aoe then
                            attacker:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, frost_buildup_p)
                            attacker.hit_by_frost_dmg_aoe = true
                            timer.Simple(0, function()
                                --if not attacker:IsValid() then return end
                                attacker.hit_by_frost_dmg_aoe = nil
                            end)
                        end
                        
                        ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, frost_buildup_e, attacker)
                        
                        local dmg = DamageInfo()
                            dmg:SetDamage(frost_dmg)
                            dmg:SetDamageType(DMG_REMOVENORAGDOLL)
                            dmg:SetAttacker(attacker)
                            dmg:SetInflictor(self)
                            dmg:SetDamagePosition(ent:GetPos() + ent:OBBCenter())
                            dmg:SetDamageCustom(HORDE.DMG_SPLASH)
                        ent:TakeDamageInfo(dmg)
                        
                        ent.hit_by_frost_dmg_aoe = true
                        timer.Simple(0, function()
                            --if not ent:IsValid() then return end
                            ent.hit_by_frost_dmg_aoe = nil
                        end)
                    end
                end
            end
        else
            for _, entities in ipairs(cleave) do
                if HORDE:IsPlayerOrMinion(entities) == true then continue end
                if entities:IsNPC() and entities ~= enemy_tr then
                    entities:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, frost_buildup_e, attacker)
                    
                    local dmg = DamageInfo()
                        dmg:SetDamage(frost_dmg)
                        dmg:SetDamageType(DMG_REMOVENORAGDOLL)
                        dmg:SetAttacker(attacker)
                        dmg:SetInflictor(self)
                        dmg:SetDamagePosition(entities:GetPos() + entities:OBBCenter())
                        dmg:SetDamageCustom(HORDE.DMG_SPLASH)
                    entities:TakeDamageInfo(dmg)
                end
            end
        end
    end
    if headshot == 1 then
        frost_dmg = frost_dmg * 2
        frost_buildup_e = frost_buildup_e * 2
    end
    if IsValid(enemy_tr) and enemy_tr:IsNPC() then
        local enemy_pos = info.tr.HitPos
        if melee2 then
            if not attacker.hit_by_frost_dmg_aoe then
                attacker:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, frost_buildup_p)
                attacker.hit_by_frost_dmg_aoe = true
                timer.Simple(0, function()
                    --if not attacker:IsValid() then return end
                    attacker.hit_by_frost_dmg_aoe = nil
                end)
            end
            
            enemy_tr:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, frost_buildup_e, attacker)
            
            local e = EffectData()
            e:SetOrigin(enemy_pos + enemy_tr:OBBCenter())
            util.Effect("horde_jotuun_ice_explosion", e)
        end
        
        local dmginfo = DamageInfo()
            dmginfo:SetAttacker(attacker)
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageForce(attacker:GetRight() * -4912 + attacker:GetForward() * 9989)
            dmginfo:SetDamageType(DMG_REMOVENORAGDOLL)
            dmginfo:SetDamagePosition(enemy_pos)
            dmginfo:SetDamage(frost_dmg)
            dmginfo:SetDamageCustom(HORDE.DMG_SPLASH)
        enemy_tr:TakeDamageInfo(dmginfo)
    end
end
