if SERVER then
util.AddNetworkString("Horde_Gadget")
util.AddNetworkString("Horde_GadgetStartCooldown")
util.AddNetworkString("Horde_GadgetChargesUpdate")
end

HORDE.gadgets = HORDE.gadgets or {}

if CLIENT then
    net.Receive("Horde_Gadget", function()
        local mode = net.ReadUInt(HORDE.NET_PERK_BITS)
        local ply = net.ReadEntity()
        if not ply:IsValid() then return end
        if mode == HORDE.NET_PERK_SET then
            local gadget = net.ReadString()
            ply:Horde_SetGadget(gadget)
        elseif mode == HORDE.NET_PERK_UNSET then
            ply:Horde_UnsetGadget()
        end
    end)
end

local plymeta = FindMetaTable("Player")

function plymeta:Horde_GetGadgetNextThink()
    return self.Horde_GadgetNextThink or 0
end

function plymeta:Horde_SetGadgetNextThink(t)
    self.Horde_GadgetNextThink = t
end

function plymeta:Horde_SetGadgetDuration(d)
    self.Horde_GadgetDuration = d
end

function plymeta:Horde_GetGadgetDuration()
    return self.Horde_GadgetDuration or 0
end

function plymeta:Horde_SetGadgetCooldown(cd)
    self.Horde_GadgetCooldown = cd
end

function plymeta:Horde_SetGadgetInternalCooldown(cd)
    self.Horde_GadgetInternalCooldown = cd
end

function plymeta:Horde_SetGadgetCharges(charges)
    self.Horde_GadgetCharges = charges
    if SERVER then
        net.Start("Horde_GadgetChargesUpdate")
            net.WriteInt(charges, 8)
        net.Send(self)
    end
end

function plymeta:Horde_GetGadgetInternalCooldown()
    return self.Horde_GadgetInternalCooldown or 1
end

function plymeta:Horde_GetGadgetCooldown()
    return self.Horde_GadgetCooldown or 1
end

function plymeta:Horde_GetGadgetCharges(charges)
    return self.Horde_GadgetCharges or -1
end

function plymeta:Horde_GetGadget()
    return self.Horde_Gadget
end

function plymeta:Horde_SetGadget(gadget)
    if not HORDE.gadgets[gadget] then error("Tried to use nonexistent gadget '" .. gadget .. "' in Horde_SetGadget!") return end
    self.Horde_Gadget = gadget
    self:Horde_SetGadgetDuration(HORDE.gadgets[gadget].Duration or 0)
    self:Horde_SetGadgetCooldown(HORDE.gadgets[gadget].Cooldown or 0)
    self:Horde_SetGadgetCharges(HORDE.gadgets[gadget].Charges or -1)
    self:Horde_SetGadgetInternalCooldown(0)
    if SERVER then
        local item = HORDE.items[gadget]
        if item then
            self:Horde_AddWeight(-item.weight)
        end
    end

    hook.Run("Horde_OnSetGadget", self, gadget)
    sound.Play("items/suitchargeok1.wav", self:GetPos())

    if SERVER then
        self:Horde_SetMaxHealthOnly()
        net.Start("Horde_Gadget")
            net.WriteUInt(HORDE.NET_PERK_SET, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
            net.WriteString(gadget)
        net.Broadcast()
    end
end

function plymeta:Horde_UnsetGadget()
    if self.Horde_Gadget == nil then return end
    if SERVER then
        local item = HORDE.items[self.Horde_Gadget]
        if item then
            self:Horde_AddWeight(item.weight)
        end
    end
    hook.Run("Horde_OnUnsetGadget", self, self.Horde_Gadget)
    if SERVER then
        net.Start("Horde_Gadget")
            net.WriteUInt(HORDE.NET_PERK_UNSET, HORDE.NET_PERK_BITS)
            net.WriteEntity(self)
        net.Broadcast()
    end
    self.Horde_Gadget = nil
end

local prefix = "horde/gamemode/gadgets/"
local function Horde_LoadGadgets()
    local dev = GetConVar("developer"):GetBool()
    for _, f in ipairs(file.Find(prefix .. "*", "LUA")) do
        GADGET = {}
        AddCSLuaFile(prefix .. f)
        include(prefix .. f)
        if GADGET.Ignore then goto cont end
        GADGET.ClassName = string.lower(GADGET.ClassName or string.Explode(".", f)[1])
        GADGET.SortOrder = GADGET.SortOrder or 0

        hook.Run("Horde_OnLoadGadget", GADGET)

        HORDE.gadgets[GADGET.ClassName] = GADGET

        for k, v in pairs(GADGET.Hooks or {}) do
            hook.Add(k, "horde_gadget_" .. GADGET.ClassName, v)
        end

        if dev then print("[Horde] Loaded gadget '" .. GADGET.ClassName .. "'.") end
        ::cont::
    end
    GADGET = nil
end

Horde_LoadGadgets()

hook.Add("PlayerButtonDown", "Horde_UseKey", function(ply, key)
    if GetConVar("horde_disable_default_gadget_use_key"):GetInt() == 1 then return end
    if (key == KEY_T) then
        ply:ConCommand("horde_use_gadget")
    end
end)

if SERVER then
    function HORDE:UseGadget(ply)
        if ply:Horde_GetGadget() and HORDE.gadgets[ply:Horde_GetGadget()] and HORDE.gadgets[ply:Horde_GetGadget()].Active and ply:Horde_GetGadgetInternalCooldown() <= 0 and ply:Alive() then
            hook.Run("Horde_UseActiveGadget", ply)
            ply:Horde_SetGadgetInternalCooldown(ply:Horde_GetGadgetCooldown())
            net.Start("Horde_GadgetStartCooldown")
                net.WriteUInt(ply:Horde_GetGadgetCooldown(), 8)
            net.Send(ply)

            if HORDE.gadgets[ply:Horde_GetGadget()].Once then
                ply:Horde_UnsetGadget()
                ply:Horde_SyncEconomy()
            end
        end
    end

    hook.Add("PlayerPostThink", "Horde_GadgetCooldown", function(ply)
        if CurTime() >= ply:Horde_GetGadgetNextThink() then
            if ply:Horde_GetGadgetInternalCooldown() <= 0 then return end
            ply:Horde_SetGadgetInternalCooldown(ply:Horde_GetGadgetInternalCooldown() - 1)
            ply:Horde_SetGadgetNextThink(CurTime() + 1)
        end
    end)
end