-- Simliar to player perks, Horde enemies can have mutations
-- Mutated monsters have 25% increased health and deal 25% increased damage.
-- Adaptor: When attacked using same type of damage, gain 25% damage resistance to that damage type.
-- Shadow: Turns invisible sometimes.
util.AddNetworkString("Horde_SyncMutations")

local entmeta = FindMetaTable("Entity")

function entmeta:Horde_GetMutation()
    return self.Horde_Mutation
end

function entmeta:Horde_SetMutation(mutation)
    self.Horde_Mutation = mutation
    hook.Run("Horde_OnSetMutation", self, mutation)
end

-- Remove mutations when enemies are dead
hook.Add("EntityRemoved", "Horde_UnsetMutationOnEntityRemoved", function(ent)
    if ent:IsNPC() and ent:Horde_GetMostRecentAttacker() then
        hook.Run("Horde_OnUnsetMutation", ent)
    end
end)

HORDE.mutations = {}

local prefix = "horde/gamemode/mutations/"
local function Horde_LoadMutations()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        MUTATION = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if MUTATION.Ignore then goto cont end
        MUTATION.ClassName = string.lower(MUTATION.ClassName or string.Explode(".", f)[1])
        MUTATION.SortOrder = MUTATION.SortOrder or 0

        hook.Run("Horde_OnLoadMutation", MUTATION)

        HORDE.mutations[MUTATION.ClassName] = MUTATION

        for k, v in pairs(MUTATION.Hooks or {}) do
            hook.Add(k, "horde_mutation_" .. MUTATION.ClassName, v)
        end

        if dev then print("[Horde] Loaded mutation '" .. MUTATION.ClassName .. "'.") end
        ::cont::
    end
    MUTATION = nil
end
Horde_LoadMutations()