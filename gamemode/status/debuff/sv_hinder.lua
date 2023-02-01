local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddHinder(inflictor, duration, more)
    timer.Remove("Horde_RemoveHinder" .. self:GetCreationID())
    timer.Create("Horde_RemoveHinder" .. self:GetCreationID(), duration, 1, function ()
        self:Horde_RemoveHinder()
    end)
    if not self.Horde_Hinder then
        hook.Run("Horde_PostEnemyDebuffApply", self, inflictor, HORDE.Status_Hindered, self:GetPos())
    end
    self.Horde_Hinder = math.max(1, 1 * more)
end

function entmeta:Horde_GetHinder()
    return self.Horde_Hinder
end

function entmeta:Horde_RemoveHinder()
    if not self:IsValid() then return end
    self.Horde_Hinder = nil
end

hook.Add("EntityTakeDamage", "Horde_HinderDamageTaken", function(target, dmg)
    local attacker = dmg:GetAttacker()
    if attacker:IsValid() and attacker:Horde_GetHinder() and HORDE:IsPhysicalDamage(dmg) then
        dmg:ScaleDamage(1 - 0.15 * target.Horde_Hinder)
    end
end)


hook.Add("Horde_ResetStatus", "Horde_HinderReset", function(ply)
    ply.Horde_Hinder = nil
end)