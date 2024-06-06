local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddFearStack(ply)
    if not self.Horde_FearStack then
        self.Horde_FearStack = 0
    end
    self.Horde_FearStack = math.min(ply:Horde_GetMaxFearStack(), self.Horde_FearStack + 1)
    hook.Run("Horde_PostFearApply", self, ply, HORDE.Status_Fear, self:GetPos(), self.Horde_FearStack)
    self.Horde_FearStackAdded = true
    timer.Remove("Horde_FearTracker" .. self:GetCreationID())
    timer.Create("Horde_FearTracker" .. self:GetCreationID(), self:Horde_GetFearStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_FearStackAdded = nil
        self:Horde_RemoveFearStack()
    end)
end

function entmeta:Horde_RemoveFearStack()
    if not self:IsValid() then return end
    if self.Horde_FearStack <= 0 then return end
    if self.Horde_FearStackAdded then return end
    self.Horde_FearStack = math.max(0, self.Horde_FearStack - 1)
    timer.Create("Horde_FearTracker" .. self:GetCreationID(), self:Horde_GetFearStackDuration(), 1, function()
        self:Horde_RemoveFearStack()
    end)
end

function entmeta:Horde_GetFearStack()
    return self.Horde_FearStack or 0
end

function entmeta:Horde_SetMaxFearStack(stack)
    self.Horde_MaxFearStack = math.max(0, stack)
end

function entmeta:Horde_GetMaxFearStack()
    return self.Horde_MaxFearStack or 0
end

function entmeta:Horde_SetFearStackDuration(duration)
    self.Horde_FearStackDuration = duration
end

function entmeta:Horde_GetFearStackDuration()
    return self.Horde_FearStackDuration or 5
end

function entmeta:Horde_GetFearEnabled()
    return self.Horde_FearEnabled
end

function entmeta:Horde_SetFearEnabled(enabled)
    self.Horde_FearEnabled = enabled
end

hook.Add("Horde_OnPlayerDamage", "Horde_FearStackDamage", function(ply, npc, bonus, hitgroup)
    if npc:Horde_GetFearStack() > 0 then
        bonus.increase = bonus.increase + npc:Horde_GetFearStack() * 0.04
    end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_FearStackDamageTaken", function(ply, dmg, bonus)
    if dmg:GetInflictor() and dmg:GetInflictor():IsNPC() and dmg:GetInflictor():Horde_GetFearStack() > 0 then
        bonus.resistance = bonus.resistance + dmg:GetInflictor():Horde_GetMaxFearStack() * 0.02
    end
end)

hook.Add("Horde_ResetStatus", "Horde_FearReset", function(ply)
    ply.Horde_FearStack = 0
    ply.Horde_MaxFearStack = 0
    ply.Horde_FearStackDuration = 5
    ply.Horde_FearStackAdded = nil
end)
