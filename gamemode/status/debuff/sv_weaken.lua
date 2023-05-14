local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddWeaken(inflictor, duration, more)
    timer.Remove("Horde_RemoveWeaken" .. self:GetCreationID())
    timer.Create("Horde_RemoveWeaken" .. self:GetCreationID(), duration, 1, function ()
        self:Horde_RemoveWeaken()
    end)

    if self:IsPlayer() then
        self:Horde_SyncStatus(HORDE.Status_Weaken, 100)
        self.Horde_Weaken = math.max(1, 1 * more)
    else
        if not self.Horde_Weaken then
            hook.Run("Horde_PostEnemyDebuffApply", self, inflictor, HORDE.Status_Weaken, self:GetPos())
        end
        self.Horde_Weaken = math.max(1, 1 * more)
    end
end

function entmeta:Horde_GetWeaken()
    return self.Horde_Weaken
end

function entmeta:Horde_RemoveWeaken()
    if not self:IsValid() then return end
    self.Horde_Weaken = nil
    if self:IsPlayer() then
        self:Horde_SyncStatus(HORDE.Status_Weaken, 0)
        return
    end
end

hook.Add("EntityTakeDamage", "Horde_WeakenDamageTaken", function(target, dmg)
    if target:Horde_GetWeaken() and HORDE:IsPhysicalDamage(dmg) then
        dmg:ScaleDamage(1 + 0.15 * target.Horde_Weaken)
    end
end)

hook.Add("Horde_ResetStatus", "Horde_WeakenReset", function(ply)
    ply.Horde_Weaken = nil
end)