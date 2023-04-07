local plymeta = FindMetaTable("Player")
util.AddNetworkString("Horde_RenderBarrier")

function plymeta:Horde_AddBarrierStack(count)
    if self.Horde_BarrierStack >= self:Horde_GetMaxBarrierStack() then return end
    self.Horde_BarrierStack = math.min(self:Horde_GetMaxBarrierStack(), (self.Horde_BarrierStack or 0) + count)
    local id = self:SteamID64()
    timer.Create("Horde_BarrierDecay" .. id, 1, 0, function ()
        if self:IsValid() then
            self:Horde_RemoveBarrierStack(1)
        else
            timer.Remove("Horde_BarrierDecay" .. id)
        end
    end)
    net.Start("Horde_RenderBarrier")
        net.WriteUInt(self.Horde_BarrierStack, 32)
    net.Send(self)
end

function plymeta:Horde_RemoveBarrierStack(count)
    if not self:IsValid() then return end
    if self.Horde_BarrierStack == 0 then
        local id = self:SteamID64()
        timer.Remove("Horde_BarrierDecay" .. id)
        return
    end
    self.Horde_BarrierStack = math.max(0, self.Horde_BarrierStack - count)
    net.Start("Horde_RenderBarrier")
        net.WriteUInt(self.Horde_BarrierStack, 32)
    net.Send(self)
end

function plymeta:Horde_GetBarrierStack()
    return self.Horde_BarrierStack or 0
end

function plymeta:Horde_GetMaxBarrierStack()
    return 50
end

function plymeta:Horde_GetBarrierStackDuration()
    return 5
end

function plymeta:Horde_ClearBarrierStack()
    self.Horde_BarrierStack = 0
end

hook.Add("Horde_OnPlayerDamageTakenPost", "Horde_BarrierDamage", function (ply, dmginfo, bonus)
    if ply.Horde_BarrierStack <= 0 then return end
    if dmginfo:GetDamage() >= ply.Horde_BarrierStack / 2 then
        dmginfo:SubtractDamage(ply.Horde_BarrierStack / 2)
        ply:Horde_RemoveBarrierStack(ply.Horde_BarrierStack)
    else
        ply:Horde_RemoveBarrierStack(ply.Horde_BarrierStack - dmginfo:GetDamage() * 2)
        dmginfo:SetDamage(0)
    end
end)

hook.Add("Horde_OnPlayerDebuffApply", "Horde_BarrierDebuff", function (ply, debuff, bonus, inflictor, buildup)
    if ply.Horde_BarrierStack <= 0 then return end
    if not buildup then return end
    if buildup >= ply.Horde_BarrierStack * 1.25 then
        bonus.add = -ply.Horde_BarrierStack * 1.25
        ply:Horde_RemoveBarrierStack(ply.Horde_BarrierStack)
    else
        ply:Horde_RemoveBarrierStack(buildup / 1.25)
        bonus.apply = 0
        return true
    end
end)

hook.Add("Horde_ResetStatus", "Horde_BarrierReset", function(ply)
    ply.Horde_BarrierStack = 0
    net.Start("Horde_RenderBarrier")
        net.WriteUInt(ply.Horde_BarrierStack, 32)
    net.Send(ply)
end)