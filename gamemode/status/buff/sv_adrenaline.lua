local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddAdrenalineStack()
    self.Horde_AdrenalineStack = math.min(self:Horde_GetMaxAdrenalineStack(), self.Horde_AdrenalineStack + 1)
    self.Horde_AdrenalineStackAdded = true
    timer.Remove("Horde_AdrenalineTracker" .. self:SteamID())
    timer.Create("Horde_AdrenalineTracker" .. self:SteamID(), self:Horde_GetAdrenalineStackDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_AdrenalineStackAdded = nil
        self:Horde_RemoveAdrenalineStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Adrenaline, 8)
        net.WriteUInt(self.Horde_AdrenalineStack, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveAdrenalineStack()
    if not self:IsValid() then return end
    if self.Horde_AdrenalineStack <= 0 then return end
    if self.Horde_AdrenalineStackAdded then return end
    self.Horde_AdrenalineStack = math.max(0, self.Horde_AdrenalineStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Adrenaline, 8)
        net.WriteUInt(self.Horde_AdrenalineStack, 3)
    net.Send(self)
    timer.Create("Horde_AdrenalineTracker" .. self:SteamID(), self:Horde_GetAdrenalineStackDuration(), 1, function()
        self:Horde_RemoveAdrenalineStack()
    end)
end

function plymeta:Horde_GetAdrenalineStack()
    return self.Horde_AdrenalineStack or 0
end

function plymeta:Horde_SetMaxAdrenalineStack(stack)
    self.Horde_MaxAdrenalineStack = stack
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

hook.Add("Horde_OnPlayerDamage", "Horde_AdrenalineStackDamage", function (ply, npc, bonus, hitgroup)
    if ply:Horde_GetAdrenalineStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetAdrenalineStack() * 0.06
    end
end)

hook.Add("Horde_PlayerMoveBonus", "Horde_AdrenalineStackMovespeed", function(ply, mv)
    if ply:Horde_GetAdrenalineStack() > 0 then
        local bonus = (1 + ply:Horde_GetAdrenalineStack() * 0.06)
        ply:SetWalkSpeed(ply:Horde_GetClass().movespd * bonus)
        ply:SetRunSpeed(ply:Horde_GetClass().sprintspd * bonus)
    end
end)

hook.Add("Horde_OnEnemyKilled", "Horde_AdrenalineApply", function(victim, killer, wpn)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if killer:Horde_GetMaxAdrenalineStack() <= 0 then return end
    killer:Horde_AddAdrenalineStack()
end)

hook.Add("Horde_ResetStatus", "Horde_AdrenalineReset", function(ply)
    ply.Horde_AdrenalineStack = 0
    ply.Horde_MaxAdrenalineStack = 0
    ply.Horde_AdrenalineStackDuration = 5
    ply.Horde_AdrenalineStackAdded = nil
end)