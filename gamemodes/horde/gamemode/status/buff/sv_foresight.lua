local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddForesight()
    if self.Horde_Foresight == 1 then return end

    self.Horde_Foresight = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Foresight, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveForesight()
    if not self:IsValid() then return end
    if self.Horde_Foresight == 0 then return end
    self.Horde_Foresight = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Foresight, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetForesight()
    return self.Horde_Foresight or 0
end

function plymeta:Horde_SetForesightEnabled(enabled)
    self.Horde_ForesightEnabled = enabled
end

function plymeta:Horde_GetForesightEnabled()
    return self.Horde_ForesightEnabled or nil
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_ForesightDamage", function (ply, dmginfo, bonus, silent)
    if silent then return end
    if ply:Horde_GetForesightEnabled() and ply:Horde_GetForesight() == 1 and dmginfo:GetAttacker() ~= ply then
        if HORDE:IsPhysicalDamage(dmginfo) then
            bonus.resistance = 1
            local dmg = DamageInfo()
            dmg:SetAttacker(ply)
            dmg:SetInflictor(ply)
            dmg:SetDamageType(DMG_SLASH)
            dmg:SetDamage(dmginfo:GetDamage())
            dmginfo:GetAttacker():TakeDamageInfo(dmg)
            ply:Horde_RemoveForesight()
            timer.Remove("Horde_RestockForesight" .. ply:SteamID())
            timer.Create("Horde_RestockForesight" .. ply:SteamID(), 5, 1, function ()
                ply:Horde_AddForesight()
            end)
        end
    end
end)


hook.Add("Horde_ResetStatus", "Horde_ForesightReset", function(ply)
    ply.Horde_Foresight = 0
    ply.Horde_ForesightEnabled = nil
end)