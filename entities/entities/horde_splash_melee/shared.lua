ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Melee Splash"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Model = ""

ENT.splash_dmg = 0
ENT.dmg_type = DMG_CLUB

AddCSLuaFile()

function ENT:Initialize()
    if SERVER then
        self:SetNoDraw(true)
        self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
        timer.Simple(0, function()
            self:MeleeSplash()
        end)
    end
end

function ENT:MeleeSplash()
    if SERVER then
        if !self:IsValid() then return end
        HORDE.RadiusDamageExtra({
            attacker = self.Owner,
            inflictor = self,
            radius = 150,
            falloffradius = 50,
            falloff_cap = 0,
            damage = self.splash_dmg,
            basedamagemul = 0,
            fallofftype = "linear",
            falloff_speed = 1,
            ignoreattacker = true,
            origin = self:GetPos(),
            damagetype = self.dmg_type,
            damagecustomtype = HORDE.DMG_SPLASH,
            antishotgun = true,
        })
        self:Remove()
    end
end

