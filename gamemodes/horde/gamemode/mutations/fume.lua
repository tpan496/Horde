MUTATION.PrintName = "Fume"
MUTATION.Description = "An aura that increases bleeding buildup."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "fume" then
        ent.Horde_Mutation_Fume = true
        if SERVER then
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
            util.Effect("fume", e, true, true)

            local id = ent:GetCreationID()
            timer.Create("Horde_Mutation_Fume" .. id, 0.5, 0, function()
                if not ent:IsValid() then timer.Remove("Horde_Mutation_Fume" .. id) return end
                for _, e1 in pairs(ents.FindInSphere(ent:GetPos(), 200)) do
                    if HORDE:IsPlayerOrMinion(e1) == true then
                        e1:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 15, ent)
                    end
                end
            end)
        end
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "fume" then return end
    ent.Horde_Mutation_Fume = nil
end