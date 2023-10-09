local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddSandcloak(duration)
    timer.Remove("Horde_RemoveSandcloak" .. self:SteamID())
    timer.Create("Horde_RemoveSandcloak" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveSandcloak()
    end)

    self.Horde_Sandcloak = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Sandcloak, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveSandcloak()
    if not self:IsValid() then return end
    if self.Horde_Sandcloak == 0 then return end
    self.Horde_Sandcloak = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Sandcloak, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetSandcloak()
    return self.Horde_Sandcloak or 0
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_SandcloakDamageTaken", function(ply, dmginfo, bonus)
    if ply:Horde_GetSandcloak() == 1 then
        bonus.evasion = bonus.evasion + 0.2
    end
end)

hook.Add("Horde_ResetStatus", "Horde_SandcloakReset", function(ply)
    ply.Horde_Sandcloak = 0
end)