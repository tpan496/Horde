local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddDeadeyeStack()
    if self.Horde_DeadeyeStack == self:Horde_GetMaxDeadeyeStack() then return end
    self.Horde_DeadeyeStack = (self.Horde_DeadeyeStack or 0) + 1
    timer.Simple(self:Horde_GetDeadeyeStackDuration(), function ()
        self:Horde_RemoveDeadeyeStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Deadeye, 8)
        net.WriteUInt(self.Horde_DeadeyeStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveDeadeyeStack()
    if not self:IsValid() then return end
    if self.Horde_DeadeyeStack == 0 then return end
    self.Horde_DeadeyeStack = math.max(0, self.Horde_DeadeyeStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Deadeye, 8)
        net.WriteUInt(self.Horde_DeadeyeStack, 8)
    net.Send(self)
end

function plymeta:Horde_GetDeadeyeStack()
    return self.Horde_DeadeyeStack or 0
end

function plymeta:Horde_GetMaxDeadeyeStack()
    return 5
end

function plymeta:Horde_GetDeadeyeStackDuration()
    return 5
end

function plymeta:Horde_ClearDeadeyeStack()
    self.Horde_DeadeyeStack = 0
end

function plymeta:Horde_GetDeadeyeEnabled()
    return self.Horde_DeadeyeEnabled
end

function plymeta:Horde_SetDeadeyeEnabled(enabled)
    self.Horde_DeadeyeEnabled = enabled
end

hook.Add("Horde_OnPlayerDamage", "Horde_DeadeyeDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetDeadeyeEnabled() then return end
    if hitgroup == HITGROUP_HEAD then
        ply:Horde_AddDeadeyeStack()
    end

    if ply:Horde_GetDeadeyeStack() > 0 and (HORDE:IsCurrentWeapon(dmginfo, "Pistol") == true) then
        bonus.increase = bonus.increase + ply:Horde_GetDeadeyeStack() * 0.05
    end
end)

hook.Add("Horde_ResetStatus", "Horde_DeadeyeReset", function(ply)
    ply.Horde_DeadeyeStack = 0
end)