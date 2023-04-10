local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddIntensityStack(override_max)
    if not override_max or self:Horde_GetMaxIntensityStack() > 0 then
        self.Horde_IntensityStack = math.min(self:Horde_GetMaxIntensityStack(), self.Horde_IntensityStack + 1)
    else
        self.Horde_IntensityStack = math.min(2, self.Horde_IntensityStack + 1)
    end
    self.Horde_IntensityStackAdded = true
    timer.Remove("Horde_IntensityTracker" .. self:SteamID())
    timer.Create("Horde_IntensityTracker" .. self:SteamID(), self:Horde_GetIntensityStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_IntensityStackAdded = nil
        self:Horde_RemoveIntensityStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Intensity, 8)
        net.WriteUInt(self.Horde_IntensityStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveIntensityStack()
    if not self:IsValid() then return end
    if self.Horde_IntensityStack <= 0 then return end
    if self.Horde_IntensityStackAdded then return end
    self.Horde_IntensityStack = math.max(0, self.Horde_IntensityStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Intensity, 8)
        net.WriteUInt(self.Horde_IntensityStack, 8)
    net.Send(self)
    timer.Create("Horde_IntensityTracker" .. self:SteamID(), self:Horde_GetIntensityStackDuration(), 1, function()
        self:Horde_RemoveIntensityStack()
    end)
end

function plymeta:Horde_GetIntensityStack()
    return self.Horde_IntensityStack or 0
end

function plymeta:Horde_SetMaxIntensityStack(stack)
    self.Horde_MaxIntensityStack = math.max(0, stack)
end

function plymeta:Horde_GetMaxIntensityStack()
    return self.Horde_MaxIntensityStack or 0
end

function plymeta:Horde_SetIntensityStackDuration(duration)
    self.Horde_IntensityStackDuration = duration
end

function plymeta:Horde_GetIntensityStackDuration()
    return self.Horde_IntensityStackDuration or 5
end

function plymeta:Horde_GetIntensityEnabled()
    return self.Horde_IntensityEnabled
end

function plymeta:Horde_SetIntensityEnabled(enabled)
    self.Horde_IntensityEnabled = enabled
end

hook.Add("Horde_OnEnemyKilled", "Horde_IntensityApply", function(victim, killer, wpn)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if killer:Horde_GetMaxIntensityStack() <= 0 then return end
    killer:Horde_AddIntensityStack()
    if killer:Horde_GetCardiacResonanceEnabled() then
        for _, ent in pairs(ents.FindInSphere(killer:GetPos(), 200)) do
            if ent:IsValid() and ent:IsPlayer() and ent:Alive() and not (ent:IsBot()) and not (ent == killer) then
                ent:Horde_AddIntensityStack(true)
            end
        end
    end
end)

hook.Add("Horde_OnSpellCooldown", "Horde_IntensityCooldown", function (ply, bonus, spell)
    if ply:Horde_GetMaxIntensityStack() > 0 then
        bonus.less = bonus.less * (1 - 0.08 * ply:Horde_GetIntensityStack())
    end
end)

hook.Add("Horde_MindRegeneration", "Horde_IntensityMindRegen", function (ply, bonus)
    if ply:Horde_GetMaxIntensityStack() > 0 then
        bonus.increase = bonus.increase + 0.08 * ply:Horde_GetIntensityStack()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_IntensityReset", function(ply)
    ply.Horde_IntensityStack = 0
    ply.Horde_MaxIntensityStack = 0
    ply.Horde_IntensityStackDuration = 5
    ply.Horde_IntensityStackAdded = nil
end)
