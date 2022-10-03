local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddWeaken(duration, more)
    timer.Remove("Horde_RemoveWeaken" .. self:GetCreationID())
    timer.Create("Horde_RemoveWeaken" .. self:GetCreationID(), duration, 1, function ()
        self:Horde_RemoveWeaken()
    end)

    self.Horde_Weaken = math.max(1, 1 * more)
    if not self.Horde_Debuff_Active then self.Horde_Debuff_Active = {} end
    self.Horde_Debuff_Active[HORDE.Status_Weakened] = true
    hook.Run("Horde_PostEnemyDebuffApply", self, self.Horde_Debuff_Active)
end

function entmeta:Horde_GetWeaken()
    return self.Horde_Weaken or 0
end

function entmeta:Horde_RemoveWeaken()
    if not self:IsValid() then return end
    self.Horde_Weaken = 0
    self.Horde_Debuff_Active[HORDE.Status_Weakened] = nil
    hook.Run("Horde_PostEnemyDebuffApply", self, self.Horde_Debuff_Active)
end

hook.Add("EntityTakeDamage", "Horde_WeakenDamageTaken", function(target, dmg)
    if target:Horde_GetWeaken() > 0 and HORDE:IsPhysicalDamage(dmg) then
        dmg:ScaleDamage(1 + 0.15 * target.Horde_Weaken)
    end
end)

hook.Add("Horde_ResetStatus", "Horde_WeakenReset", function(ply)
    ply.Horde_Weaken = 0
end)