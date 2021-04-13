local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddMindeyeStack()
    if self.Horde_MindeyeStack == self:Horde_GetMaxMindeyeStack() then return end
    self.Horde_MindeyeStack = self.Horde_MindeyeStack + 1
    timer.Simple(self:Horde_GetMindeyeStackDuration(), function ()
        self:Horde_RemoveMindeyeStack()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Mindeye, 8)
        net.WriteUInt(self.Horde_MindeyeStack, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveMindeyeStack()
    if not self:IsValid() then return end
    if self.Horde_MindeyeStack == 0 then return end
    self.Horde_MindeyeStack = math.max(0, self.Horde_MindeyeStack - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Mindeye, 8)
        net.WriteUInt(self.Horde_MindeyeStack, 3)
    net.Send(self)
end

function plymeta:Horde_GetMindeyeStack()
    return self.Horde_MindeyeStack or 0
end

function plymeta:Horde_GetMaxMindeyeStack()
    return 5
end

function plymeta:Horde_GetMindeyeStackDuration()
    return 5
end

function plymeta:Horde_ClearMindeyeStack()
    self.Horde_MindeyeStack = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Mindeye, 8)
        net.WriteUInt(self.Horde_MindeyeStack, 3)
    net.Send(self)
end

function plymeta:Horde_GetMindeyeEnabled()
    return self.Horde_MindeyeEnabled
end

function plymeta:Horde_SetMindeyeEnabled(enabled)
    self.Horde_MindeyeEnabled = enabled
end

hook.Add("Horde_OnPlayerDamage", "Horde_MindeyeDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetMindeyeEnabled() then return end
    local dmgtype = dmginfo:GetDamageType()
    if not (dmgtype == DMG_SLASH or dmgtype == DMG_CLUB) then return end
    if ply:Horde_GetMindeyeStack() >= ply:Horde_GetMaxMindeyeStack() then
        ply:Horde_ClearMindeyeStack()
    else
        ply:Horde_AddMindeyeStack()
    end
    if ply:Horde_GetMindeyeStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetMindeyeStack() * 0.10
    end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_MindeyeDamageTaken", function (ply, dmginfo, bonus)
    if not ply:Horde_GetMindeyeEnabled() then return end
    if ply:Horde_GetMindeyeStack() > 0 then
        bonus.evasion = bonus.evasion + ply:Horde_GetMindeyeStack() * 0.10
    end
end)

hook.Add("PostEntityTakeDamage", "Horde_MindeyeClearStack", function (ent, dmginfo, took)
    if took and ent:IsPlayer() and ent:Horde_GetMindeyeEnabled() then
        ent:Horde_ClearMindeyeStack()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_MindeyeReset", function(ply)
    ply.Horde_MindeyeStack = 0
end)