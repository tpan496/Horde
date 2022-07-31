local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddFortify(duration)
    timer.Remove("Horde_RemoveFortify" .. self:SteamID())
    timer.Create("Horde_RemoveFortify" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveFortify()
    end)

    self.Horde_Fortify = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Fortify, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveFortify()
    if not self:IsValid() then return end
    if self.Horde_Fortify == 0 then return end
    self.Horde_Fortify = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Fortify, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetFortify()
    return self.Horde_Fortify or 0
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_FortifyDamageTaken", function(ply, dmginfo, bonus)
    if ply:Horde_GetFortify() == 1 then
        bonus.less = bonus.less * (1 - 0.20 * (1 + ply:Horde_GetApplyBuffMore()))
    end
end)

hook.Add("Horde_ResetStatus", "Horde_FortifyReset", function(ply)
    ply.Horde_Fortify = 0
end)