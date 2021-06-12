MUTATION.PrintName = "Charged"
MUTATION.Description = "25% increased damage.\nDamage dealt is converted to Shock damage."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "charged" then
        if CLIENT then
            local col_min, col_max = ent:GetCollisionBounds()
            local radius = col_max:Distance(col_min) / 2
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
                e:SetRadius(radius)
            util.Effect("charged", e)
        end
    end
end

MUTATION.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_GetMutation() == "charged" then
        dmg:SetDamageType(DMG_SHOCK)
        dmg:ScaleDamage(1.25)
    end
end