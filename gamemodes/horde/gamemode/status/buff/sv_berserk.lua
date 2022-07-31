local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddBerserk(duration)
    timer.Remove("Horde_RemoveBerserk" .. self:SteamID())
    timer.Create("Horde_RemoveBerserk" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveBerserk()
    end)

    if self.Horde_Berserk == 1 then return end

    self.Horde_Berserk = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Berserk, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveBerserk()
    if not self:IsValid() then return end
    if self.Horde_Berserk == 0 then return end
    self.Horde_Berserk = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Berserk, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetBerserk()
    return self.Horde_Berserk or 0
end

hook.Add("Horde_OnPlayerDamage", "Horde_BerserkDamage", function (ply, npc, bonus, hitgroup)
    if ply:Horde_GetBerserk() == 1 then
        bonus.increase = bonus.increase + 0.15 * (1 + ply:Horde_GetApplyBuffMore())
    end
end)

hook.Add("Horde_ResetStatus", "Horde_BerserkReset", function(ply)
    ply.Horde_Berserk = 0
end)