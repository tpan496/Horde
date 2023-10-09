local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddTacticalSpleen()
    if self.Horde_TacticalSpleen == 1 then return end

    self.Horde_TacticalSpleen = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Tactical_Spleen, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveTacticalSpleen()
    if not self:IsValid() then return end
    if self.Horde_TacticalSpleen == 0 then return end
    self.Horde_TacticalSpleen = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Tactical_Spleen, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
    self:ScreenFade(SCREENFADE.IN, Color(50, 50, 200, 10), 0.3, 0)
end

function plymeta:Horde_GetTacticalSpleen()
    return self.Horde_TacticalSpleen or 0
end

function plymeta:Horde_SetTacticalSpleenEnabled(enabled)
    self.Horde_TacticalSpleenEnabled = enabled
end

function plymeta:Horde_GetTacticalSpleenEnabled()
    return self.Horde_TacticalSpleenEnabled or nil
end

hook.Add("Horde_PrePlayerDebuffApply", "Horde_TacticalSpleenNegate", function (ply, debuff)
    if silent then return end
    if ply:IsValid() and ply:Horde_GetTacticalSpleenEnabled() and ply:Horde_GetTacticalSpleen() == 1 then
        ply:Horde_RemoveTacticalSpleen()
        timer.Remove("Horde_RestockTacticalSpleen" .. ply:SteamID())
        timer.Create("Horde_RestockTacticalSpleen" .. ply:SteamID(), 5, 1, function ()
            ply:Horde_AddTacticalSpleen()
        end)
        sound.Play("horde/player/carcass/tactical_spleen.ogg", ply:GetPos())
        return true
    end
end)


hook.Add("Horde_ResetStatus", "Horde_TacticalSpleenReset", function(ply)
    ply.Horde_TacticalSpleen = 0
    ply.Horde_TacticalSpleenEnabled = nil
end)