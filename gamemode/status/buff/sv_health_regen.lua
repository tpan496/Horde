local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHealthRegen()
    if self.Horde_HealthRegen == 1 then return end
    self.Horde_HealthRegen = 1
    self.Horde_HealthRegenCurTime = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HealthRegen, 8)
        net.WriteUInt(1, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveHealthRegen()
    if self.Horde_HealthRegen == 0 then return end
    self.Horde_HealthRegen = 0
    self.Horde_HealthRegenCurTime = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_HealthRegen, 8)
        net.WriteUInt(0, 3)
    net.Send(self)
end

function plymeta:Horde_GetHealthRegen()
    return self.Horde_HealthRegen or 0
end

function plymeta:Horde_GetHealthRegenEnabled()
    return self.Horde_HealthRegenEnabled
end

function plymeta:Horde_SetHealthRegenEnabled(enabled)
    self.Horde_HealthRegenEnabled = enabled
end

hook.Add("PlayerTick", "Horde_HealthRegen", function(ply, mv)
    if not ply:Horde_GetHealthRegenEnabled() then return end
    if ply:Health() >= ply:Horde_GetHealthRegenMax() then return end
    if CurTime() >= ply.Horde_HealthRegenCurTime + 1 then
        ply:SetHealth(math.min(ply:Health() + ply:GetMaxHealth() * 0.02, ply:GetMaxHealth()))
        ply.Horde_HealthRegenCurTime = CurTime()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_HealthRegenReset", function(ply)
    ply.Horde_HealthRegen = 0
end)