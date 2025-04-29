HORDE.NET_PERK_SET = 1
HORDE.NET_PERK_UNSET = 2
HORDE.NET_PERK_CLEAR = 3

HORDE.NET_PERK_BITS = 2

HORDE.perks = HORDE.perks or {}

if SERVER then
util.AddNetworkString("Horde_PerkStartCooldown")
util.AddNetworkString("Horde_PerkChargesUpdate")
util.AddNetworkString("Horde_PerkCooldownCheck")
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

    net.Receive("Horde_SyncPerk", function ()
        local ply = net.ReadEntity()
        local perk_choices = net.ReadTable()
        if ply ~= MySelf then
            if !IsValid(ply) then return end
            if not ply.Horde_PerkChoices then ply.Horde_PerkChoices = {} end
            if not ply:Horde_GetCurrentSubclass() then return end
            ply.Horde_PerkChoices[ply:Horde_GetCurrentSubclass()] = perk_choices
        end
    end)

    -- Get our saved choice and send it to the server
    function HORDE:SendSavedPerkChoices(class)
        local tbl = MySelf.Horde_PerkChoices
        if not tbl or tbl == {} then
            local f = file.Read("horde/perk_choices.txt", "DATA")
            if f then
                MySelf.Horde_PerkChoices = util.JSONToTable(f)
                tbl = MySelf.Horde_PerkChoices
            end
        end

        net.Start("Horde_PerkChoice")
            net.WriteString(class)
            net.WriteUInt(0, 4)
            for perk_level = 1,4 do
                if not tbl or not tbl[class] then
                    net.WriteUInt(1, 4)
                else
                    net.WriteUInt(tbl[class][perk_level] or 1, 4)
                end
            end
        net.SendToServer()
    end
    net.Receive("Horde_PerkChoice", function() HORDE:SendSavedPerkChoices(MySelf:Horde_GetCurrentSubclass()) end)
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

    if self:Alive() then
        -- No need to set perks when dead
        hook.Run("Horde_OnSetPerk", self, perk)
    end

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

    for subclass_name, subclass in pairs(HORDE.subclasses) do
        prefix = "horde/gamemode/perks/" .. subclass_name .. "/"
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
    end
    PERK = nil
end

if GetConVar("horde_enable_perk"):GetInt() == 1 then
    Horde_LoadPerks()
end

if game.SinglePlayer() then
    hook.Add("PlayerButtonDown", "Horde_UseKeyAndShift", function(ply, key)
        if (key == KEY_E) and (ply.Horde_In_LShift) then
            ply:ConCommand("horde_use_perk_skill")
        end
    end)
    
    hook.Add("PlayerButtonDown", "Horde_UseKeyAndShift2", function(ply, key)
        if (key == KEY_LSHIFT) then
            ply.Horde_In_LShift = true
        end
    end)
    
    hook.Add("PlayerButtonUp", "Horde_UseKeyAndShift3", function(ply, key)
        if (key == KEY_LSHIFT) then
            ply.Horde_In_LShift = nil
        end
    end)

    hook.Add("PlayerButtonDown", "Horde_G_Key", function(ply, key)
        if GetConVar("horde_disable_default_quick_grenade_key"):GetInt() == 1 then return end
        if (key == KEY_G) then
            ply:ConCommand("horde_use_quick_grenade")
        end
    end)
else
    if CLIENT then
    hook.Add("PlayerButtonDown", "Horde_UseKeyAndShift", function(ply, key)
        if (key == KEY_E) and input.IsButtonDown(KEY_LSHIFT) then
            ply:ConCommand("horde_use_perk_skill")
        end
    end)

    hook.Add("PlayerButtonDown", "Horde_G_Key", function(ply, key)
        if GetConVar("horde_disable_default_quick_grenade_key"):GetInt() == 1 then return end
        if (key == KEY_G) then
            ply:ConCommand("horde_use_quick_grenade")
        end
    end)
    end
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
    if SERVER then
        net.Start("Horde_PerkCooldownCheck")
            net.WriteInt(cd, 8)
        net.Send(self)
    end
