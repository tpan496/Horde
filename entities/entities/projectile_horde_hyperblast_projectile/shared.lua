if CLIENT then
    killicon.Add("projectile_horde_hyperblast_projectile", "materials/perks/overlord/dark_energy_blast.png", Color(255, 255, 255, 255))
end

ENT.Type        = "anim"
ENT.Base        = "base_entity"
ENT.PrintName   = "HE Round"
ENT.Author      = ""
ENT.Information = ""

ENT.Spawnable   = false

AddCSLuaFile()

ENT.Model = "models/effects/combineball.mdl"
ENT.CollisionGroup = COLLISION_GROUP_PLAYER
ENT.CollisionGroupType = COLLISION_GROUP_PLAYER
ENT.Removing = nil
ENT.StartPos = nil
ENT.PlaySoundTimer = 0
ENT.StartTime = 0
ENT.BaseDamage = 25
ENT.BaseSplashDamage = 55
ENT.DirectDamage = 55            -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_CRUSH -- Damage type
ENT.LingeringDuration = 5

function ENT:Draw()
    self:DrawModel()
    self:SetAngles((LocalPlayer():EyePos() - self:GetPos()):Angle())
end

if ! SERVER then return end

function ENT:Initialize()
    self:SetModel(self.Model)
    self:SetModelScale(2)
    self:PhysicsInitSphere(1, "metal_bouncy")
    construct.SetPhysProp(self:GetOwner(), self, 0, self:GetPhysicsObject(),
        { GravityToggle = false, Material = "metal_bouncy" })
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        phys:SetMass(1)
        phys:SetBuoyancyRatio(0)
        phys:EnableDrag(false)
        phys:EnableGravity(false)
    end

    local ply = self:GetOwner()
    self:Horde_AddOverlordPresence()
    if ply:Horde_GetPerk("overlord_dark_energy_blast") then
        self.BaseSplashDamage = self.BaseSplashDamage * 3
        if self.Is_Twinned_Underbarrel then
            self.BaseSplashDamage = self.BaseSplashDamage * 0.5
        end
    end

    if ply:Horde_GetGadget() == "gadget_shotgun_surgeon" then
        self.CollisionGroup = COLLISION_GROUP_PASSABLE_DOOR
        self.CollisionGroupType = COLLISION_GROUP_PASSABLE_DOOR
    end

    timer.Simple(1.5, function() if IsValid(self) then self:Remove() end end)

    self:DrawShadow(false)
    self:ResetSequence("idle")
    self:SetCoreType(true)

    util.SpriteTrail(self, 0, colorWhite, true, 15, 0, 0.1, 1 / 6 * 0.5, "sprites/combineball_trail_black_1.vmt")
end

function ENT:SetCoreType(capture)
    if capture then
        self:SetSubMaterial(0, "models/effects/comball_glow1")
    else
        self:SetSubMaterial(0, "vj_base/effects/comball_glow2")
    end
end

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Charged")
end

function ENT:OnBounce(data, phys)

end

function ENT:PhysicsCollide(data, phys)
    if self.DamageDealt then return end
    local hitEnt = data.HitEntity
    local ply = self:GetOwner()
    if not ply:IsValid() then self:Remove() return end

    if (HORDE:IsEnemy(hitEnt)) or (HORDE:IsPlayerOrMinion(hitEnt) and ply:Horde_GetGadget() == "gadget_shotgun_surgeon") then
        self:DeathEffects()
        return
    end

    self:OnBounce(data, phys)

    local dataF = EffectData()
    dataF:SetOrigin(data.HitPos)
    util.Effect("cball_bounce", dataF)

    dataF = EffectData()
    dataF:SetOrigin(data.HitPos)
    dataF:SetNormal(data.HitNormal)
    dataF:SetScale(5)
    util.Effect("AR2Impact", dataF)
end

local color1 = Color(255, 255, 225, 32)
local color2 = Color(255, 255, 225, 64)
--
function ENT:DeathEffects(data, phys)
    local myPos = self:GetPos()
    effects.BeamRingPoint(myPos, 0.2, 12, 1024, 64, 0, color1,
        { material = "sprites/lgtning.vmt", framerate = 2, flags = 0, speed = 0, delay = 0, spread = 0 })
    effects.BeamRingPoint(myPos, 0.5, 12, 1024, 64, 0, color2,
        { material = "sprites/lgtning.vmt", framerate = 2, flags = 0, speed = 0, delay = 0, spread = 0 })

    local effectData = EffectData()
    effectData:SetOrigin(myPos)
    util.Effect("cball_explode", effectData)

    VJ_EmitSound(self, "weapons/physcannon/energy_sing_explosion2.wav", 150)
    util.ScreenShake(myPos, 20, 150, 1, 1250)

    if self.DamageDealt then return end
    local ply = self:GetOwner()
    local aoe = ply.Horde_OverlordPresence:Horde_GetPresenceRadius()
    for _, ent in pairs(ents.FindInSphere(myPos, aoe)) do
        
        local sData = {
        checkmode = 2,
        originVector = myPos,
        targetEntity = ent,
        advancedCheck = true,
        }
        if(!HORDE.IsInSight(sData)) and not ply.Is_Death_Incarnate_LoS then continue end
        
        if HORDE:IsEnemy(ent) then
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(self.Owner)
            dmginfo:SetInflictor(self)
            dmginfo:SetDamageType(DMG_SONIC)
            dmginfo:SetDamage(math.max(self.BaseSplashDamage, (1 + ent:Horde_GetFearStack()) * self.BaseSplashDamage))
            dmginfo:SetDamageCustom(HORDE.DMG_PLAYER_FRIENDLY)
            dmginfo:SetDamagePosition(ent:GetPos())
            ent:TakeDamageInfo(dmginfo)
        elseif ent:IsPlayer() then
            if ply:Horde_GetGadget() == "gadget_shotgun_surgeon" then
                local healinfo = HealInfo:New({amount = 10, healer = ply})
                HORDE:OnPlayerHeal(ent, healinfo)
            end
        elseif ent:GetClass() == "npc_vj_horde_antlion" then
            if ply:Horde_GetGadget() == "gadget_shotgun_surgeon" then
                local healinfo = HealInfo:New({amount = 10, healer = ply})
                HORDE:OnAntlionHeal(ent, healinfo)
            end
        end 
    end

    self.DamageDealt = true
    self:Remove()
end

function ENT:Draw()
    self:DrawModel()
end
