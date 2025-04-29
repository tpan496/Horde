if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_mjollnir")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_mjollnir", "vgui/hud/arccw_horde_mjollnir", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Horde - Melee" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Mjollnir"
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

SWEP.ViewModel = "models/horde/weapons/v_mjollnir.mdl"
SWEP.WorldModel = "models/horde/weapons/v_mjollnir.mdl"
SWEP.ViewModelFOV = 75

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 140
SWEP.Melee2Damage = 0

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 50
SWEP.MeleeAttackTime = 0.15
SWEP.MeleeTime = 0.8
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 55
SWEP.Melee2AttackTime = 0.1
SWEP.Melee2Time = 0.5
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MaximumDurability = 2000
SWEP.MaxHits = 3
SWEP.MeleeBoundingBox = {
    primary = {
        wide = 12,
        tall = 12,
        length = 110, -- 75 ~ 2.5 meters
    },
    secondary = {
        wide = 12,
        tall = 12,
        length = 110,
    },
}

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
        Source = "idle01",
        Time = 0.9
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"misscenter1", "misscenter2"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = "hitcenter1",
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
    if self.Charged then return end
    self:EmitSound(self.ChargeSound)
    self.Charged = true
    self.ChargeLoopCooldown = CurTime() + 1.25
    self.Mjollner_Charged = true
    local e = EffectData()
    e:SetOrigin(self.Weapon:GetPos())
    e:SetEntity(self.Weapon)
    e:SetRadius(50)
    util.Effect("charged", e)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1.5)
end

function SWEP:Hook_PostBash(info)
    if not self.Charged then return end
    local attacker = self:GetOwner()
    if !IsValid(attacker) then return end
    local enemy_tr = info.tr.Entity
    local cleave = info.cleave
    local headshot = info.tr.HitGroup
    
    if SERVER then
        local shock_dmg = 150
        if cleave[1] ~= nil then
            for _, entities in ipairs(cleave) do
                if entities:IsNPC() and entities ~= enemy_tr then
                    self:LSS(entities:GetPos() + entities:OBBCenter())
                end
                for _, ent in pairs(ents.FindInSphere(entities:GetPos(), 100)) do
                    if HORDE:IsPlayerOrMinion(ent) == true then continue end
                    if ent:IsNPC() and ent ~= enemy_tr then
                        if ent.hit_by_shock_dmg_aoe then continue end
                        local dmg = DamageInfo()
                            dmg:SetDamage(shock_dmg)
                            dmg:SetDamageType(DMG_SHOCK)
                            dmg:SetAttacker(attacker)
                            dmg:SetInflictor(self)
                            dmg:SetDamagePosition(ent:GetPos() + ent:OBBCenter())
                            dmg:SetDamageCustom(HORDE.DMG_SPLASH)
                        ent:TakeDamageInfo(dmg)
                        
                        ent.hit_by_shock_dmg_aoe = true
                        timer.Simple(0, function()
                            --if not ent:IsValid() then return end
                            ent.hit_by_shock_dmg_aoe = nil
                        end)
                    end
                end
            end
        end
        if headshot == 1 then
            shock_dmg = shock_dmg * 2
        end
        if IsValid(enemy_tr) and enemy_tr:IsNPC() then
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
            
            self:LSS(enemy_pos)
        end
    end
    
    if (enemy_tr ~= NULL and !enemy_tr:IsWorld()) or cleave[1] ~= nil then
        self.Charged = nil
        self.Mjollner_Charged = nil
        self.Weapon:EmitSound(self.ChargeHitSound)
        self.Weapon:SetNextSecondaryFire(CurTime() + 1.5)
    end
end

function SWEP:Hook_Think()
    --[[
    if self.Charged then
        ParticleEffectAttach("eml_generic_shock_ligtning", PATTACH_POINT_FOLLOW, self.Weapon, 0)
    end
    ]]
    if self.Charged and self.ChargeLoopCooldown - CurTime() <= 0 then
        self.Weapon:EmitSound(self.ChargeLoopSound)
        self.ChargeLoopCooldown = CurTime() + 3.5
    end
end

function SWEP:LSS(pos)
    if CLIENT then return end
    local LT = ents.Create("info_target")
    local idx = LT:EntIndex()
    LT:SetKeyValue("targetname","mjolner_target_" .. idx)
    LT:SetPos(pos)
    LT:Fire("kill","",0.5)
    LT:Spawn()

    timer.Simple(0.1, function ()
        for i = 1,50 do
            local LA = ents.Create("env_laser")
            LA:SetKeyValue("lasertarget", "mjolner_target_" .. idx)
            LA:SetKeyValue("rendercolor", "0 100 255")
            LA:SetKeyValue("texture", "sprites/laserbeam.spr")
            LA:SetKeyValue("dissolvetype", "1")
            LA:SetKeyValue("width", "2")
            LA:SetKeyValue("damage", "0")
            LA:SetKeyValue("spawnflags", "32")
            LA:SetKeyValue("noiseamplitude", "10")
            LA:SetOwner(self)
            LA:Spawn()
            LA:Fire("Kill","",0.5)
            LA:SetPos(pos + VectorRand() * 100)
        end
    end)
end