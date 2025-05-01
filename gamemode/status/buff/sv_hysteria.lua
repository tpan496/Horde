local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHysteriaStack()
    if not self:IsValid() or not self:IsPlayer() then return end --Player only buff
    --[[
    if self.Horde_HysteriaRecentlyAdded then
        if timer.Exists("Horde_HysteriaTracker" .. id) then
            timer.Adjust("Horde_HysteriaTracker" .. id, self:Horde_GetHysteriaStackDuration(), nil, nil)
        end
        return
    end
    ]]
    if self:Horde_GetHysteriaStack() < self:Horde_GetMaxHysteriaStack() then
        self.Horde_HysteriaStack = self.Horde_HysteriaStack + 1
    end

    --self:Horde_SetHysteriaEnabled(true)
    --[[
    self.Horde_HysteriaRecentlyAdded = true
    timer.Simple(3, function()
        self.Horde_HysteriaRecentlyAdded = nil
    end)
    ]]
    --self.Horde_HysteriaStackAdded = true
    local id = self:SteamID()
    timer.Remove("Horde_HysteriaTracker" .. id)
    timer.Create("Horde_HysteriaTracker" .. id, self:Horde_GetHysteriaStackDuration(), 1, function()
        if not self:IsValid() then return end
        --self.Horde_HysteriaStackAdded = nil
        self:Horde_RemoveHysteriaStack()
    end)

    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Hysteria, 8)
        net.WriteUInt(self.Horde_HysteriaStack, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveHysteriaStack()
    if not self:IsValid() then return end
    if self:Horde_GetHysteriaStack() <= 0 then return end
    --if self.Horde_HysteriaStackAdded then return end
    self.Horde_HysteriaStack = math.max(0, self.Horde_HysteriaStack - 1)


    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Hysteria, 8)
        net.WriteUInt(self.Horde_HysteriaStack, 8)
    net.Send(self)
    local id = self:SteamID()
    timer.Create("Horde_HysteriaTracker" .. id, self:Horde_GetHysteriaStackDuration(), 1, function()
        self:Horde_RemoveHysteriaStack()
        self.Horde_HysteriaGainedRecently = 0
        --[[
        if self:Horde_GetHysteriaStack() <= 0 then
            self:Horde_SetHysteriaEnabled(nil)
        end
        ]]
    end)
end

function plymeta:Horde_GetHysteriaStack()
    return self.Horde_HysteriaStack or 0
end

function plymeta:Horde_GetMaxHysteriaStack()
    return 5
end

function plymeta:Horde_GetHysteriaStackDuration()
    return 5
end
--[[
function plymeta:Horde_ClearHysteriaStack()
    self.Horde_HysteriaStack = 0
end
]]
function plymeta:Horde_GetHysteriaEnabled()
    return self.Horde_HysteriaEnabled
end

--[[
function plymeta:Horde_SetHysteriaEnabled(enabled)
    self.Horde_HysteriaEnabled = enabled
end
]]

--[[
hook.Add("Horde_OnPlayerDamage", "Horde_HeadhunterDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetHeadHunterEnabled() then return end
    if not HORDE:IsBallisticDamage(dmginfo) then return end
    if not (hitgroup == HITGROUP_HEAD) then return end
    ply:Horde_AddHeadhunterStack()
    if ply:Horde_GetHeadhunterStack() > 0 then
        bonus.increase = bonus.increase + ply:Horde_GetHeadhunterStack() * 0.08
    end
end)
]]
hook.Add("Horde_OnPlayerDebuffApply", "Horde_HysteriaBuildupResist", function (ply, debuff, bonus, inflictor)
    --if not ply:Horde_GetHysteriaEnabled() then return end
    if ply:Horde_GetHysteriaStack() > 0 then
        bonus.less = bonus.less * math.max(0, (1 - (0.1 * ply:Horde_GetHysteriaStack())))
    end
end)


hook.Add("Horde_ResetStatus", "Horde_HysteriaReset", function(ply)
    ply.Horde_HysteriaStack = 0
    ply.Horde_HysteriaGainedRecently = 0
    --ply.Horde_HysteriaStackAdded = nil
end)