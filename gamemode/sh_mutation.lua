-- Simliar to player perks, Horde enemies can have mutations
if SERVER then
util.AddNetworkString("Horde_SyncMutations")
util.AddNetworkString("Horde_OnSetMutationEffect")
util.AddNetworkString("Horde_OnUnsetMutationEffect")
end

local entmeta = FindMetaTable("Entity")

function entmeta:Horde_HasMutation(mutation)
    if not self.Horde_Mutation then return end
    return self.Horde_Mutation[mutation]
end

function entmeta:Horde_UnsetMutations()
    if not self.Horde_Mutation then return end
    for mutation, _ in pairs(self.Horde_Mutation) do
        hook.Run("Horde_OnUnsetMutation", self, mutation)
    end
    self.Horde_Mutation = nil
    if SERVER then
        net.Start("Horde_OnUnsetMutationEffect")
            net.WriteEntity(self)
        net.Broadcast()
    end
end

function entmeta:Horde_SetMutation(mutation)
    if not mutation or mutation == "" then return end
    if mutation == "giant" then
        local class = self:GetClass()
        if class == "npc_vj_horde_weeper" or class == "npc_vj_horde_vomitter" or class == "npc_vj_horde_screecher" or class == "npc_vj_horde_exploder" then
            return
        end
    end
    if not self:IsValid() then return end
    if not self.Horde_Mutation then self.Horde_Mutation = {} end
    if self.Horde_Mutation[mutation] then return end
    self.Horde_Mutation[mutation] = true

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
    ent:Horde_UnsetMutations()
end)
end

HORDE.mutations = {}
HORDE.mutations_rand = {}

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
        if not (MUTATION.NoRand) then
            HORDE.mutations_rand[MUTATION.ClassName] = MUTATION
        end

        for k, v in pairs(MUTATION.Hooks or {}) do
            hook.Add(k, "horde_mutation_" .. MUTATION.ClassName, v)
        end

        if dev then print("[Horde] Loaded mutation '" .. MUTATION.ClassName .. "'.") end
        ::cont::
    end
    MUTATION = nil
end
Horde_LoadMutations()