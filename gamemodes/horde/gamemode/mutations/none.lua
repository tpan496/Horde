MUTATION.PrintName = "None"
MUTATION.Description = "Disables mutation for the given enemy.\nDoes not randomly apply on enemies."
MUTATION.NoRand = true

MUTATION.Hooks = {}

MUTATION.Hooks.Horde_OnSetMutation = function(ent, mutation)
end

MUTATION.Hooks.Horde_OnUnsetMutation = function (ent, mutation)
end