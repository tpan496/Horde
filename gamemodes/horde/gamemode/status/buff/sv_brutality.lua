local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddBrutalityStack(override_max)
    self.Horde_BrutalityStack = math.min(self:Horde_GetMaxBrutalityStack(), self.Horde_BrutalityStack + 1)
    self.Horde_BrutalityStackAdded = true
    timer.Remove("Horde_BrutalityTracker" .. self:SteamID())
    timer.Create("Horde_BrutalityTracker" .. self:SteamID(), self:Horde_GetBrutalityStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_BrutalityStackAdded = nil
        self:Horde_RemoveBrutalityStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Brutality, 8)
        net.WriteUInt(self.Horde_BrutalityStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveBrutalityStack()
    if not self:IsValid() then return end
    if self.Horde_BrutalityStack <= 0 then return end
    if self.Horde_BrutalityStackAdded then return end
    self.Horde_BrutalityStack = math.max(0, self.Horde_BrutalityStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Brutality, 8)
        net.WriteUInt(self.Horde_BrutalityStack, 8)
    net.Send(self)
    timer.Create("Horde_BrutalityTracker" .. self:SteamID(), self:Horde_GetBrutalityStackDuration(), 1, function()
        self:Horde_RemoveBrutalityStack()
    end)
end

function plymeta:Horde_GetBrutalityStack()
    return self.Horde_BrutalityStack or 0
end

function plymeta:Horde_SetMaxBrutalityStack(stack)
    self.Horde_MaxBrutalityStack = math.max(0, stack)
end

function plymeta:Horde_GetMaxBrutalityStack()
    return self.Horde_MaxBrutalityStack or 0
end

function plymeta:Horde_SetBrutalityStackDuration(duration)
    self.Horde_BrutalityStackDuration = duration
end

function plymeta:Horde_GetBrutalityStackDuration()
    return self.Horde_BrutalityStackDuration or 5
end

function plymeta:Horde_GetBrutalityEnabled()
    return self.Horde_BrutalityEnabled
end

function plymeta:Horde_SetBrutalityEnabled(enabled)
    self.Horde_BrutalityEnabled = enabled
end

hook.Add("Horde_OnPlayerCriticalCheck", "Horde_BrutalityStackDamage", function (ply, npc, bonus, hitgroup, dmginfo, crit_bonus)
    if ply:Horde_GetBrutalityStack() > 0 then
        crit_bonus.add = crit_bonus.add + 0.1 * ply:Horde_GetBrutalityStack()
        if HORDE:IsMeleeDamage(dmginfo) then
             bonus.increase = bonus.increase + 0.1 * ply:Horde_GetBrutalityStack()
        end
    end
end)

hook.Add("Horde_OnPlayerDamagePost", "Horde_BrutalityApply", function(ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("psycho_brutality") and HORDE:IsMeleeDamage(dmginfo) then
        ply:Horde_AddBrutalityStack()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_BrutalityReset", function(ply)
    ply.Horde_BrutalityStack = 0
    ply.Horde_MaxBrutalityStack = 0
    ply.Horde_BrutalityStackDuration = 5
    ply.Horde_BrutalityStackAdded = nil
end)