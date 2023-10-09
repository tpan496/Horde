local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddCamoflague()
    if self.Horde_Camoflague == 1 then return end
    self.Horde_Camoflague = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Camoflague, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveCamoflague()
    if self.Horde_In_Optical_Camouflage then return end
    if not self:IsValid() then return end
    if self.Horde_Camoflague == 0 then return end
    self.Horde_Camoflague = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Camoflague, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetCamoflague()
    return self.Horde_Camoflague or 0
end

function plymeta:Horde_SetCamoflagueActivationTime(time)
    self.Horde_CamoflagueActivationTime = time
end

function plymeta:Horde_GetCamoflagueActivationTime()
    return self.Horde_CamoflagueActivationTime or 0.5
end

function plymeta:Horde_SetRemoveCamoflagueOnRun(remove)
    self.Horde_RemoveCamoflagueOnRun = remove
end

function plymeta:Horde_GetRemoveCamoflagueOnRun()
    return self.Horde_RemoveCamoflagueOnRun or 1
end

function plymeta:Horde_SetRemoveCamoflagueOnAttack(remove)
    self.Horde_RemoveCamoflagueOnAttack = remove
end

function plymeta:Horde_GetRemoveCamoflagueOnAttack()
    return self.Horde_RemoveCamoflagueOnAttack or 1
end

function plymeta:Horde_GetCamoflagueEnabled()
    return self.Horde_CamoflagueEnabled
end

function plymeta:Horde_SetCamoflagueEnabled(enabled)
    self.Horde_CamoflagueEnabled = enabled
end

hook.Add("Horde_OnPlayerDamageTaken", "Horde_CamoflagueDamageTaken", function (ply, dmginfo, bonus)
    if not ply:Horde_GetCamoflagueEnabled() then return end
    if ply:Horde_GetCamoflague() == 1 then
        bonus.evasion = bonus.evasion + 0.25
    end
end)

hook.Add("KeyPress", "Horde_CamoflagueOff", function(ply, key)
    if not ply:Horde_GetCamoflagueEnabled() then return end
    if (key == IN_ATTACK and ply:Horde_GetRemoveCamoflagueOnAttack() == 1) or ((key == IN_SPEED) and ply:Horde_GetRemoveCamoflagueOnRun() == 1) then
        ply.Horde_ShouldCamoflague = nil
        timer.Remove("Horde_Camoflague" .. ply:UniqueID())
        timer.Simple(0.1, function()
            ply.Horde_ShouldCamoflague = nil
            ply:Horde_RemoveCamoflague()
        end)
    end
end)

hook.Add("PlayerTick", "Horde_CamoflagueOn", function(ply, mv)
    if not ply:Horde_GetCamoflagueEnabled() or not ply:Alive() then return end
    if ply:Crouching() then
        if ply:Horde_GetCamoflague() == 1 or ply.Horde_ShouldCamoflague then return end
        ply.Horde_ShouldCamoflague = true
        timer.Create("Horde_Camoflague" .. ply:UniqueID(), ply:Horde_GetCamoflagueActivationTime(), 1, function()
            if ply.Horde_ShouldCamoflague then
                ply:Horde_AddCamoflague()
            end
        end)
    end
end)

hook.Add("Horde_ResetStatus", "Horde_CamoflagueReset", function(ply)
    ply.Horde_Camoflague = 0
    ply.Horde_CamoflagueActivationTime = 0.5
    ply.Horde_RemoveCamoflagueOnRun = 1
end)

hook.Add("DoPlayerDeath", "Horde_CamoflagueDoPlayerDeath", function(victim)
    if victim:IsPlayer() and victim:IsValid() then
        victim:Horde_RemoveCamoflague()
    end
end)
