local entmeta = FindMetaTable("Entity")

hook.Add("EntityTakeDamage", "Horde_ShockDamageTaken", function(target, dmg)
    if not target.Horde_Debuff_Active or not target.Horde_Debuff_Active[HORDE.Status_Shock] then return end
    local attacker = dmg:GetAttacker()
    if attacker:IsPlayer() and target:IsNPC() then
        dmg:ScaleDamage(1 + 0.25 * (1 + attacker:Horde_GetApplyDebuffMore()))
    else
        dmg:ScaleDamage(1 + HORDE.difficulty_shock_damage_increase[HORDE.difficulty])
    end
end)