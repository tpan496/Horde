local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddArmorRegen()
    if self.Horde_ArmorRegen == 1 then return end
    self.Horde_ArmorRegen = 1
    self:Horde_SetArmorRegenCurTime(0)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_ArmorRegen, 8)
        net.WriteUInt(1, 3)
    net.Send(self)
end

function plymeta:Horde_RemoveArmorRegen()
    if self.Horde_ArmorRegen == 0 then return end
    self.Horde_ArmorRegen = 0
    self:Horde_SetArmorRegenCurTime(0)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_ArmorRegen, 8)
        net.WriteUInt(0, 3)
    net.Send(self)
end

function plymeta:Horde_GetArmorRegen()
    return self.Horde_ArmorRegen or 0
end

function plymeta:Horde_GetArmorRegenMax()
    return self.Horde_ArmorRegenMax or 25
end

function plymeta:Horde_SetArmorRegenCurTime(time)
    self.Horde_ArmorRegenCurTime = time
end

function plymeta:Horde_GetArmorRegenCurTime()
    return self.Horde_ArmorRegenCurTime or 0
end

function plymeta:Horde_GetArmorRegenEnabled()
    return self.Horde_ArmorRegenEnabled
end

function plymeta:Horde_SetArmorRegenEnabled(enabled)
    self.Horde_ArmorRegenEnabled = enabled
end

hook.Add("PlayerTick", "Horde_ArmorRegen", function(ply, mv)
    if not ply:Horde_GetArmorRegenEnabled() then return end
    if ply:Armor() >= ply:Horde_GetArmorRegenMax() then return end
    if CurTime() >= ply.Horde_ArmorRegenCurTime + 1 then
        ply:SetArmor(math.min(ply:Armor() + 1, ply:GetMaxArmor()))
        ply.Horde_ArmorRegenCurTime = CurTime()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_ArmorRegenReset", function(ply)
    ply.Horde_ArmorRegen = 0
    ply:Horde_SetArmorRegenCurTime(0)
end)