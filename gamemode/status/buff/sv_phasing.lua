local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddPhasing(duration, callback)
    timer.Remove("Horde_RemovePhasing" .. self:SteamID())
    timer.Create("Horde_RemovePhasing" .. self:SteamID(), duration, 1, function ()
        if !self:IsValid() then return end
        self:Horde_RemovePhasing()
        callback()
    end)

    if self.Horde_Phasing then return end

    self.Horde_Phasing = true
    self:CollisionRulesChanged()
    --[[net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Phasing, 8)
        net.WriteUInt(1, 8)
    net.Send(self)]]--
end

function plymeta:Horde_RemovePhasing()
    if not self:IsValid() then return end
    if !self.Horde_Phasing then return end
    self.Horde_Phasing = nil
    self:CollisionRulesChanged()
    --[[net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Phasing, 8)
        net.WriteUInt(0, 8)
    net.Send(self)]]--
end

function plymeta:Horde_GetPhasing()
    return self.Horde_Phasing
end

hook.Add("Horde_ShouldCollide", "Horde_Phasing_Collide", function (ent1, ent2)
    local ply, npc
    if ent1:IsPlayer() then
        ply = ent1
        npc = ent2
    else
        ply = ent2
        npc = ent1
    end

    if IsValid(npc) and npc:IsNPC() then
        if IsValid(ply) and ply:Horde_GetPhasing() then
            hook.Run("Horde_OnPhasingCollide", ply, npc)
            return false
        else
            return true
        end
    end
end)

hook.Add("Horde_ResetStatus", "Horde_PhasingReset", function(ply)
    ply.Horde_Phasing = nil
end)
