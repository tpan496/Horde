MUTATION.PrintName = "Regenerator"
MUTATION.Description = "Regenerate 2% health per second. Effect halves on bosses."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "regenerator" then
        ent.Horde_Mutation_Regenerator = true
        if SERVER then
            local mult = 1
            if ent:GetVar("is_boss") == true then
                mult = 0.5
            end

            local id = ent:GetCreationID()
            local players_count = table.Count(player.GetAll())
            local regen_amount = math.min(math.min(100, 20 * players_count), ent:GetMaxHealth() * 0.02) * mult
            timer.Create("Horde_Mutation_Regenerator" .. id, 1, 0, function()
                if not ent:IsValid() or not ent.Horde_Mutation_Regenerator then timer.Remove("Horde_Mutation_Regenerator" .. id) return end
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