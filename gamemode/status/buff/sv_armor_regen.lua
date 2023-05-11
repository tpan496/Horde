local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddArmorRegen()
    if self.Horde_ArmorRegen == 1 then return end
    self.Horde_ArmorRegen = 1
    self.Horde_ArmorRegenCurTime = CurTime()
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_ArmorRegen, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveArmorRegen()
    if not self:IsValid() then return end
    if self.Horde_ArmorRegen == 0 then return end
    self.Horde_ArmorRegen = 0
    self.Horde_ArmorRegenCurTime = CurTime()
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_ArmorRegen, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetArmorRegen()
    return self.Horde_ArmorRegen or 0
end

function plymeta:Horde_SetArmorRegenAmount(amount)
    self.Horde_ArmorRegenAmount = amount
    if amount <= 0 then
        self:Horde_SetArmorRegenEnabled(nil)
    else
        self:Horde_SetArmorRegenEnabled(true)
    end
end

function plymeta:Horde_GetArmorRegenAmount(amount)
    return self.Horde_ArmorRegenAmount or 1
end

function plymeta:Horde_SetArmorRegenMax(max)
    self.Horde_ArmorRegenMax = math.max(0, max)
end

function plymeta:Horde_GetArmorRegenMax()
    return self.Horde_ArmorRegenMax or 0
end

function plymeta:Horde_GetArmorRegenEnabled()
    return self.Horde_ArmorRegenEnabled
end

function plymeta:Horde_SetArmorRegenEnabled(enabled)
    self.Horde_ArmorRegenEnabled = enabled
    if enabled then
        self:Horde_AddArmorRegen()
    else
        self:Horde_RemoveArmorRegen()
    end
end

hook.Add("PlayerTick", "Horde_ArmorRegen", function(ply, mv)
    if not ply:Horde_GetArmorRegenEnabled() or not ply:Alive() then return end
    if ply:Armor() >= ply:GetMaxArmor() * ply:Horde_GetArmorRegenMax() then
        ply:Horde_RemoveArmorRegen()
        return
    else
        ply:Horde_AddArmorRegen()
    end
    
    if ply:Horde_GetArmorRegen() == 1 and CurTime() >= ply.Horde_ArmorRegenCurTime + 1 then
        ply:SetArmor(math.min(ply:Armor() + ply:Horde_GetArmorRegenAmount(), ply:GetMaxArmor() * ply:Horde_GetArmorRegenMax()))
        ply.Horde_ArmorRegenCurTime = CurTime()
    end
end)

hook.Add("Horde_ResetStatus", "Horde_ArmorRegenReset", function(ply)
    ply.Horde_ArmorRegen = 0
    ply.Horde_ArmorRegenAmount = 1
    ply.Horde_ArmorRegenCurTime = CurTime()
end)