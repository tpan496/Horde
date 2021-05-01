MUTATION.PrintName = "Fume"
MUTATION.Description = "Poison damaging aura."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "fume" then
        if CLIENT then
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
            util.Effect("fume", e)
        end

        if SERVER then
            local id = ent:GetCreationID()
            timer.Create("Horde_Mutation_Fume" .. id, 0.5, 0, function()
                if not ent:IsValid() then timer.Remove("Horde_Mutation_Fume" .. id) return end
                local dmginfo = DamageInfo()
                dmginfo:SetAttacker(ent)
                dmginfo:SetInflictor(ents.GetByIndex(0))
                dmginfo:SetDamageType(DMG_ACID)
                dmginfo:SetDamage(10)
                dmginfo:SetDamageForce(Vector(0,0,0))
                util.BlastDamageInfo(dmginfo, ent:GetPos(), 200)
            end)
        end
    end
end