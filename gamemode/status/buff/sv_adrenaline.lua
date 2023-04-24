local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddAdrenalineStack(override_max)
    if not override_max or self:Horde_GetMaxAdrenalineStack() > 0 then
        self.Horde_AdrenalineStack = math.min(self:Horde_GetMaxAdrenalineStack(), self.Horde_AdrenalineStack + 1)
    else
        self.Horde_AdrenalineStack = math.min(2, self.Horde_AdrenalineStack + 1)
    end
    self.Horde_AdrenalineStackAdded = true
    timer.Remove("Horde_AdrenalineTracker" .. self:SteamID())
    timer.Create("Horde_AdrenalineTracker" .. self:SteamID(), self:Horde_GetAdrenalineStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_AdrenalineStackAdded = nil
        self:Horde_RemoveAdrenalineStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Adrenaline, 8)
        net.WriteUInt(self.Horde_AdrenalineStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveAdrenalineStack()
    if not self:IsValid() then return end
    if self.Horde_AdrenalineStack <= 0 then return end
    if self.Horde_AdrenalineStackAdded then return end
    self.Horde_AdrenalineStack = math.max(0, self.Horde_AdrenalineStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Adrenaline, 8)
        net.WriteUInt(self.Horde_AdrenalineStack, 8)
    net.Send(self)
    timer.Create("Horde_AdrenalineTracker" .. self:SteamID(), self:Horde_GetAdrenalineStackDuration(), 1, function()
        self:Horde_RemoveAdrenalineStack()
    end)
end

function plymeta:Horde_GetAdrenalineStack()
    return self.Horde_AdrenalineStack or 0
end

function plymeta:Horde_SetMaxAdrenalineStack(stack)
    self.Horde_MaxAdrenalineStack = math.max(0, stack)
end

function plymeta:Horde_GetMaxAdrenalineStack()
    return self.Horde_MaxAdrenalineStack or 0
end

function plymeta:Horde_SetAdrenalineStackDuration(duration)
    self.Horde_AdrenalineStackDuration = duration
end

function plymeta:Horde_GetAdrenalineStackDuration()
    return self.Horde_AdrenalineStackDuration or 5
end

function plymeta:Horde_GetAdrenalineEnabled()
    return self.Horde_AdrenalineEnabled
end

function plymeta:Horde_SetAdrenalineEnabled(enabled)
    self.Horde_AdrenalineEnabled = enabled
end

function plymeta:Horde_GetCardiacResonanceEnabled()
    if not self:IsValid() then return end
    return self.Horde_CardiacResonanceEnabled
end

function plymeta:Horde_SetCardiacResonanceEnabled(enabled)
    self.Horde_CardiacResonanceEnabled = enabled
end

hook.Add("Horde_OnPlayerDamage", "Horde_AdrenalineStackDamage", function (ply, npc, bonus, hitgroup)
    if ply:Horde_GetAdrenalineStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetAdrenalineStack() * 0.06
    end
end)

hook.Add("Horde_PlayerMoveBonus", "Horde_AdrenalineStackMovespeed", function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetAdrenalineStack() > 0 then
        local bonus2 = ply:Horde_GetAdrenalineStack() * 0.06
        bonus_walk.increase = bonus_walk.increase + bonus2
        bonus_run.increase = bonus_run.increase + bonus2
    end
end)

hook.Add("Horde_OnEnemyKilled", "Horde_AdrenalineApply", function(victim, killer, wpn)
    if killer:Horde_GetMaxAdrenalineStack() <= 0 then return end
    killer:Horde_AddAdrenalineStack()
    if killer:Horde_GetCardiacResonanceEnabled() then
        for _, ent in pairs(ents.FindInSphere(killer:GetPos(), 200)) do
            if ent:IsValid() and ent:IsPlayer() and ent:Alive() and not (ent:IsBot()) and not (ent == killer) then
                ent:Horde_AddAdrenalineStack(true)
            end
        end
    end
end)

hook.Add("Horde_ResetStatus", "Horde_AdrenalineReset", function(ply)
    ply.Horde_AdrenalineStack = 0
    ply.Horde_MaxAdrenalineStack = 0
    ply.Horde_AdrenalineStackDuration = 5
    ply.Horde_AdrenalineStackAdded = nil
end)