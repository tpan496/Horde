local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddBerserk()
    if self.Horde_Berserk == 1 then return end
    self.Horde_Berserk = 1
    timer.Simple(self:Horde_GetBerserkDuration(), function ()
        self:Horde_RemoveBerserk()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Berserk, 8)
        net.WriteUInt(1, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveBerserk()
    if self.Horde_Berserk == 0 then return end
    self.Horde_Berserk = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Berserk, 8)
        net.WriteUInt(0, 3)
    net.Send(self)
end

function plymeta:Horde_GetBerserk()
    return self.Horde_Berserk or 0
end

function plymeta:Horde_GetBerserkDuration()
    return self.Horde_BerserkDuration or 5
end

function plymeta:Horde_GetBerserkEnabled()
    return self.Horde_BerserkEnabled
end

function plymeta:Horde_SetBerserkEnabled(enabled)
    self.Horde_BerserkEnabled = enabled
end

hook.Add("Horde_ApplyAdditionalDamage", "Horde_AdrenalineStackDamage", function (ply, npc, bonus, hitgroup)
    if ply:Horde_GetBerserk() == 1 then
        bonus.increase = bonus.increase + 0.15
    end
end)

hook.Add("Horde_ResetStatus", "Horde_BerserkReset", function(ply)
    ply.Horde_Berserk = 0
end)