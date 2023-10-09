local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHypertrophyStack(override_max)
    if not override_max or self:Horde_GetMaxHypertrophyStack() > 0 then
        if self.Horde_HypertrophyStack < self:Horde_GetMaxHypertrophyStack() then
            self:Horde_SetHealthRegenPercentage(self:Horde_GetHealthRegenPercentage() + 0.02)
            self.Horde_HypertrophyStack = self.Horde_HypertrophyStack + 1
        end
    else
        if self.Horde_HypertrophyStack < 2 then
            self:Horde_SetHealthRegenPercentage(self:Horde_GetHealthRegenPercentage() + 0.02)
            self.Horde_HypertrophyStack = self.Horde_HypertrophyStack + 1
        end
    end
    
    self.Horde_HypertrophyStackAdded = true

    timer.Remove("Horde_HypertrophyTracker" .. self:SteamID())
    timer.Create("Horde_HypertrophyTracker" .. self:SteamID(), self:Horde_GetHypertrophyStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_HypertrophyStackAdded = nil
        self:Horde_RemoveHypertrophyStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Hypertrophy, 8)
        net.WriteUInt(self.Horde_HypertrophyStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveHypertrophyStack()
    if not self:IsValid() then return end
    if self.Horde_HypertrophyStack <= 0 then return end
    if self.Horde_HypertrophyStackAdded then return end
    self.Horde_HypertrophyStack = math.max(0, self.Horde_HypertrophyStack - 1)
    self:Horde_SetHealthRegenPercentage(self:Horde_GetHealthRegenPercentage() - 0.02)
    
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Hypertrophy, 8)
        net.WriteUInt(self.Horde_HypertrophyStack, 8)
    net.Send(self)
    timer.Create("Horde_HypertrophyTracker" .. self:SteamID(), self:Horde_GetHypertrophyStackDuration(), 1, function()
        self:Horde_RemoveHypertrophyStack()
    end)
end

function plymeta:Horde_GetHypertrophyStack()
    return self.Horde_HypertrophyStack or 0
end

function plymeta:Horde_SetMaxHypertrophyStack(stack)
    self.Horde_MaxHypertrophyStack = math.max(0, stack)
end

function plymeta:Horde_GetMaxHypertrophyStack()
    return self.Horde_MaxHypertrophyStack or 0
end

function plymeta:Horde_SetHypertrophyStackDuration(duration)
    self.Horde_HypertrophyStackDuration = duration
end

function plymeta:Horde_GetHypertrophyStackDuration()
    return self.Horde_HypertrophyStackDuration or 5
end

function plymeta:Horde_GetHypertrophyEnabled()
    return self.Horde_HypertrophyEnabled
end

function plymeta:Horde_SetHypertrophyEnabled(enabled)
    self.Horde_HypertrophyEnabled = enabled
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_HypertrophyStackDamage", function (ply, dmginfo, bonus)
    if ply:Horde_GetHypertrophyStack() > 0 and HORDE:IsPhysicalDamage(dmginfo) then
        bonus.less = bonus.less * (1 - ply:Horde_GetHypertrophyStack() * 0.05)
    end
end)

hook.Add("Horde_ResetStatus", "Horde_HypertrophyReset", function(ply)
    ply.Horde_HypertrophyStack = 0
    ply.Horde_MaxHypertrophyStack = 0
    ply.Horde_HypertrophyStackDuration = 5
    ply.Horde_HypertrophyStackAdded = nil
end)