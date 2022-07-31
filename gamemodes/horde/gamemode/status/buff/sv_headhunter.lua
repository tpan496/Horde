local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHeadhunterStack()
    if self.Horde_HeadhunterStack == self:Horde_GetMaxHeadhunterStack() then return end
    self.Horde_HeadhunterStack = self.Horde_HeadhunterStack + 1
    timer.Simple(self:Horde_GetHeadhunterStackDuration(), function ()
        self:Horde_RemoveHeadhunterStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Headhunter, 8)
        net.WriteUInt(self.Horde_HeadhunterStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveHeadhunterStack()
    if not self:IsValid() then return end
    if self.Horde_HeadhunterStack == 0 then return end
    self.Horde_HeadhunterStack = math.max(0, self.Horde_HeadhunterStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Headhunter, 8)
        net.WriteUInt(self.Horde_HeadhunterStack, 8)
    net.Send(self)
end

function plymeta:Horde_GetHeadhunterStack()
    return self.Horde_HeadhunterStack or 0
end

function plymeta:Horde_GetMaxHeadhunterStack()
    return 5
end

function plymeta:Horde_GetHeadhunterStackDuration()
    return 5
end

function plymeta:Horde_ClearHeadhunterStack()
    self.Horde_HeadhunterStack = 0
end

function plymeta:Horde_GetHeadHunterEnabled()
    return self.Horde_HeadhunterEnabled
end

function plymeta:Horde_SetHeadHunterEnabled(enabled)
    self.Horde_HeadhunterEnabled = enabled
end

hook.Add("Horde_OnPlayerDamage", "Horde_HeadhunterDamage", function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetHeadHunterEnabled() then return end
    if not (hitgroup == HITGROUP_HEAD) then return end
    ply:Horde_AddHeadhunterStack()
    if ply:Horde_GetHeadhunterStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetHeadhunterStack() * 0.08
    end
end)

hook.Add("Horde_ResetStatus", "Horde_HeadhunterReset", function(ply)
    ply.Horde_HeadhunterStack = 0
end)