local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddHaste(duration)
    timer.Remove("Horde_RemoveHaste" .. self:SteamID())
    timer.Create("Horde_RemoveHaste" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveHaste()
    end)

    if self.Horde_Haste == 1 then return end

    self.Horde_Haste = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Haste, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveHaste()
    if not self:IsValid() then return end
    if self.Horde_Haste == 0 then return end
    self.Horde_Haste = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Haste, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetHaste()
    return self.Horde_Haste or 0
end

hook.Add("Horde_PlayerMoveBonus", "Horde_HasteMovespeed", function(ply, bonus_walk, bonus_run)
    if ply:Horde_GetHaste() == 1 then
        local bonus2 = 0.15 * (1 + ply:Horde_GetApplyBuffMore())
        bonus_walk.increase = bonus_walk.increase + bonus2
        bonus_run.increase = bonus_run.increase + bonus2
    end
end)

hook.Add("Horde_ResetStatus", "Horde_HasteReset", function(ply)
    ply.Horde_Haste = 0
end)