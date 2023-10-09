local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddVileBlood(duration)
    timer.Remove("Horde_RemoveVileBlood" .. self:SteamID())
    timer.Create("Horde_RemoveVileBlood" .. self:SteamID(), duration, 1, function ()
        self:Horde_RemoveVileBlood()
    end)

    self.Horde_VileBlood = 1
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_VileBlood, 8)
        net.WriteUInt(1, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveVileBlood()
    if not self:IsValid() then return end
    if self.Horde_VileBlood == 0 then return end
    self.Horde_VileBlood = 0
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_VileBlood, 8)
        net.WriteUInt(0, 8)
    net.Send(self)
end

function plymeta:Horde_GetVileBlood()
    return self.Horde_VileBlood or 0
end

hook.Add("Horde_OnPlayerDamage", "Horde_VileBloodDamage", function(ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetVileBlood() == 1 then
        npc:Horde_AddDebuffBuildup(HORDE.Status_Break, dmginfo:GetDamage() * 0.2, ply, dmginfo:GetDamagePosition())
    end
end)

hook.Add("Horde_OnPlayerDamageTaken", "Horde_VileBloodDamageTaken", function(ply, dmginfo, bonus)
    if ply:Horde_GetVileBlood() == 1 and HORDE:IsPoisonDamage(dmginfo) then
        bonus.resistance = bonus.resistance + 0.4
    end
end)

hook.Add("Horde_ResetStatus", "Horde_VileBloodReset", function(ply)
    ply.Horde_VileBlood = 0
end)