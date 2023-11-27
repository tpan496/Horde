MUTATION.PrintName = "Decay"
MUTATION.Description = "Adds Decay buildup based on hit damage. Decay status prevents healing for 5 seconds.\nOnly randomly occurs starting from wave 8."

MUTATION.Hooks = {}
MUTATION.Wave = 8

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "decay" then
        ent.Horde_Mutation_Decay = true
        if SERVER then
            local col_min, col_max = ent:GetCollisionBounds()
            local radius = col_max:Distance(col_min) / 2
            local e = EffectData()
                e:SetOrigin(ent:GetPos())
                e:SetEntity(ent)
                e:SetRadius(radius)
            util.Effect("decay", e, true, true)
        end
    end
end

MUTATION.Hooks.Horde_OnPlayerDamageTaken = function(ply, dmg, bonus)
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_HasMutation("decay") then
        ply:Horde_AddDebuffBuildup(HORDE.Status_Decay, dmg:GetDamage() * 2)
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "decay" then return end
    ent.Horde_Mutation_Decay = nil
end