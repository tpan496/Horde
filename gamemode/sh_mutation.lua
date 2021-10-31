-- Simliar to player perks, Horde enemies can have mutations
-- Mutated monsters have 25% increased health and deal 25% increased damage.
-- Adaptor: When attacked using same type of damage, gain 25% damage resistance to that damage type.
-- Shadow: Turns invisible sometimes.
if SERVER then
util.AddNetworkString("Horde_SyncMutations")
util.AddNetworkString("Horde_OnSetMutationEffect")
util.AddNetworkString("Horde_OnUnsetMutationEffect")
end

local entmeta = FindMetaTable("Entity")

function entmeta:Horde_GetMutation()
    return self.Horde_Mutation
end

function entmeta:Horde_UnsetMutation()
    if not self.Horde_Mutation then return end
    hook.Run("Horde_OnUnsetMutation", self, self.Horde_Mutation)
    if SERVER then
        net.Start("Horde_OnUnsetMutationEffect")
            net.WriteEntity(self)
        net.Broadcast()
    end
    self.Horde_Mutation = nil
end

function entmeta:Horde_SetMutation(mutation)
    if not mutation or mutation == "" then return end
    if SERVER then
        if self.Horde_Mutation then
            self:Horde_UnsetMutation()
        end
    end

    self.Horde_Mutation = mutation

    hook.Run("Horde_OnSetMutation", self, mutation)
    if SERVER then
        net.Start("Horde_OnSetMutationEffect")
            net.WriteEntity(self)
            net.WriteString(mutation)
        net.Broadcast()
    end
end

if CLIENT then
net.Receive("Horde_OnSetMutationEffect", function()
    local ent = net.ReadEntity()
    local mut = net.ReadString()
    if not ent:IsValid() then return end
    ent:Horde_SetMutation(mut)
end)
net.Receive("Horde_OnUnsetMutationEffect", function()
    local ent = net.ReadEntity()
    if not ent:IsValid() then return end
    ent:Horde_UnsetMutation()
end)
end

-- Remove mutations when enemies are dead
hook.Add("EntityRemoved", "Horde_UnsetMutationOnEntityRemoved", function(ent)
    if CLIENT then return end
    if ent:IsNPC() and ent:Horde_GetMostRecentAttacker() then
        --hook.Run("Horde_OnUnsetMutation", ent, ent.Horde_Mutation)
    end
end)

HORDE.mutations = {}
HORDE.mutations_sequential = {}
HORDE.mutations_sequential_strong = {}

local prefix = "horde/gamemode/mutations/"
local function Horde_LoadMutations()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        MUTATION = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if MUTATION.Ignore then goto cont end
        MUTATION.ClassName = string.lower(MUTATION.PrintName or string.Explode(".", f)[1])
        MUTATION.SortOrder = MUTATION.SortOrder or 0

        hook.Run("Horde_OnLoadMutation", MUTATION)

        HORDE.mutations[MUTATION.ClassName] = MUTATION
        if not MUTATION.Strong then
            table.insert(HORDE.mutations_sequential, MUTATION.ClassName)
        end
        table.insert(HORDE.mutations_sequential_strong, MUTATION.ClassName)

        for k, v in pairs(MUTATION.Hooks or {}) do
            hook.Add(k, "horde_mutation_" .. MUTATION.ClassName, v)
        end

        if dev then print("[Horde] Loaded mutation '" .. MUTATION.ClassName .. "'.") end
        ::cont::
    end
    MUTATION = nil
end
Horde_LoadMutations()