HORDE.NET_PERK_SET = 1
HORDE.NET_PERK_UNSET = 2
HORDE.NET_PERK_CLEAR = 3

HORDE.NET_PERK_BITS = 2

HORDE.perk = HORDE.perk or {}

if SERVER then
    util.AddNetworkString("Horde_Perk")
elseif CLIENT then
    net.Receive("Horde_Perk", function()
        local mode = net.ReadUInt(HORDE.NET_PERK_BITS)
        local ply = net.ReadEntity()
        ply.Horde_Perks = ply.Horde_Perks or {}
        if mode == HORDE.NET_PERK_SET then
            local perk = net.ReadString()
            local params = net.ReadTable()
            hook.Run("Horde_OnSetPerk", ply, perk, params)
            ply.Horde_Perks[perk] = params
        elseif mode == HORDE.NET_PERK_UNSET then
            local perk = net.ReadString()
           hook.Run("Horde_OnUnsetPerk", ply, perk)
            ply.Horde_Perks[perk] = {}
        elseif mode == HORDE.NET_PERK_CLEAR then
            hook.Run("Horde_OnClearPerks", ply)
            ply.Horde_Perks = {}
        end
    end)
end

local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetPerk(perk)
    return self.Horde_Perks and self.Horde_Perks[perk] or nil
end

function plymeta:Horde_GetPerkParam(perk, param)
    if self.Horde_Perks[perk] then
        return self.Horde_Perks[perk][param]
    else
        return nil
    end
end

function plymeta:Horde_SetPerk(perk, params, shared)
    if not HORDE.perk[perk] then error("Tried to use nonexistent perk '" .. perk .. "' in Horde_SetPerk!") return end
    self.Horde_Perks = self.Horde_Perks or {}
    params = params or {}

    -- Set default values and clamp
    for k, v in pairs(HORDE.perk[perk].Parameters or {}) do
        if not params[k] then
            params[k] = v.default
        elseif (v.type == "i" or v.type == "f") then
            params[k] = math.Clamp(params[k] or v.default, v.min or -math.huge, v.max or math.huge)
        end
    end

    hook.Run("Horde_OnSetPerk", self, perk, params)
    self.Horde_Perks[perk] = params

    if SERVER and not shared then
        net.Start("Horde_Perk")
            net.WriteUInt(HORDE.NET_PERK_SET, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
            net.WriteString(perk)
            net.WriteTable(params)
        net.Broadcast()
    end
end

function plymeta:Horde_UnsetPerk(perk, shared)
    self.Horde_Perks = self.Horde_Perks or {}

    hook.Run("Horde_OnUnsetPerk", ply, perk)

    self.Horde_Perks[perk] = nil

    if SERVER and not shared then
        net.Start("Horde_Perk")
            net.WriteUInt(HORDE.NET_PERK_UNSET, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
            net.WriteString(perk)
        net.Broadcast()
    end
end

function plymeta:Horde_ClearPerks(shared)

    hook.Run("Horde_OnClearPerks", self)
    self.Horde_Perks = {}

    if SERVER and not shared then
        net.Start("Horde_Perk")
            net.WriteUInt(HORDE.NET_PERK_CLEAR, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
        net.Broadcast()
    end
end

local prefix = "horde/gamemode/perks/"
function Horde_LoadPerks()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        PERK = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if PERK.Ignore then continue end
        PERK.ClassName = string.lower(PERK.ClassName or string.Explode(".", f)[1])
        PERK.SortOrder = PERK.SortOrder or 0

        hook.Run("Horde_OnLoadPerk", PERK)

        HORDE.perk[PERK.ClassName] = PERK

        for k, v in pairs(PERK.Hooks or {}) do
            hook.Add(k, "horde_perk_" .. PERK.ClassName, v)
        end

        if dev then print("[Horde] Loaded perk '" .. PERK.ClassName .. "'.") end
    end
    PERK = nil
end
Horde_LoadPerks()