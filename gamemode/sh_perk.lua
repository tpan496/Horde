HORDE.NET_PERK_SET = 1
HORDE.NET_PERK_UNSET = 2
HORDE.NET_PERK_CLEAR = 3

HORDE.NET_PERK_BITS = 2

HORDE.perks = HORDE.perks or {}

if SERVER then
util.AddNetworkString("Horde_PerkStartCooldown")
end

if CLIENT then
    net.Receive("Horde_Perk", function()
        if GetConVar("horde_enable_perk"):GetInt() ~= 1 then return end
        local mode = net.ReadUInt(HORDE.NET_PERK_BITS)
        local ply = net.ReadEntity()
        if not ply:IsValid() then return end
        ply.Horde_Perks = ply.Horde_Perks or {}
        if mode == HORDE.NET_PERK_SET then
            local perk = net.ReadString()
            ply:Horde_SetPerk(perk)
        elseif mode == HORDE.NET_PERK_UNSET then
            local perk = net.ReadString()
            ply:Horde_UnsetPerk(perk)
        elseif mode == HORDE.NET_PERK_CLEAR then
            ply:Horde_ClearPerks()
        end
    end)

    -- Get our saved choice and send it to the server
    function HORDE:SendSavedPerkChoices(class)
        local tbl = LocalPlayer().Horde_PerkChoices
        if not tbl or tbl == {} then
            local f = file.Read("horde/perk_choices.txt", "DATA")
            if f then
                LocalPlayer().Horde_PerkChoices = util.JSONToTable(f)
                tbl = LocalPlayer().Horde_PerkChoices
            end
        end

        net.Start("Horde_PerkChoice")
            net.WriteString(class)
            net.WriteUInt(0, 4)
            for perk_level, choices in SortedPairs(HORDE.classes[class].perks) do
                if not tbl or not tbl[class] then
                    net.WriteUInt(1, 4)
                else
                    net.WriteUInt(tbl[class][perk_level] or 1, 4)
                end
            end
        net.SendToServer()
    end
    net.Receive("Horde_PerkChoice", function() HORDE:SendSavedPerkChoices(LocalPlayer():Horde_GetClass().name) end)
end

function HORDE:Horde_GetWaveForPerk(perk_level)
    return GetConVar("horde_perk_start_wave"):GetInt() + math.Round((perk_level - 1) * GetConVar("horde_perk_scaling"):GetFloat())
end

local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetPerk(perk)
    return self.Horde_Perks and self.Horde_Perks[perk] or nil
end

function plymeta:Horde_SetPerk(perk, shared)
    if not HORDE.perks[perk] then error("Tried to use nonexistent perk '" .. perk .. "' in Horde_SetPerk!") return end
    self.Horde_Perks = self.Horde_Perks or {}
    self.Horde_Perks[perk] = true
    if SERVER then
        hook.Run("Horde_PrecomputePerkLevelBonus", self)
    end
    hook.Run("Horde_OnSetPerk", self, perk)

    if SERVER and not shared then
        net.Start("Horde_Perk")
            net.WriteUInt(HORDE.NET_PERK_SET, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
            net.WriteString(perk)
        net.Broadcast()
    end
end

function plymeta:Horde_UnsetPerk(perk, shared)
    self.Horde_Perks = self.Horde_Perks or {}

    hook.Run("Horde_OnUnsetPerk", self, perk)

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
    --self.Horde_Perks = {}

    if not shared then
        for k, v in pairs(self.Horde_Perks or {}) do
            self:Horde_UnsetPerk(k, shared)
        end
    end

    if SERVER and not shared then
        net.Start("Horde_Perk")
            net.WriteUInt(HORDE.NET_PERK_CLEAR, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
        net.Broadcast()
    end
end

local prefix = "horde/gamemode/perks/"
local function Horde_LoadPerks()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        PERK = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if PERK.Ignore then goto cont end
        PERK.ClassName = string.lower(PERK.ClassName or string.Explode(".", f)[1])
        PERK.SortOrder = PERK.SortOrder or 0

        hook.Run("Horde_OnLoadPerk", PERK)

        HORDE.perks[PERK.ClassName] = PERK

        for k, v in pairs(PERK.Hooks or {}) do
            hook.Add(k, "horde_perk_" .. PERK.ClassName, v)
        end

        if dev then print("[Horde] Loaded perk '" .. PERK.ClassName .. "'.") end
        ::cont::
    end
    PERK = nil
end

if GetConVar("horde_enable_perk"):GetInt() == 1 then
    Horde_LoadPerks()
end

if CLIENT then
hook.Add("PlayerButtonDown", "Horde_UseKeyAndShift", function(ply, key)
    if (key == KEY_E) and input.IsButtonDown(KEY_LSHIFT) then
        ply:ConCommand("horde_use_perk_skill")
    end
end)
end

function plymeta:Horde_GetPerkNextThink()
    return self.Horde_PerkNextThink or 0
end

function plymeta:Horde_SetPerkNextThink(t)
    self.Horde_PerkNextThink = t
end

function plymeta:Horde_SetPerkDuration(d)
    self.Horde_PerkDuration = d
end

function plymeta:Horde_GetPerkDuration()
    return self.Horde_PerkDuration or 0
end

function plymeta:Horde_SetPerkCooldown(cd)
    self.Horde_PerkCooldown = cd
end

function plymeta:Horde_SetPerkInternalCooldown(cd)
    self.Horde_PerkInternalCooldown = cd
end

function plymeta:Horde_GetPerkInternalCooldown()
    return self.Horde_PerkInternalCooldown or 0
end

function plymeta:Horde_GetPerkCooldown()
    return self.Horde_PerkCooldown or 0
end

if SERVER then
    function HORDE:UsePerkSkill(ply)
        if ply:Horde_GetPerkInternalCooldown() <= 0 and ply:Alive() then
            local res = hook.Run("Horde_UseActivePerk", ply)
            if res then return end
            ply:Horde_SetPerkInternalCooldown(ply:Horde_GetPerkCooldown())
            net.Start("Horde_PerkStartCooldown")
                net.WriteUInt(ply:Horde_GetPerkCooldown(), 8)
            net.Send(ply)
        end
    end

    hook.Add("PlayerPostThink", "Horde_PerkCooldown", function(ply)
        if CurTime() >= ply:Horde_GetPerkNextThink() then
            if ply:Horde_GetPerkInternalCooldown() <= 0 then return end
            ply:Horde_SetPerkInternalCooldown(ply:Horde_GetPerkInternalCooldown() - 1)
            ply:Horde_SetPerkNextThink(CurTime() + 1)
        end
    end)
end