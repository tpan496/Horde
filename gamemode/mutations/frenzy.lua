MUTATION.PrintName = "Frenzy"
MUTATION.Description = "50% increased action speed."

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
    if mutation == "frenzy" then
        if SERVER then
            if ent.AnimationPlaybackRate then
                ent.AnimationPlaybackRate = ent.AnimationPlaybackRate * 1.5
            else
                ent:SetPlaybackRate(ent:GetPlaybackRate() * 1.5)
            end
        end
    end
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
    if not ent:IsValid() or mutation ~= "frenzy" then return end
    if ent.AnimationPlaybackRate then
        ent.AnimationPlaybackRate = ent.AnimationPlaybackRate / 1.5
    else
        ent:SetPlaybackRate(ent:GetPlaybackRate() / 1.5)
    end
end