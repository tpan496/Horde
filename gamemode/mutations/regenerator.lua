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
            ent:SetHealth(math.min(ent:GetMaxHealth(), ent:GetMaxHealth() * 0.02 + ent:Health()))
            local boss_properties = ent:Horde_GetBossProperties()
            if boss_properties and boss_properties.is_boss and boss_properties.is_boss == true then
                net.Start("Horde_SyncBossHealth")
                net.WriteInt(ent:Health(), 32)
                net.Broadcast()
            end
        end)
    end
end