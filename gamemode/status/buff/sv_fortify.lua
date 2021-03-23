local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddFortify(duration)
    timer.Remove("Horde_RemoveFortify" .. self:SteamID())
    timer.Create("Horde_RemoveFortify" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveFortify()
    end)

    if self.Horde_Fortify == 1 then return end

    self.Horde_Fortify = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Fortify, 8)
        net.WriteUInt(1, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveFortify()
    if self.Horde_Fortify == 0 then return end
    self.Horde_Fortify = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Fortify, 8)
        net.WriteUInt(0, 3)
    net.Send(self)
end

function plymeta:Horde_GetFortify()
    return self.Horde_Fortify or 0
end

hook.Add("EntityTakeDamage", "Horde_FortifyDamageTaken", function(target, dmg)
    if target:IsPlayer() and target:Horde_GetFortify() == 1 then
        dmg:ScaleDamage(1 - 0.15 * target:Horde_GetApplyBuffMore())
    end
end)

hook.Add("Horde_ResetStatus", "Horde_FortifyReset", function(ply)
    ply.Horde_Fortify = 0
end)