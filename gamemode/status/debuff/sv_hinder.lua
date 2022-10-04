local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddHinder(duration, more)
    timer.Remove("Horde_RemoveHinder" .. self:GetCreationID())
    timer.Create("Horde_RemoveHinder" .. self:GetCreationID(), duration, 1, function ()
        self:Horde_RemoveHinder()
    end)

    self.Horde_Hinder = math.max(1, 1 * more)
    if not self.Horde_Debuff_Active then self.Horde_Debuff_Active = {} end
    self.Horde_Debuff_Active[HORDE.Status_Hindered] = true
    hook.Run("Horde_PostEnemyDebuffApply", self, self.Horde_Debuff_Active)
end

function entmeta:Horde_GetHinder()
    return self.Horde_Hinder or 0
end

function entmeta:Horde_RemoveHinder()
    if not self:IsValid() then return end
    self.Horde_Hinder = 0
    self.Horde_Debuff_Active[HORDE.Status_Hindered] = nil
    hook.Run("Horde_PostEnemyDebuffApply", self, self.Horde_Debuff_Active)
end

hook.Add("EntityTakeDamage", "Horde_HinderDamageTaken", function(target, dmg)
    local attacker = dmg:GetAttacker()
    if attacker:IsValid() and attacker:Horde_GetWeaken() > 0 and HORDE:IsPhysicalDamage(dmg) then
        dmg:ScaleDamage(1 - 0.15 * target.Horde_Hinder)
    end
end)


hook.Add("Horde_ResetStatus", "Horde_HinderReset", function(ply)
    ply.Horde_Hinder = 0
end)