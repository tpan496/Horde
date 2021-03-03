HORDE.NET_PERK_SET = 1
HORDE.NET_PERK_UNSET = 2
HORDE.NET_PERK_CLEAR = 3

HORDE.NET_PERK_BITS = 2

if SERVER then
    util.AddNetworkString("Horde_Perk")
elseif CLIENT then
    net.Receive("Horde_Perk", function()
        local mode = net.ReadUInt(HORDE.NET_PERK_BITS)
        local ply = net.ReadEntity()
        if mode == HORDE.NET_PERK_SET then
            local perk = net.ReadString()
            ply.Horde_Perks[perk] = net.ReadTable()
        elseif mode == HORDE.NET_PERK_UNSET then
            local perk = net.ReadString()
            ply.Horde_Perks[perk] = {}
        elseif mode == HORDE.NET_PERK_CLEAR then
            ply.Horde_Perks = {}
        end
    end)
end

local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetPerk(perk)
    return self.Horde_Perks[perk]
end

function plymeta:Horde_GetPerkParam(perk, param)
    if self.Horde_Perks[perk] then
        return self.Horde_Perks[perk][param]
    else
        return nil
    end
end

function plymeta:Horde_SetPerk(perk, params, shared)
    if not HORDE.perks[perk] then error("Tried to use nonexistent perk '" .. perk .. "' in Horde_SetPerk!") return end
    self.Horde_Perks = self.Horde_Perks or {}

    -- Set default values and clamp
    for k, v in pairs(HORDE.perks[perk].Parameters or {}) do
        if not params[k] then
            params[k] = v.default
        elseif (v.type == "i" or v.type == "f") then
            params[k] = math.Clamp(params[k] or v.default, v.min or math.min, v.max or math.max)
        end
    end

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
    self.Horde_Perks = {}

    if SERVER and not shared then
        net.Start("Horde_Perk")
            net.WriteUInt(HORDE.NET_PERK_CLEAR, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
        net.Broadcast()
    end
end

local prefix = "gamemodes/horde/gamemode/perks/"
function Horde_LoadPerks()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        PERK = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        local name = string.lower(PERK.ClassName or string.Explode(".", f)[1])
        if PERK.Ignore then continue end
        PERK.SortOrder = PERK.SortOrder or 0

        hook.Run("Horde_LoadPerk", PERK)

        HORDE.perk[name] = PERK

        for k, v in pairs(PERK.Hooks or {}) do
            hook.Add(k, "horde_perk_" .. name, v)
        end

        if dev then print("[Horde] Loaded perk '" .. name .. "'.") end
    end
end
Horde_LoadPerks() -- TODO find a better place to load?

print("horde sh_perk.lua")