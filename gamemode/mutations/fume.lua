 MUTATION.PrintName = "Fume"
MUTATION.Description = "An aura that increases bleeding buildup."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "fume" then
        if SERVER then
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
            util.Effect("fume", e, true, true)

            local id = ent:GetCreationID()
            timer.Create("Horde_Mutation_Fume" .. id, 0.5, 0, function()
                if not ent:IsValid() or not ent.Horde_Mutation then timer.Remove("Horde_Mutation_Fume" .. id) return end
                for _, e1 in pairs(ents.FindInSphere(ent:GetPos(), 175)) do
                    if HORDE:IsPlayerOrMinion(e1) == true then
                        e1:Horde_AddDebuffBuildup(HORDE.Status_Bleeding, 10, ent)
                    end
                end
            end)
        end
    end
end