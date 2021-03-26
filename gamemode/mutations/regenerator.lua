MUTATION.PrintName = "Regenerator"
MUTATION.Description = "Regenerate 2% health per second."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if SERVER and mutation == "regenerator" then
        local col_min, col_max = ent:GetCollisionBounds()
        local radius = col_max:Distance(col_min) / 2
        local e = EffectData()
            e:SetOrigin(ent:GetPos())
            e:SetEntity(ent)
            e:SetRadius(radius)
        util.Effect("regenerator", e)
        local id = ent:GetCreationID()
        timer.Create("Horde_Mutation_Regenerator" .. id, 1, 0, function()
            if not ent:IsValid() then timer.Remove("Horde_Mutation_Regenerator" .. id) return end
            ent:SetHealth(math.max(ent:GetMaxHealth(), ent:GetMaxHealth() * 0.02 + ent:Health()))
        end)
    end
end