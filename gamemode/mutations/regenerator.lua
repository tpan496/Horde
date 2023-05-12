MUTATION.PrintName = "Regenerator"
MUTATION.Description = "Regenerate 2% health per second. Effect halves on bosses. Regenerate is temporarily stopped if the enemy is being damaged."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "regenerator" then
        ent.Horde_Mutation_Regenerator = true
        ent.Horde_CanRegenerate = true
        if SERVER then
            local col_min, col_max = ent:GetCollisionBounds()
            local radius = col_max:Distance(col_min) / 2
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
                e:SetRadius(radius)
            util.Effect("regenerator", e, true, true)

            local mult = 1
            if ent:GetVar("is_boss") == true then
                mult = 0.5
            end

            local id = ent:GetCreationID()
            local players_count = table.Count(player.GetAll())
            local regen_amount = math.min(math.min(100, 20 * players_count), ent:GetMaxHealth() * 0.02) * mult
            timer.Create("Horde_Mutation_Regenerator" .. id, 1, 0, function()
                if not ent:IsValid() or not ent.Horde_Mutation_Regenerator then timer.Remove("Horde_Mutation_Regenerator" .. id) return end
                if not ent.Horde_CanRegenerate then return end
                ent:SetHealth(math.min(ent:GetMaxHealth(), regen_amount + ent:Health()))
                local boss_properties = ent:Horde_GetBossProperties()
                if boss_properties and boss_properties.is_boss and boss_properties.is_boss == true then
                    net.Start("Horde_SyncBossHealth")
                    net.WriteInt(ent:Health(), 32)
                    net.Broadcast()
                end
            end)
        end
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "regenerator" then return end
    ent.Horde_Mutation_Regenerator = nil
end

MUTATION.Hooks.EntityTakeDamage = function(target, dmg)
    if CLIENT then return end
    if target:IsNPC() and target:Horde_HasMutation("regenerator") then
        target.Horde_CanRegenerate = nil
        local id = target:GetCreationID()
        timer.Remove("Horde_Mutation_Regenerator_Reset" .. id)
        timer.Create("Horde_Mutation_Regenerator_Reset" .. id, 5, 1, function()
            target.Horde_CanRegenerate = true
        end)
    end
end