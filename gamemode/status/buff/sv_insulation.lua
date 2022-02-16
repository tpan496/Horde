local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddInsulation(duration)
    timer.Remove("Horde_RemoveInsulation" .. self:SteamID())
    timer.Create("Horde_RemoveInsulation" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveInsulation()
    end)

    self.Horde_Insulation = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Insulation, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveInsulation()
    if not self:IsValid() then return end
    if self.Horde_Insulation == 0 then return end
    self.Horde_Insulation = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Insulation, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetInsulation()
    return self.Horde_Insulation or 0
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_InsulationDamageTaken", function(ply, dmginfo, bonus)
    if ply:Horde_GetInsulation() == 1 and HORDE:IsFireDamage(dmginfo) or HORDE:IsColdDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.15
    end
end)

hook.Add("Horde_ResetStatus", "Horde_InsulationReset", function(ply)
    ply.Horde_Insulation = 0
end)