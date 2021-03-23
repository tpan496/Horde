local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddFortify()
    if self.Horde_Fortify == 1 then return end
    self.Horde_Fortify = 1
    timer.Simple(self:Horde_GetFortifyDuration(), function ()
        self:Horde_RemoveFortify()
    end)
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

function plymeta:Horde_GetFortifyDuration()
    return self.Horde_FortifyDuration or 5
end

function plymeta:Horde_GetFortifyEnabled()
    return self.Horde_FortifyEnabled
end

function plymeta:Horde_SetFortifyEnabled(enabled)
    self.Horde_FortifyEnabled = enabled
end

hook.Add("EntityTakeDamage", "Horde_FortifyDamageTaken", function(target, dmg)
    if target:IsPlayer() then
        dmg:ScaleDamage(0.85)
    end
end)

hook.Add("Horde_ResetStatus", "Horde_FortifyReset", function(ply)
    ply.Horde_Fortify = 0
end)