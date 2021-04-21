local entmeta = FindMetaTable("Entity")
local plymeta = FindMetaTable("Player")

function entmeta:Horde_AddWardenAura()
    self:Horde_RemoveWardenAura()
    local ent = ents.Create("horde_warden_aura")
    ent:SetPos(self:GetPos())
    ent:SetParent(self)
    if self:GetNWEntity("HordeOwner"):IsPlayer() then
        ent:Horde_SetAuraRadius(self:GetNWEntity("HordeOwner"):Horde_GetWardenAuraRadius())
    else
        ent:Horde_SetAuraRadius(self:Horde_GetWardenAuraRadius())
        self:Horde_AddWardenAuraEffects(self)
    end
    ent:Spawn()
    self.Horde_WardenAura = ent
end

function entmeta:Horde_RemoveWardenAura()
    if not self:IsValid() then return end
    if self.Horde_WardenAura then
        self.Horde_WardenAura:Remove()
        self.Horde_WardenAura = nil
        if self:IsPlayer() then
            self:Horde_RemoveWardenAuraEffects()
        end
    end
end

function plymeta:Horde_SetWardenAuraRadius(radius)
    self.Horde_WardenAuraRadius = radius
end

function plymeta:Horde_GetWardenAuraRadius()
    return self.Horde_WardenAuraRadius or 200
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

function plymeta:Horde_SetEnableWardenAuraBuffBonus(enable)
    self.Horde_EnableWardenAuraBuffBonus = enable
end

function plymeta:Horde_GetEnableWardenAuraBuffBonus()
    return self.Horde_EnableWardenAuraBuffBonus
end

function plymeta:Horde_AddWardenAuraEffects(provider)
    if provider:GetClass() == "horde_watchtower" then
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
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_WardenAura, 8)
        net.WriteUInt(1, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveWardenAuraEffects()
    self.Horde_WardenAuraProvider = nil
    self.Horde_WardenAuraDamageBlock = nil
    self.Horde_WardenAuraHealthRegen = nil
    self.Horde_WardenAuraDamageBonus = nil
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_WardenAura, 8)
        net.WriteUInt(0, 3)
    net.Send(self)
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_WardenAuraDamageTaken", function(ply, dmginfo, bonus)
    if ply.Horde_WardenAuraDamageBlock then
        if ply.Horde_WardenAuraProvider.Horde_EnableWardenAuraBuffBonus then
            bonus.block = 6
        else
            bonus.block = 4
        end
    end
end)

hook.Add("PlayerTick", "Horde_WardenAuraHealthRegen", function(ply, mv)
    if not ply.Horde_WardenAuraHealthRegen then return end

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

hook.Add("Horde_OnPlayerDamage", "Horde_WardenAuraDamage", function (ply, npc, bonus, hitgroup)
    if ply.Horde_WardenAuraDamageBonus then
        local amount = 8
        if ply.Horde_WardenAuraProvider.Horde_EnableWardenAuraBuffBonus then
            amount = 12
        end
        bonus.base_add = bonus.base_add + amount
    end
end)

hook.Add("Horde_ResetStatus", "Horde_WardenAuraEffectsReset", function(ply)
    ply.Horde_WardenAuraProvider = nil
    ply.Horde_WardenAuraDamageBlock = nil
    ply.Horde_WardenAuraHealthRegen = nil
    ply.Horde_WardenAuraDamageBonus = nil
    ply.Horde_WardenAuraHealthRegenCurTime = CurTime()
end)