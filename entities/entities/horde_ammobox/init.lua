AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
ENT.CleanupPriority = 2
ENT.DurabilityRestoreAmount = 0.2 --Max Percentage Restored

function ENT:Initialize()

    self:SetColor(Color(0, 255, 0))
    self:SetModel("models/items/boxmrounds.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)

    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetModelScale(1.5)
    self:SetTrigger(true)
    self:UseTriggerBounds(true, 4)

    self.Removing = false
    self:PhysWake()
end

function ENT:StartTouch(entity)
    if not self.Removing and entity:IsPlayer() and entity:Alive() and not entity:IsBot() then
        local given_ammo = false
        local given_ammo2 = false
        local given_durability = false
        local ply = entity
        for _, wpn in pairs(entity:GetWeapons()) do
            local ammo_id = wpn:GetPrimaryAmmoType()
            local ammo_id2 = wpn:GetSecondaryAmmoType()
            local clip_size2 = wpn:GetMaxClip2()
            
            -- Secondary Magazine size check
            if clip_size2 > 0 then
                clip_size2 = clip_size2
            elseif ammo_id2 >= 1 then
                clip_size2 = 1
            end
            
            -- Melee durability
            if wpn.IsHordeMelee and wpn:GetNWFloat("HORDE_Durability") < wpn.MaximumDurability then
                wpn:SetNWFloat("HORDE_Durability", math.min(wpn:GetNWFloat("HORDE_Durability", 0) + (wpn.MaximumDurability * self.DurabilityRestoreAmount), wpn.MaximumDurability))
				given_durability = true
			end
            
            -- Primary ammo
            if wpn.Primary and wpn.Primary.MaxAmmo then
                if wpn.Primary.MaxAmmo > ply:GetAmmoCount(ammo_id) and ply:GetAmmoCount(ammo_id) >= 0 then
                    local given = HORDE:GiveAmmo(entity, wpn, 1)
                    given_ammo = given_ammo or given
                end
            elseif ply:GetAmmoCount(ammo_id) < 9999 then
                local given = HORDE:GiveAmmo(entity, wpn, 1)
                given_ammo = given_ammo or given
            end
            
            -- Secondary ammo and ArcCW underbarrels
            if wpn.Secondary and wpn.Secondary.MaxAmmo then
                if wpn.Secondary.MaxAmmo > ply:GetAmmoCount(ammo_id2) and ammo_id2 >= 0 then
                    local given2 = ply:GiveAmmo(clip_size2, ammo_id2, false)
                    given_ammo2 = given_ammo2 or given2
                end
            elseif ply:GetAmmoCount(ammo_id2) < 9999 then
                local given2 = ply:GiveAmmo(clip_size2, ammo_id2, false)
                given_ammo2 = given_ammo2 or given2
            end
        end

        if given_ammo or given_ammo2 or given_durability then
            self.Removing = true
            self:Remove()
        end
    end
end