local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddSmokescreen()
    timer.Remove("Horde_RemoveSmokescreen" .. self:SteamID())
    timer.Create("Horde_RemoveSmokescreen" .. self:SteamID(), 3, 1, function ()
        self:Horde_RemoveSmokescreen()
    end)

    if self.Horde_Smokescreen == 1 then return end

    self.Horde_Smokescreen = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Smokescreen_Effect, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveSmokescreen()
    if not self:IsValid() then return end
    if self.Horde_Smokescreen == 0 then return end
    self.Horde_Smokescreen = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Smokescreen_Effect, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetSmokescreen()
    return self.Horde_Smokescreen or 0
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_SmokescreenDamageTaken", function (ply, dmginfo, bonus)
    if ply:Horde_GetSmokescreen() == 1 then
        bonus.evasion = bonus.evasion + 0.5
    end
end)

hook.Add("Horde_ResetStatus", "Horde_SmokescreenReset", function(ply)
    ply.Horde_Smokescreen = 0
end)