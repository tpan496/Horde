local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddSolarFluxStack()
    self.Horde_SolarFluxStack = math.min(self:Horde_GetMaxSolarFluxStack(), self.Horde_SolarFluxStack + 1)
    self.Horde_SolarFluxStackAdded = true
    timer.Remove("Horde_SolarFluxTracker" .. self:SteamID())
    timer.Create("Horde_SolarFluxTracker" .. self:SteamID(), self:Horde_GetSolarFluxStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_SolarFluxStackAdded = nil
        self:Horde_RemoveSolarFluxStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_SolarFlux, 8)
        net.WriteUInt(self.Horde_SolarFluxStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveSolarFluxStack()
    if not self:IsValid() then return end
    if self.Horde_SolarFluxStack <= 0 then return end
    if self.Horde_SolarFluxStackAdded then return end
    self.Horde_SolarFluxStack = math.max(0, self.Horde_SolarFluxStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_SolarFlux, 8)
        net.WriteUInt(self.Horde_SolarFluxStack, 8)
    net.Send(self)
    timer.Create("Horde_SolarFluxTracker" .. self:SteamID(), self:Horde_GetSolarFluxStackDuration(), 1, function()
        self:Horde_RemoveSolarFluxStack()
    end)
end

function plymeta:Horde_RemoveAllSolarFluxStacks()
    if not self:IsValid() then return end
    self.Horde_SolarFluxStack = 0
    self.Horde_SolarFluxStackAdded = nil
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_SolarFlux, 8)
        net.WriteUInt(self.Horde_SolarFluxStack, 8)
    net.Send(self)
    timer.Remove("Horde_SolarFluxTracker" .. self:SteamID())
end

function plymeta:Horde_GetSolarFluxStack()
    return self.Horde_SolarFluxStack or 0
end
function plymeta:Horde_GetMaxSolarFluxStack()
    return 5
end

function plymeta:Horde_GetSolarFluxStackDuration()
    return 5
end

hook.Add("Horde_OnPlayerSpellDamage", "Horde_SolarFluxCooldown", function (ply, bonus)
    if ply:Horde_GetSolarFluxStack() > 0 then
        bonus.increase = bonus.increase + 0.08 * ply:Horde_GetSolarFluxStack()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_SolarFluxReset", function(ply)
    ply.Horde_SolarFluxStack = 0
    ply.Horde_SolarFluxStackAdded = nil
end)
