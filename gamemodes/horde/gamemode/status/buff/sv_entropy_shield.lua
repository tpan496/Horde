local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddEntropyShield()
    if self.Horde_EntropyShield == 1 then return end

    self.Horde_EntropyShield = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_EntropyShield, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveEntropyShield()
    if not self:IsValid() then return end
    if self.Horde_EntropyShield == 0 then return end
    self.Horde_EntropyShield = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_EntropyShield, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetEntropyShield()
    return self.Horde_EntropyShield or 0
end

function plymeta:Horde_SetEntropyShieldEnabled(enabled)
    self.Horde_EntropyShieldEnabled = enabled
end

function plymeta:Horde_GetEntropyShieldEnabled()
    return self.Horde_EntropyShieldEnabled or nil
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_EntropyShieldDamage", function (ply, dmginfo, bonus, silent)
    if silent then return end
    if ply:IsValid() and ply:Horde_GetEntropyShieldEnabled() and ply:Horde_GetEntropyShield() == 1 and dmginfo:GetAttacker() ~= ply then
        bonus.resistance = 1
        local dmg = DamageInfo()
        dmg:SetAttacker(ply)
        dmg:SetInflictor(ply)
        dmg:SetDamageType(DMG_BURN)
        dmg:SetDamage(100)
        util.BlastDamageInfo(dmg, ply:GetPos(), 150)
        ply:Horde_RemoveEntropyShield()
        timer.Remove("Horde_RestockEntropyShield" .. ply:SteamID())
        timer.Create("Horde_RestockEntropyShield" .. ply:SteamID(), 5, 1, function ()
            ply:Horde_AddEntropyShield()
        end)
    end
end)


hook.Add("Horde_ResetStatus", "Horde_EntropyShieldReset", function(ply)
    ply.Horde_EntropyShield = 0
    ply.Horde_EntropyShieldEnabled = nil
end)