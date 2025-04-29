if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_inferno_blade")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_inferno_blade", "vgui/hud/arccw_horde_inferno_blade", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Melee" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Inferno"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Curved sword imbued with fire energy."
SWEP.Trivia_Manufacturer = "Horzine"
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Slashing Weapon"
SWEP.Trivia_Country = "U.K."
SWEP.Trivia_Year = 2020

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/c_inferno_blade.mdl"
SWEP.WorldModel = "models/horde/weapons/c_inferno_blade.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModelOffset = {
    pos        =    Vector(-10, 8, -5),
    ang        =    Angle(0, 0, 190),
    bone    =    "ValveBiped.Bip01_R_Hand",
}

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 120
SWEP.Melee2Damage = 64

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeRange = 65
SWEP.MeleeAttackTime = 0.1
SWEP.MeleeTime = 0.70
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 65
SWEP.Melee2AttackTime = 0.1
SWEP.Melee2Time = 0.5
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MaximumDurability = 1600
SWEP.MaxHits = 3 -- Change this number to change maximum target hits on the swep
SWEP.MeleeBoundingBox = { -- If weapon has no bounding box, it will scale length based on MeleeRange and Melee2Range
    primary = {
        wide = 12,
        tall = 12,
        length = 110, -- 75 length ~ 2.5 meters and MeleeRange = 80 ~ 121 length
    },
    secondary = {
        wide = 12,
        tall = 12,
        length = 110,
    },
}

