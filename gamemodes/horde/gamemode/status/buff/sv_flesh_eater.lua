local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddFleshEater(duration)
    timer.Remove("Horde_RemoveFleshEater" .. self:SteamID())
    timer.Create("Horde_RemoveFleshEater" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveFleshEater()
    end)

    self.Horde_FleshEater = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_FleshEater, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveFleshEater()
    if not self:IsValid() then return end
    if self.Horde_FleshEater == 0 then return end
    self.Horde_FleshEater = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_FleshEater, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetFleshEater()
    return self.Horde_FleshEater or 0
end

hook.Add("Horde_OnPlayerDamagePost", "Horde_FleshEaterDamage", function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetFleshEater() == 1 then
        local leech = math.min(10, dmginfo:GetDamage() * 0.04)
        HORDE:SelfHeal(ply, leech)
    end
end)

hook.Add("Horde_ResetStatus", "Horde_FleshEaterReset", function(ply)
    ply.Horde_FleshEater = 0
end)