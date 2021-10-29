MUTATION.PrintName = "Charged"
MUTATION.Description = "25% more damage.\nDamage dealt is converted to Shock damage."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "charged" then
        ent.Horde_Mutation_Charged = true
        if SERVER then
            local col_min, col_max = ent:GetCollisionBounds()
            local radius = col_max:Distance(col_min) / 2
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
                e:SetRadius(radius)
            util.Effect("charged", e, true, true)
        end
    end
end

MUTATION.Hooks.EntityTakeDamage = function(ply, dmg)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_GetMutation() == "charged" then
        dmg:SetDamageType(DMG_SHOCK)
        dmg:ScaleDamage(1.25)
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "charged" then return end
    ent.Horde_Mutation_Charged = nil
end