end

function plymeta:Horde_SetPerkInternalCooldown(cd)
    self.Horde_PerkInternalCooldown = cd
end

function plymeta:Horde_SetPerkCharges(charges)
    self.Horde_PerkCharges = charges
    if SERVER then
        net.Start("Horde_PerkChargesUpdate")
            net.WriteInt(charges, 8)
        net.Send(self)
    end
end

function plymeta:Horde_GetPerkInternalCooldown()
    return self.Horde_PerkInternalCooldown or 0
end

function plymeta:Horde_GetPerkCooldown()
    return self.Horde_PerkCooldown or 0
end

function plymeta:Horde_GetSpamPerkCooldown()
    return self.Horde_SpamPerkCooldown or 0
end

function plymeta:Horde_SetSpamPerkCooldown(cd)
    self.Horde_SpamPerkCooldown = cd
end

function plymeta:Horde_GetPerkCharges(charges)
    return self.Horde_PerkCharges or -1
end


if SERVER then
    function HORDE:RefreshPerkCooldown(ply)
        ply:Horde_SetPerkInternalCooldown(0)
        net.Start("Horde_PerkStartCooldown")
            net.WriteUInt(0, 8)
        net.Send(ply)
    end
    
    local think_t = 0.5
    local BufferTime = 0.5 -- +-0.25s
    function HORDE:UsePerkSkill(ply, auto)
        if ply:Horde_GetSpamPerkCooldown() <= CurTime() and ply:Alive() then
            local cd = ply:Horde_GetPerkInternalCooldown()
            if(cd > 0 && !auto) then
                if(cd <= BufferTime) and ply:Horde_GetPerkCooldown() >= 1 then
                    ply.QueuedPerkSkill = true
                end
                return
            end
            local res = hook.Run("Horde_UseActivePerk", ply)
            if res then return end
            ply:Horde_SetPerkInternalCooldown(ply:Horde_GetPerkCooldown())
            ply:Horde_SetPerkNextThink(CurTime() + think_t)
            net.Start("Horde_PerkStartCooldown")
                net.WriteUInt(ply:Horde_GetPerkCooldown(), 8)
            net.Send(ply)
        end
    end

    hook.Add("PlayerPostThink", "Horde_PerkCooldown", function(ply)
        if CurTime() >= ply:Horde_GetPerkNextThink() then
            ply:Horde_SetPerkNextThink(CurTime() + think_t)
            local cd = ply:Horde_GetPerkInternalCooldown()
            local newcd = cd - think_t
            if(newcd <= 0) then
                if(ply.QueuedPerkSkill) then
                    newcd = 0
                    HORDE:UsePerkSkill(ply, true)
                    ply.QueuedPerkSkill = false
                    return
                end
            end
            if(cd <= 0) then
                return
            end
            ply:Horde_SetPerkInternalCooldown(newcd)
        end
    end)

    -- Quick Grenade. It's hand crafted for now so it won't work with workshop subclasses.
    function HORDE:UseQuickGrenade(ply)
        if ply:HasWeapon("horde_carcass") or ply:HasWeapon("horde_astral_relic") or ply:HasWeapon("horde_void_projector") or ply:HasWeapon("horde_solar_seal") then return end
        local classes = {
            --[[ -- Survivor and Psycho will get their own special grenade instead of default. Default grenade doesn't work well.
            ["Survivor"] = {
                grenadeclass = "weapon_frag",
                grenadethrown = "npc_grenade_frag",
            },
            ["Psycho"] = {
                grenadeclass = "weapon_frag",
                grenadethrown = "npc_grenade_frag",
            },
            ]]
            ["Assault"] = {
                grenadeclass = "arccw_horde_nade_stun",
                grenadethrown = "arccw_thr_stun",
            },
            ["SpecOps"] = {
                grenadeclass = "arccw_horde_nade_stun",
                grenadethrown = "arccw_thr_stun",
            },
            ["Heavy"] = {
                grenadeclass = "arccw_horde_nade_shrapnel",
                grenadethrown = "arccw_thr_shrapnel",
            },
            --Carcass can't use grenades
            ["Medic"] = {
                grenadeclass = "arccw_nade_medic",
                grenadethrown = "arccw_thr_medicgrenade",
            },
            ["Hatcher"] = {
                grenadeclass = "arccw_nade_medic",
                grenadethrown = "arccw_thr_medicgrenade",
            },
            ["Demolition"] = {
                grenadeclass = "arccw_horde_m67",
                grenadethrown = "arccw_thr_horde_m67",
            },
            --Warlock can't use grenades
            ["Ghost"] = {
                grenadeclass = "arccw_horde_nade_sonar",
                grenadethrown = "arccw_thr_sonar",
            },
            ["Gunslinger"] = {
                grenadeclass = "arccw_horde_nade_sonar",
                grenadethrown = "arccw_thr_sonar",
            },
            ["Engineer"] = {
                grenadeclass = "arccw_horde_nade_nanobot",
                grenadethrown = "arccw_thr_nanobot",
            },
            --Necromancer can't use grenades
            ["Berserker"] = {
                grenadeclass = "arccw_horde_nade_hemo",
                grenadethrown = "arccw_thr_hemo",
            },
            ["Samurai"] = {
                grenadeclass = "arccw_horde_nade_hemo",
                grenadethrown = "arccw_thr_hemo",
            },
            ["Warden"] = {
                grenadeclass = "arccw_horde_nade_emp",
                grenadethrown = "arccw_thr_emp",
            },
            ["Overlord"] = {
                grenadeclass = "arccw_horde_nade_emp",
                grenadethrown = "arccw_thr_emp",
            },
            ["Cremator"] = {
                grenadeclass = "arccw_horde_nade_molotov",
                grenadethrown = "arccw_thr_horde_molotov",
            },
            --Artificer can't use grenades
        }
        
        local nade = ply:GetActiveWeapon()
        if classes[ply:Horde_GetCurrentSubclass()] == nil then return end
        if ply:GetAmmoCount("Grenade") <= 0 or nade.Base == "arccw_horde_base_nade" or (!ply:HasWeapon(classes[ply:Horde_GetCurrentSubclass()].grenadeclass)) then 
            ply:EmitSound("player/suit_denydevice.wav") return 
        end
        
        if ply:Horde_GetSpamPerkCooldown() > CurTime() then return true end
        ply:Horde_SetSpamPerkCooldown(CurTime() + 0.35)
        ply:SetAmmo(ply:GetAmmoCount("Grenade") - 1, "Grenade")
        ply.GrenadeDampened = true
        
        local grenade = ents.Create(classes[ply:Horde_GetCurrentSubclass()].grenadethrown)
        local vel = 15
        local ang = ply:EyeAngles()

        local src = (ply:EyePos() + Vector(0,0,-3) + ( ply:GetAimVector() * 16 ) + (ply:GetRight()*-4))

        if !grenade:IsValid() then print("!!! INVALID ROUND " .. grenade) return end

        local grenadeAng = Angle(ang.p, ang.y, ang.r)

        grenade:SetAngles(grenadeAng)
        grenade:SetPos(src)

        grenade:SetOwner(ply)
        grenade.Owner = ply
        grenade.Inflictor = grenade

        local RealVelocity = (ply:GetAbsVelocity() or Vector(0, 0, 0)) + ang:Forward() * vel / 0.0254
        grenade.CurVel = RealVelocity -- for non-physical projectiles that move themselves

        grenade:Spawn()
        grenade:Activate()
        
        local spin = grenade:GetPhysicsObject()
        spin:AddAngleVelocity(Vector(0, -750, 0))
        
        if !grenade.NoPhys and grenade:GetPhysicsObject():IsValid() then
            grenade:SetCollisionGroup(grenade.CollisionGroup or COLLISION_GROUP_DEBRIS)
            grenade:GetPhysicsObject():SetVelocityInstantaneous(RealVelocity)
        end

        if grenade.Launch and grenade.SetState then
            grenade:SetState(1)
            grenade:Launch()
        end
    end
end