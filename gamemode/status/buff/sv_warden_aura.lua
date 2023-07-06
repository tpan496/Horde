local entmeta = FindMetaTable("Entity")
local plymeta = FindMetaTable("Player")

function entmeta:Horde_AddWardenAura()
    self:Horde_RemoveWardenAura()
    local ent = ents.Create("horde_warden_aura")
    ent:SetPos(self:GetPos())
    ent:SetParent(self)
    if self:GetNWEntity("HordeOwner"):IsPlayer() then
        ent:Horde_SetAuraRadius(self:GetNWEntity("HordeOwner"):Horde_GetWardenAuraRadius() * self:GetNWEntity("HordeOwner"):Horde_GetPerkLevelBonus("warden_base"))
    else
        ent:Horde_SetAuraRadius(self:Horde_GetWardenAuraRadius() * self:Horde_GetPerkLevelBonus("warden_base"))
        timer.Simple(0, function() self:Horde_AddWardenAuraEffects(self) end)
    end
    ent:Spawn()
    self.Horde_WardenAura = ent
end

function entmeta:Horde_RemoveWardenAura()
    if not self:IsValid() then return end
    if self.Horde_WardenAura and self.Horde_WardenAura:IsValid() then
        self.Horde_WardenAura:OnRemove()
        self.Horde_WardenAura:Remove()
        self.Horde_WardenAura = nil
        if self:IsPlayer() then
            timer.Simple(0, function() self:Horde_RemoveWardenAuraEffects() end)
        end
    end
end

function plymeta:Horde_SetWardenAuraRadius(radius)
    self.Horde_WardenAuraRadius = radius
end

function plymeta:Horde_GetWardenAuraRadius()
    return (self.Horde_WardenAuraRadius or 160)
end

function plymeta:Horde_SetEnableWardenAuraHealthRegen(enable)
    self.Horde_EnableWardenAuraHealthRegen = enable
end

function plymeta:Horde_GetEnableWardenAuraHealthRegen()
    return self.Horde_EnableWardenAuraHealthRegen or nil
end

function plymeta:Horde_SetEnableWardenAuraDamageBonus(enable)
    self.Horde_EnableWardenAuraDamageBonus = enable
end

function plymeta:Horde_GetEnableWardenAuraDamageBonus()
    return self.Horde_EnableWardenAuraDamageBonus or nil
end

function plymeta:Horde_SetEnableWardenAuraInoculation(enable)
    self.Horde_EnableWardenAuraInoculation = enable
end

function plymeta:Horde_GetEnableWardenAuraInoculation()
    return self.Horde_EnableWardenAuraInoculation or nil
end

function plymeta:Horde_SetEnableWardenAuraBuffBonus(enable)
    self.Horde_EnableWardenAuraBuffBonus = enable
end

function plymeta:Horde_GetEnableWardenAuraBuffBonus()
    return self.Horde_EnableWardenAuraBuffBonus
end

function plymeta:Horde_AddWardenAuraEffects(provider)
    if not provider or not provider:Alive() then return end
    if HORDE:IsWatchTower(provider) then
        self.Horde_WardenAuraProvider = provider:GetNWEntity("HordeOwner")
    else
        self.Horde_WardenAuraProvider = provider
    end
    self.Horde_WardenAuraDamageBlock = true
    if self.Horde_WardenAuraProvider:Horde_GetEnableWardenAuraHealthRegen() then
        self.Horde_WardenAuraHealthRegen = true
    end
    if self.Horde_WardenAuraProvider:Horde_GetEnableWardenAuraDamageBonus() then
        self.Horde_WardenAuraDamageBonus = true
    end
    if self.Horde_WardenAuraProvider:Horde_GetEnableWardenAuraInoculation() then
        self.Horde_WardenAuraInoculation = true
    end
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_WardenAura, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveWardenAuraEffects()
    self.Horde_WardenAuraProvider = nil
    self.Horde_WardenAuraDamageBlock = nil
    self.Horde_WardenAuraHealthRegen = nil
    self.Horde_WardenAuraDamageBonus = nil
    self.Horde_WardenAuraInoculation = nil
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_WardenAura, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
    if self.Horde_WardenAura then
        self:Horde_AddWardenAuraEffects(self)
    end
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_WardenAuraDamageTaken", function(ply, dmginfo, bonus)
    if ply.Horde_WardenAuraDamageBlock then
        if ply.Horde_WardenAuraProvider.Horde_EnableWardenAuraBuffBonus then
            bonus.block = 3
        else
            bonus.block = 2
        end
    end
end)

hook.Add("Horde_OnPlayerDebuffApply", "Horde_WardenAuraInoculation", function (ply, debuff, bonus, inflictor)
    if ply.Horde_WardenAuraInoculation then
        if debuff == HORDE.Status_Ignite or debuff == HORDE.Status_Frostbite or debuff == HORDE.Status_Shock then
            if ply.Horde_WardenAuraProvider.Horde_EnableWardenAuraBuffBonus then
                bonus.less = bonus.less * 0.5
            else
                bonus.less = bonus.less * 0.75
            end
        end
    end
end)

hook.Add("PlayerTick", "Horde_WardenAuraHealthRegen", function(ply, mv)
    if not ply.Horde_WardenAuraHealthRegen then return end
    if not ply:Alive() then return end

    if CurTime() >= ply.Horde_WardenAuraHealthRegenCurTime + 1 then
        local amount = 1
        if ply.Horde_WardenAuraProvider.Horde_EnableWardenAuraBuffBonus then
            amount = 1.5
        end
        local healinfo = HealInfo:New({amount=amount, healer=ply.Horde_WardenAuraProvider})
        HORDE:OnPlayerHeal(ply, healinfo, true)
        ply.Horde_WardenAuraHealthRegenCurTime = CurTime()
    end
end)

hook.Add("Horde_OnPlayerDamage", "Horde_WardenAuraDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if ply.Horde_WardenAuraDamageBonus and dmginfo:GetInflictor():GetClass() ~= "entityflame" and dmginfo:GetDamage() >= 8 then
        local amount = 8
        if ply.Horde_WardenAuraProvider.Horde_EnableWardenAuraBuffBonus then
            amount = 12
        end
        bonus.base_add = bonus.base_add + amount
    end
end)

hook.Add("Horde_ResetStatus", "Horde_WardenAuraEffectsReset", function(ply)
    ply:Horde_RemoveWardenAuraEffects()
    ply.Horde_WardenAuraHealthRegenCurTime = CurTime()
end)

hook.Add("DoPlayerDeath", "Horde_WardenAuraDoPlayerDeath", function(victim)
    victim:Horde_RemoveWardenAura()
end)
