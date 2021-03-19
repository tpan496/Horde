local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddCamoflague()
    self.Horde_Camoflauge = 1
end

function plymeta:Horde_RemoveCamoflague()
    self.Horde_Camoflauge = 0
end

function plymeta:Horde_GetCamoflague()
    return self.Horde_Camoflauge or 0
end

function plymeta:Horde_SetCamoflagueActivationTime(time)
    self.Horde_CamoflaugeActivationTime = time
end

function plymeta:Horde_GetCamoflagueActivationTime()
    return self.Horde_CamoflaugeActivationTime or 0.5
end

function plymeta:Horde_RemoveCamoflagueOnRun()
    return self.Horde_RemoveCamoflagueOnRun or 1
end

hook.Add("Horde_ApplyAdditionalDamage", "Horde_CamoflagueDamage", function (ply, increase, more, hitgroup)
    return increase, more
end)