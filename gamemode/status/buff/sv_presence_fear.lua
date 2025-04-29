local entmeta = FindMetaTable("Entity")
local plymeta = FindMetaTable("Player")

function entmeta:Horde_AddOverlordPresence()
    self:Horde_RemoveOverlordPresence()
    local ent = ents.Create("horde_overlord_presence")
    ent:SetPos(self:GetPos())
    ent:SetParent(self)
    
    local ply = self
    if self:GetNWEntity("HordeOwner"):IsPlayer() then
        ply = self:GetNWEntity("HordeOwner")
    elseif self:GetOwner():IsPlayer() then
        ply = self:GetOwner()
    end
    ent:Horde_SetPresenceRadius(ply:Horde_GetOverlordPresenceRadius() * (1 + ply:Horde_GetPerkLevelBonus("overlord_base")) * ply:Horde_CheckOverlordPresence_Paranoia())
    
    ent:Spawn()
    self.Horde_OverlordPresence = ent
end

function entmeta:Horde_RemoveOverlordPresence()
    if not self:IsValid() then return end
    if self.Horde_OverlordPresence and self.Horde_OverlordPresence:IsValid() then
        self.Horde_OverlordPresence:OnRemove()
        self.Horde_OverlordPresence:Remove()
        self.Horde_OverlordPresence = nil
        if self:IsPlayer() then
            timer.Simple(0, function()
                self:Horde_RemoveOverlordPresenceEffects() 
            end)
        end
    end
end

function plymeta:Horde_SetOverlordPresenceRadius(radius)
    self.Horde_OverlordPresenceRadius = radius
end

function plymeta:Horde_GetOverlordPresenceRadius()
    return (self.Horde_OverlordPresenceRadius or 205)
end

----------------- Perk Skills -----------------
----------------- Dispersion -----------------
function plymeta:Horde_SetEnableOverlordPresenceDispersion(enable)
    self.Horde_EnableOverlordPresenceDispersion = enable
end

function plymeta:Horde_GetEnableOverlordPresenceDispersion()
    return self.Horde_EnableOverlordPresenceDispersion or nil
end


----------------- Gadgets -----------------
----------------- Shotgun Surgeon ----------------
function plymeta:Horde_SetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen(enable)
    self.Horde_OverlordPresence_ShotgunSurgeon_HealthRegen = enable
end

function plymeta:Horde_GetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen()
    return self.Horde_OverlordPresence_ShotgunSurgeon_HealthRegen or nil
end

----------------- Presence Upgrades -----------------
--[[
function plymeta:Horde_SetEnableOverlordPresence_Paranoia(enable)
    self.Horde_EnableOverlordPresence_Paranoia = enable
end
]]

function plymeta:Horde_CheckOverlordPresence_Paranoia()
    if self.Horde_Special_Upgrades and self.Horde_Special_Upgrades["module_paranoia"] then
        return 1.5
    else
        return 1
    end
end

function plymeta:Horde_SetEnable_OverlordPresence_Hysteria(enable)
    self.Horde_OverlordPresence_Hysteria = enable
end

function plymeta:Horde_GetEnable_OverlordPresence_Hysteria()
    return self.Horde_OverlordPresence_Hysteria or nil
end

----------------- Enable/Disable Player Skills Buffs -----------------
function plymeta:Horde_AddOverlordPresenceEffects(provider)
    if not provider or not provider:IsValid() then return end
    self.Horde_OverlordPresenceProvider = provider
    if IsValid(provider.Horde_overlord_juxtapose) and provider:Horde_GetGadget() == "gadget_shotgun_surgeon" --[[and self.Horde_OverlordPresence_Buff_CurTime < CurTime()]] then
        self:Horde_SetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen(true)
    else
        self:Horde_SetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen(nil)
    end
    if provider.Horde_Special_Upgrades and provider.Horde_Special_Upgrades["module_hysteria"] --[[and self.Horde_OverlordPresence_Buff_CurTime < CurTime()]] then
        self:Horde_SetEnable_OverlordPresence_Hysteria(true)
    else
        self:Horde_SetEnable_OverlordPresence_Hysteria(nil)
    end
end

function plymeta:Horde_RemoveOverlordPresenceEffects()
    self.Horde_OverlordPresenceProvider = nil
    self:Horde_SetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen(nil)
    self:Horde_SetEnable_OverlordPresence_Hysteria(nil)
end
----------------------------------------------------------------------

hook.Add("PlayerTick", "Horde_OverlordPresence_Buff_CurTime", function(ply, mv)
    --if not ply:Horde_GetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen() and not ply:Horde_GetEnable_OverlordPresence_Hysteria() then return end
    if not ply:Alive() then return end
    if ply.Horde_OverlordPresence_Buff_CurTime + 1 > CurTime() then return end
    
    if ply:Horde_GetEnable_OverlordPresence_ShotgunSurgeon_HealthRegen() then
        local healinfo = HealInfo:New({amount = 1, healer = ply.Horde_OverlordPresenceProvider})
        HORDE:OnPlayerHeal(ply, healinfo, true)
    end
    
    if ply:Horde_GetEnable_OverlordPresence_Hysteria() then
        if ply.Horde_HysteriaGainedRecently >= 2 then
            ply.Horde_HysteriaGainedRecently = 0
            ply:Horde_AddHysteriaStack()
        else
            ply.Horde_HysteriaGainedRecently = ply.Horde_HysteriaGainedRecently + 1
        end
    end
    
    ply.Horde_OverlordPresence_Buff_CurTime = CurTime()
end)

hook.Add("Horde_ResetStatus", "Horde_OverlordPresenceEffectsReset", function(ply)
    ply:Horde_RemoveOverlordPresenceEffects()
    ply.Horde_OverlordPresence_Buff_CurTime = CurTime()
end)

hook.Add("DoPlayerDeath", "Horde_OverlordPresenceDoPlayerDeath", function(victim)
    victim:Horde_RemoveOverlordPresence()
end)
