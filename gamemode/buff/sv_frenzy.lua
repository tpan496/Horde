local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddFrenzyCharge()
    self.Horde_FrenzyCharge = self.Horde_FrenzyCharge + 1
end

function plymeta:Horde_RemoveFrenzyCharge()
    self.Horde_FrenzyCharge = self.Horde_FrenzyCharge - 1
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
    return self.Horde_FrenzyChargeDuration
end

-- Call this function to give a frenzy charge stack to a player.
function HORDE:FrenzyCharge(ply)
    ply:Horde_AddFrenzyCharge()
    timer.Simple(ply:Horde_GetFrenzyChargeDuration(), function ()
        ply:Horde_RemoveFrenzyCharge()
    end)
end

hook.Add("Horde_ApplyAdditionalDamage", "Horde_FrenzyChargeDamage", function (ply, increase, more, hitgroup)
    if ply:Horde_GetClass().name ~= "Assault" then return end
    increase = increase + ply:Horde_GetFrenzyCharge() * 5
    return increase, more
end)