SWEP.MeleeSwingSound = {
    "horde/weapons/inferno_blade/swing_00.ogg",
    "horde/weapons/inferno_blade/swing_01.ogg"
}
SWEP.MeleeMissSound = {
    "horde/weapons/inferno_blade/swing_00.ogg",
    "horde/weapons/inferno_blade/swing_01.ogg"
}
SWEP.MeleeHitSound = {
    "horde/weapons/inferno_blade/hit_other_00.ogg",
    "horde/weapons/inferno_blade/hit_other_01.ogg"
}
SWEP.MeleeHitNPCSound = {
    "horde/weapons/inferno_blade/hit_npc_00.ogg",
    "horde/weapons/inferno_blade/hit_npc_01.ogg",
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
        Source = {"melee_swipe2", "melee_swipe3", "melee_swipe4"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = "sprint_out",
        Time = 0.8,
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

SWEP.ChargeSound = Sound("ambient/fire/ignite.wav")
SWEP.ChargeLoopSound = Sound("horde/weapons/inferno_blade/lava_loop.ogg")
SWEP.ChargeLoopCooldown = 0
SWEP.ChargeHitSound = Sound("horde/weapons/inferno_blade/flame.ogg")

SWEP.Client_Charged = nil

SWEP.Immolate_Last = 0

if SERVER then
util.AddNetworkString("Horde_DemonicEdgeCharge")
end

function SWEP:Initialize()
    if SERVER then
        if self.Charged then
            net.Start("Horde_DemonicEdgeCharge")
                net.WriteBool(true)
            net.Send(self.Owner)
        else
            net.Start("Horde_DemonicEdgeCharge")
                net.WriteBool(false)
            net.Send(self.Owner)
        end
    end
end

function SWEP:SecondaryAttack()
    if self:GetNextSecondaryFire() > CurTime() then return end
    if self.Charged then
        self.Charged = nil
        self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
        self.Weapon:SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self.Weapon:SetSubMaterial(4, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self.Owner:GetViewModel():SetSubMaterial(0, "")
        self.Owner:GetViewModel():SetSubMaterial(1, "")
        self.Owner:GetViewModel():SetSubMaterial(2, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_sword_s")
        self.Owner:GetViewModel():SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self:StopSound(self.ChargeLoopSound)
        if SERVER then
            net.Start("Horde_DemonicEdgeCharge")
                net.WriteBool(false)
            net.Send(self.Owner)
        end
    else
        self:EmitSound(self.ChargeSound)
        self.Charged = true
        self.ChargeLoopCooldown = CurTime() + 1.25
        self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
        self.Weapon:SetSubMaterial(4, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self.Owner:GetViewModel():SetSubMaterial(0, "")
        self.Owner:GetViewModel():SetSubMaterial(1, "")
        self.Owner:GetViewModel():SetSubMaterial(2, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self.Owner:GetViewModel():SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        if SERVER then
            net.Start("Horde_DemonicEdgeCharge")
                net.WriteBool(true)
            net.Send(self.Owner)
        end
    end
end

net.Receive("Horde_DemonicEdgeCharge", function ()
    if SERVER then return end
    local charged = net.ReadBool()
    local self = LocalPlayer()
    if charged then
        self:GetWeapon("arccw_horde_inferno_blade"):SetSubMaterial(4, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self:GetViewModel():SetSubMaterial(0, "")
        self:GetViewModel():SetSubMaterial(1, "")
        self:GetViewModel():SetSubMaterial(2, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self:GetViewModel():SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self.Client_Charged = truew
    else
        self:GetWeapon("arccw_horde_inferno_blade"):SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self:GetWeapon("arccw_horde_inferno_blade"):SetSubMaterial(4, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self:GetViewModel():SetSubMaterial(0, "")
        self:GetViewModel():SetSubMaterial(1, "")
        self:GetViewModel():SetSubMaterial(2, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_sword_s")
        self:GetViewModel():SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self.Client_Charged = nil
    end
end)

function SWEP:Hook_PostBash(info)
    if not SERVER then return end
    if not self.Charged then return end
    local attacker = self:GetOwner()
    if !IsValid(attacker) then return end
    local enemy_tr = info.tr.Entity
    local cleave = info.cleave
    local headshot = info.tr.HitGroup
    
    local fire_dmg = 50
    if cleave[1] ~= nil then
        for _, entities in ipairs(cleave) do
            if entities:IsNPC() and entities ~= enemy_tr then
                self:LSS(entities:GetPos() + entities:OBBCenter())
            end
            for _, ent in pairs(ents.FindInSphere(entities:GetPos(), 75)) do
                if HORDE:IsPlayerOrMinion(ent) == true then continue end
                if ent:IsNPC() and ent ~= enemy_tr then
                    if ent.hit_by_fire_dmg_aoe then continue end
                    local dmg = DamageInfo()
                        dmg:SetDamage(fire_dmg)
                        dmg:SetDamageType(DMG_BURN)
                        dmg:SetAttacker(attacker)
                        dmg:SetInflictor(self)
                        dmg:SetDamagePosition(ent:GetPos() + ent:OBBCenter())
                        dmg:SetDamageCustom(HORDE.DMG_SPLASH)
                    ent:TakeDamageInfo(dmg)
                    
                    ent.hit_by_fire_dmg_aoe = true
                    timer.Simple(0, function()
                        --if not ent:IsValid() then return end
                        ent.hit_by_fire_dmg_aoe = nil
                    end)
                end
            end
        end
    end
    if headshot == 1 then
        fire_dmg = fire_dmg * 2
    end
    if IsValid(enemy_tr) and enemy_tr:IsNPC() then
        local enemy_pos = info.tr.HitPos
        local dmginfo = DamageInfo()
            dmginfo:SetAttacker(attacker)
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageForce(attacker:GetRight() * -4912 + attacker:GetForward() * 9989)
            dmginfo:SetDamageType(DMG_BURN)
            dmginfo:SetDamagePosition(enemy_pos)
            dmginfo:SetDamage(fire_dmg)
            dmginfo:SetDamageCustom(HORDE.DMG_SPLASH)
        enemy_tr:TakeDamageInfo(dmginfo)
        
        self:LSS(enemy_pos)
    end
end

function SWEP:Hook_Think()
    --if self.Charged then
    --    ParticleEffectAttach("eml_generic_shock_ligtning", PATTACH_POINT_FOLLOW, self.Weapon, 0)
    --end
    if self.Charged then
        if self.ChargeLoopCooldown <= CurTime() then
            self.Weapon:EmitSound(self.ChargeLoopSound)
            self.ChargeLoopCooldown = CurTime() + 10
        end
        if SERVER and self.Immolate_Last <= CurTime() and self.Owner and self.Owner:IsValid() then
            --[[
            local dmg = DamageInfo()
            dmg:SetDamage(1) 
            dmg:SetDamageType(DMG_BURN)
            dmg:SetAttacker(self.Owner)
            dmg:SetInflictor(self)
            dmg:SetDamagePosition(self:GetPos())
            self.Owner:TakeDamageInfo(dmg)
            ]]
            self.Owner:SetHealth(math.max(1, self.Owner:Health() - 1))
            self.Immolate_Last = CurTime() + 1
        end
    end

    if CLIENT then
    if self.Charged and not self.Client_Charged then
        self.Weapon:SetSubMaterial(4, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self.Owner:GetViewModel():SetSubMaterial(0, "")
        self.Owner:GetViewModel():SetSubMaterial(1, "")
        self.Owner:GetViewModel():SetSubMaterial(2, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self.Owner:GetViewModel():SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s_fire")
        self.Client_Charged = true
    elseif not self.Charged and self.Client_Charged then
        self.Weapon:SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self.Weapon:SetSubMaterial(4, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self.Owner:GetViewModel():SetSubMaterial(0, "")
        self.Owner:GetViewModel():SetSubMaterial(1, "")
        self.Owner:GetViewModel():SetSubMaterial(2, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_sword_s")
        self.Owner:GetViewModel():SetSubMaterial(3, "models/weapons/inferno_blade/mtl_t6_wpn_pulwar_blade_s")
        self.Client_Charged = nil
    end

    if self.Owner.Client_Charged then
        self.dlight = DynamicLight(0)
        self.dlight.Pos = self:GetPos()
        self.dlight.r = 200
        self.dlight.g = 100
        self.dlight.b = 0
        self.dlight.Brightness = 4
        self.dlight.Size = 100
        self.dlight.Decay = 1000
        self.dlight.DieTime = CurTime() + 0.2
    end
    end
end

function SWEP:LSS(pos)
    local effectdata = EffectData()
	effectdata:SetOrigin(pos)
	util.Effect("demonic_edge_hit", effectdata, true, true)
    self.Owner:EmitSound(self.ChargeHitSound, 100, 100, 1, CHAN_WEAPON)
end