local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddFrenzyCharge()
    self.Horde_FrenzyCharge = math.min(self.Horde_MaxFrenzyCharge, self.Horde_FrenzyCharge + 1)
    timer.Simple(self:Horde_GetFrenzyChargeDuration(), function ()
        self:Horde_RemoveFrenzyCharge()
    end)
end

function plymeta:Horde_RemoveFrenzyCharge()
    self.Horde_FrenzyCharge = math.max(0, self.Horde_FrenzyCharge - 1)
end

function plymeta:Horde_GetFrenzyCharge()
    return self.Horde_FrenzyCharge
end

function plymeta:Horde_GetMaxFrenzyCharge()
    return self.Horde_MaxFrenzyCharge
end

function plymeta:Horde_SetFrenzyChargeDuration(duration)
    self.Horde_FrenzyChargeDuration = duration
end

function plymeta:Horde_GetFrenzyChargeDuration()
    return self.Horde_FrenzyChargeDuration or 5
end

hook.Add("Horde_ApplyAdditionalDamage", "Horde_FrenzyChargeDamage", function (ply, increase, more, hitgroup)
    increase = increase + ply:Horde_GetFrenzyCharge() * 5
    return increase, more
end)