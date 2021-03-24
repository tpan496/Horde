local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHealthRegen()
    if self.Horde_HealthRegen == 1 then return end
    self.Horde_HealthRegen = 1
    self.Horde_HealthRegenCurTime = CurTime()
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HealthRegen, 8)
        net.WriteUInt(1, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveHealthRegen()
    if not self:IsValid() then return end
    if self.Horde_HealthRegen == 0 then return end
    self.Horde_HealthRegen = 0
    self.Horde_HealthRegenCurTime = CurTime()
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HealthRegen, 8)
        net.WriteUInt(0, 3)
    net.Send(self)
end

function plymeta:Horde_GetHealthRegen()
    return self.Horde_HealthRegen or 0
end

function plymeta:Horde_SetHealthRegenPercentage(percentage)
    self.Horde_HealthRegenPercentage = percentage
end

function plymeta:Horde_GetHealthRegenPercentage()
    return self.Horde_HealthRegenPercentage or 0.02
end

function plymeta:Horde_GetHealthRegenEnabled()
    return self.Horde_HealthRegenEnabled
end

function plymeta:Horde_SetHealthRegenEnabled(enabled)
    self.Horde_HealthRegenEnabled = enabled
    if enabled then
        self:Horde_AddHealthRegen()
    else
        self:Horde_RemoveHealthRegen()
    end
end

hook.Add("PlayerTick", "Horde_HealthRegen", function(ply, mv)
    if not ply:Horde_GetHealthRegenEnabled() then return end
    if ply:Health() >= ply:GetMaxHealth() then
        ply:Horde_RemoveHealthRegen()
        return
    else
        ply:Horde_AddHealthRegen()
    end
    
    if ply:Horde_GetHealthRegen() == 1 and CurTime() >= ply.Horde_HealthRegenCurTime + 1 then
        ply:SetHealth(math.min(ply:Health() + ply:GetMaxHealth() * ply:Horde_GetHealthRegenPercentage(), ply:GetMaxHealth()))
        ply.Horde_HealthRegenCurTime = CurTime()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_HealthRegenReset", function(ply)
    ply.Horde_HealthRegen = 0
    ply.Horde_HealthRegenCurTime = CurTime()
end)