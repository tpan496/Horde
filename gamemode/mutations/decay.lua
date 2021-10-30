MUTATION.PrintName = "Decay"
MUTATION.Description = "When a player is hit, blocks healing/regeneration for 5 seconds.\nOnly randomly occurs in the latter half of the waves."

MUTATION.Hooks = {}
MUTATION.Strong = true

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
    if dmg:GetAttacker():IsNPC() and dmg:GetAttacker():Horde_GetMutation() == "decay" then
        ply.Horde_Debuff_No_Heal = true
        local id = ply:SteamID()
        net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Break, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        timer.Remove("Horde_Decay_Effect" .. id)
        timer.Create("Horde_Decay_Effect" .. id, 5, 1, function ()
            if ply:IsValid() then
                ply.Horde_Debuff_No_Heal = nil
                net.Start("Horde_SyncStatus")
                    net.WriteUInt(HORDE.Status_Break, 8)
                    net.WriteUInt(0, 3)
                net.Send(ply)
            end
        end)
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "decay" then return end
    ent.Horde_Mutation_Decay = nil
end