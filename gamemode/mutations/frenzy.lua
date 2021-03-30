MUTATION.PrintName = "Frenzy"
MUTATION.Description = "50% increased action speed."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if SERVER and mutation == "frenzy" then
        local e = EffectData()
            e:SetOrigin(ent:GetPos())
            e:SetEntity(ent)
        util.Effect("frenzy", e, true, true)

        if ent.AnimationPlaybackRate then
            ent.AnimationPlaybackRate = ent.AnimationPlaybackRate * 1.5
        else
            ent:SetPlaybackRate(ent:GetPlaybackRate() * 1.5)
        end
    end
end