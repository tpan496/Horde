local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddPhalanxStack()
    if self.Horde_PhalanxStack == self:Horde_GetMaxPhalanxStack() then return end
    self.Horde_PhalanxStack = self.Horde_PhalanxStack + 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Phalanx, 8)
        net.WriteUInt(self.Horde_PhalanxStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemovePhalanxStack()
    if not self:IsValid() then return end
    if self.Horde_PhalanxStack == 0 then return end
    self.Horde_PhalanxStack = math.max(0, self.Horde_PhalanxStack - 1)
    if self.Horde_PhalanxStack == 0 then
        self.Horde_PhalanxRegenCooldown = self.Horde_PhalanxRegenTotal + 5
    end
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Phalanx, 8)
        net.WriteUInt(self.Horde_PhalanxStack, 8)
    net.Send(self)
end

function plymeta:Horde_GetPhalanxStack()
    return self.Horde_PhalanxStack or 0
end

function plymeta:Horde_GetMaxPhalanxStack()
    return 5
end

function plymeta:Horde_GetPhalanxStackDuration()
    return 5
end

function plymeta:Horde_ClearPhalanxStack()
    self.Horde_PhalanxStack = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Phalanx, 8)
        net.WriteUInt(self.Horde_PhalanxStack, 8)
    net.Send(self)
end

function plymeta:Horde_GetPhalanxEnabled()
    return self.Horde_PhalanxEnabled
end

function plymeta:Horde_SetPhalanxEnabled(enabled)
    self.Horde_PhalanxEnabled = enabled
    local id = self:SteamID()
    if enabled then
        self.Horde_PhalanxRegenCooldown = 0
        self.Horde_PhalanxRegenTotal = 0
        timer.Create("Horde_PhalanxRegen" .. id, 1, 0, function ()
            self.Horde_PhalanxRegenTotal = self.Horde_PhalanxRegenTotal + 1
            if not self:IsValid() then timer.Remove("Horde_PhalanxRegen" .. id) return end
            if self.Horde_PhalanxRegenCooldown <= self.Horde_PhalanxRegenTotal then
                self:Horde_AddPhalanxStack()
                self.Horde_PhalanxRegenCooldown = self.Horde_PhalanxRegenTotal + 2
            end
        end)
    else
        timer.Remove("Horde_PhalanxRegen" .. id)
        self.Horde_PhalanxStack = 0
        net.Start("Horde_SyncStatus")
            net.WriteUInt(HORDE.Status_Phalanx, 8)
            net.WriteUInt(self.Horde_PhalanxStack, 8)
        net.Send(self)
    end
end

hook.Add("Horde_OnPlayerDamage", "Horde_PhalanxDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPhalanxEnabled() then return end
    if not HORDE:IsPhysicalDamage(dmginfo) then return end
    if ply:Horde_GetPhalanxStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetPhalanxStack() * 0.06
        ply:Horde_RemovePhalanxStack()
    end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_PhalanxDamageTaken", function (ply, dmginfo, bonus)
    if not ply:Horde_GetPhalanxEnabled() then return end
    if ply:Horde_GetPhalanxStack() > 0 and HORDE:IsPhysicalDamage(dmginfo) then
        bonus.resistance = bonus.resistance + ply:Horde_GetPhalanxStack() * 0.06
    end
end)

hook.Add("Horde_ResetStatus", "Horde_PhalanxReset", function(ply)
    ply.Horde_PhalanxStack = 0
end)