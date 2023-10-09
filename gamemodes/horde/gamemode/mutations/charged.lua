MUTATION.PrintName = "Charged"
MUTATION.Description = "Damage dealt is converted to Lightning damage.\nOnly randomly occurs starting from wave 6."
MUTATION.Wave = 6

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

MUTATION.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_HasMutation("charged") then
        dmg:SetDamageType(DMG_SHOCK)
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "charged" then return end
    ent.Horde_Mutation_Charged = nil
end