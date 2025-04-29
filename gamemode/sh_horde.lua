CreateConVar("horde_default_enemy_config", 1, FCVAR_SERVER_CAN_EXECUTE, "Use default enemy wave config settings.")
CreateConVar("horde_default_item_config", 1, FCVAR_SERVER_CAN_EXECUTE, "Use default item config settings.")
CreateConVar("horde_default_class_config", 1, FCVAR_SERVER_CAN_EXECUTE, "Use default class config settings.")
CreateConVar("horde_max_wave", 10, FCVAR_SERVER_CAN_EXECUTE, "Max waves.")
CreateConVar("horde_break_time", 60, FCVAR_SERVER_CAN_EXECUTE, "Break time between waves.")
CreateConVar("horde_enable_shop", 1, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "Enables shop menu or not.")
CreateConVar("horde_enable_shop_icons", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Enables shop menu icons or not.")
CreateConVar("horde_enable_perk", 1, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "Enables perks or not.")
CreateConVar("horde_enable_rank", 1, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "Enables ranks or not.")
CreateConVar("horde_enable_client_gui", 1, FCVAR_SERVER_CAN_EXECUTE, "Enables client information ui or not.")
CreateConVar("horde_max_spawn_distance", 2000, FCVAR_SERVER_CAN_EXECUTE, "Maximum enenmy respawn distance.")
CreateConVar("horde_min_spawn_distance", 400, FCVAR_SERVER_CAN_EXECUTE, "Minimum enenmy respawn distance.")
CreateConVar("horde_max_spawn_z_distance", 500, FCVAR_SERVER_CAN_EXECUTE, "Maximum enemy respawn height difference with players.")

CreateConVar("horde_start_money", 900, FCVAR_SERVER_CAN_EXECUTE, "Money given at start.")
CreateConVar("horde_round_bonus", 500, FCVAR_SERVER_CAN_EXECUTE, "Round bonus given at the end of the round.")
CreateConVar("horde_enable_ammobox", 1, FCVAR_SERVER_CAN_EXECUTE, "Enable ammobox spawns.")
CreateConVar("horde_npc_cleanup", 1, FCVAR_SERVER_CAN_EXECUTE, "Kills all NPCs after a wave.")
CreateConVar("horde_external_lua_config", "", FCVAR_SERVER_CAN_EXECUTE, "Name of external config to load. This will take over the configs if exists.")
--CreateConVar("horde_starter_weapon_1", "", FCVAR_ARCHIVE, "Starter weapon 1.")
--CreateConVar("horde_starter_weapon_2", "", FCVAR_ARCHIVE, "Starter weapon 2.")

CreateConVar("horde_director_interval", 5, FCVAR_SERVER_CAN_EXECUTE, "Game director execution interval in seconds. Decreasing this increases spawn rate.")
CreateConVar("horde_max_enemies_alive_base", 20, FCVAR_SERVER_CAN_EXECUTE, "Maximum number of living enemies (base).")
CreateConVar("horde_max_enemies_alive_scale_factor", 5, FCVAR_SERVER_CAN_EXECUTE, "Scale factor of the maximum number of living enemies for multiplayer.")
CreateConVar("horde_max_enemies_alive_max", 50, FCVAR_SERVER_CAN_EXECUTE, "Maximum number of maximum living enemies.")
CreateConVar("horde_corpse_cleanup", 0, FCVAR_SERVER_CAN_EXECUTE, "Remove corpses.")

CreateConVar("horde_base_walkspeed", 180, FCVAR_SERVER_CAN_EXECUTE, "Base walkspeed.")
CreateConVar("horde_base_runspeed", 220, FCVAR_SERVER_CAN_EXECUTE, "Base runspeed.")

CreateConVar("horde_difficulty", 0, FCVAR_SERVER_CAN_EXECUTE, "Difficulty.")
CreateConVar("horde_disable_difficulty_voting", 0, FCVAR_SERVER_CAN_EXECUTE, "Disable difficulty voting.")
CreateConVar("horde_endless", 0, FCVAR_SERVER_CAN_EXECUTE, "Endless.")
CreateConVar("horde_total_enemies_scaling", 0, FCVAR_SERVER_CAN_EXECUTE, "Forces the gamemode to multiply maximum enemy count by this.")

CreateConVar("horde_perk_start_wave", 1, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "The wave when Tier 1 perks are active.")
CreateConVar("horde_perk_scaling", 2, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "The multiplier to the level for which wave it is unlocked. e.g. at 1.5, perk level 4 is unlocked at start_wave + 6.", 0)

CreateConVar("horde_enable_starter", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED, "Enables starter weapons.")
CreateConVar("horde_arccw_attinv_free", 1, FCVAR_SERVER_CAN_EXECUTE + FCVAR_REPLICATED, "Free ArcCW attachments.")

CreateConVar("horde_ready_countdown_ratio", 0.5, FCVAR_SERVER_CAN_EXECUTE, "Ratio of players required to start the 60 second countdown (0-1).")

CreateConVar("horde_enable_scoreboard", 1, FCVAR_SERVER_CAN_EXECUTE, "Enables built-in scoreboard.")
CreateConVar("horde_enable_3d2d_icon", 1, FCVAR_SERVER_CAN_EXECUTE, "Enables player icon renders.")

CreateConVar("horde_turret_spread", 0.5, FCVAR_SERVER_CAN_EXECUTE, "Turret spread.")

CreateConVar("horde_testing_unlimited_class_change", 0, FCVAR_SERVER_CAN_EXECUTE, "You can change a class for an unlimited times. Please use this only for testing purposes.")
CreateConVar("horde_testing_display_damage", 0, FCVAR_ARCHIVE, "Display damage for testing.")
CreateConVar("horde_display_damage", 1, FCVAR_ARCHIVE, "Display damage.")
CreateConVar("horde_enable_health_gui", 1, FCVAR_ARCHIVE, "Enables health UI.")
CreateConVar("horde_enable_ammo_gui", 1, FCVAR_ARCHIVE, "Enables ammo UI.")

CreateConVar("horde_enable_class_models", 1, FCVAR_ARCHIVE, "Enables ammo UI.")
CreateClientConVar("horde_disable_default_gadget_use_key", 0, FCVAR_ARCHIVE, "Disable default key bind for active gadgets.")
CreateClientConVar("horde_disable_default_quick_grenade_key", 0, FCVAR_ARCHIVE, "Disable default key bind for quick grenade.")

if SERVER then
util.AddNetworkString("Horde_SideNotification")
util.AddNetworkString("Horde_SideNotificationDebuff")
util.AddNetworkString("Horde_SideNotificationObjective")
util.AddNetworkString("Horde_PlayerInit")
util.AddNetworkString("Horde_SyncItems")
util.AddNetworkString("Horde_SyncEnemies")
util.AddNetworkString("Horde_SyncClasses")
util.AddNetworkString("Horde_SyncStatus")
util.AddNetworkString("Horde_SyncSpecialArmor")
util.AddNetworkString("Horde_PlayerReadySync")
util.AddNetworkString("Horde_AmmoboxCountdown")
util.AddNetworkString("Horde_SyncBossSpawned")
util.AddNetworkString("Horde_SyncBossHealth")
end

HORDE = {}
HORDE.__index = HORDE
HORDE.version = "1.1.2.1"
print("[HORDE] HORDE Version is " .. HORDE.version) -- Sanity check

HORDE.color_crimson = Color(220, 20, 60, 225)
HORDE.color_crimson_dim = Color(200, 0, 40)
HORDE.color_crimson_dark = Color(100,0,0)
HORDE.color_crimson_violet = Color(146, 43, 62)
HORDE.color_gadget_active = HORDE.color_crimson
HORDE.color_gadget_once = Color(238,130,238)
HORDE.color_hollow = Color(40,40,40,225)
HORDE.color_hollow_dim = Color(80, 80, 80, 225)
HORDE.color_config_bar = Color(50, 50, 50, 200)
HORDE.color_config_bg = Color(150, 150, 150, 200)
HORDE.color_config_content_bg = Color(230,230,230)
HORDE.color_none = Color(0,0,0,0)
HORDE.color_config_btn = Color(40,40,40)
HORDE.start_game = false
HORDE.total_enemies_per_wave = {15, 19, 23, 27, 30, 33, 36, 39, 42, 45}
--HORDE.total_enemies_per_wave = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

-- Director
HORDE.difficulty = 1
HORDE.total_enemies_this_wave = 0
HORDE.alive_enemies_this_wave = 0
HORDE.killed_enemies_this_wave = 0
HORDE.current_wave = 0
HORDE.total_break_time = math.max(10, GetConVarNumber("horde_break_time"))
HORDE.current_break_time = HORDE.total_break_time

HORDE.max_spawn_distance = math.max(100, GetConVarNumber("horde_max_spawn_distance"))
HORDE.min_spawn_distance = math.max(100, GetConVarNumber("horde_min_spawn_distance"))
HORDE.max_enemies_alive = 20
HORDE.spawned_enemies = {}
HORDE.spawned_enemies_count = {}
HORDE.ai_nodes = {}
HORDE.found_ai_nodes = false
HORDE.enemy_spawn_z = 6
HORDE.min_base_enemy_spawns_per_think = 4
HORDE.max_base_enemy_spawns_per_think = 5
HORDE.spawn_radius = 75
HORDE.max_max_waves = 10
HORDE.max_waves = math.min(HORDE.max_max_waves, math.max(1, GetConVarNumber("horde_max_wave")))
HORDE.start_money = math.max(0, GetConVarNumber("horde_start_money"))
HORDE.total_enemies_this_wave_fixed = 0
HORDE.kill_reward_base = 90
HORDE.round_bonus_base = GetConVar("horde_round_bonus"):GetInt()
HORDE.disable_levels_restrictions = 0
if CLIENT then
net.Receive("Horde_Disable_Levels", function ()
    HORDE.disable_levels_restrictions = 1
end)
end

HORDE.SPAWN_PROXIMITY = 0
HORDE.SPAWN_UNIFORM = 1
HORDE.SPAWN_PROXIMITY_NOISY = 2

-- Ammobox
HORDE.ammobox_max_count_limit = 9
HORDE.ammobox_refresh_interval = 60
HORDE.enable_ammobox = GetConVar("horde_enable_ammobox"):GetInt()

-- Statistics
-- Keep track of entities separately, so we don't have to network entities across
-- the network.
HORDE.player_drop_entities = {}
HORDE.player_ready = {}
HORDE.player_damage = {}
HORDE.player_damage_taken = {}
HORDE.player_heal = {}
HORDE.player_headshots = {}
HORDE.player_elite_kills = {}
HORDE.player_vote_map_change = {}
HORDE.player_kills_weapon = {}

-- Render / Gui
HORDE.render_highlight_disable = 0
HORDE.render_highlight_enemies = 1
HORDE.render_highlight_ammoboxes = 2
HORDE.difficulty_text = {"NORMAL", "HARD", "REALISM", "NIGHTMARE", "APOCALYPSE"}

-- ArcCW Attachments
if ArcCWInstalled then
    if GetConVar("horde_arccw_attinv_free"):GetInt() == 0 then
        RunConsoleCommand("arccw_attinv_free", "0")
    else
        RunConsoleCommand("arccw_attinv_free", "1")
    end

    -- Disable perks that messes up with Horde's own system.
    if GetConVar("horde_default_item_config"):GetInt() == 1 then
        ArcCW.AttachmentBlacklistTable["go_perk_headshot"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_ace"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_last"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_refund"] = true
        ArcCW.AttachmentBlacklistTable["go_perk_slow"] = true
        ArcCW.AttachmentBlacklistTable["go_m249_mag_12g_45"] = true
    end
end


-- Disable Godmode
RunConsoleCommand("sbox_godmode", "0")
RunConsoleCommand("vj_npc_addfrags", "0")
RunConsoleCommand("vj_npc_knowenemylocation", "1")
RunConsoleCommand("vj_npc_bleedenemyonmelee", "0")

-- Util functions
function HORDE:GiveAmmo(ply, wpn, count)
    local clip_size = wpn:GetMaxClip1()
    local ammo_id = wpn:GetPrimaryAmmoType()

    if clip_size > 0 then -- block melee
        ply:GiveAmmo(clip_size * count, ammo_id, false)
        return true
    else
        -- Give 1 piece of this ammo since clip size do not apply
        if ammo_id >= 1 then
            ply:GiveAmmo(count, ammo_id, false)
            return true
        end
    end
    return false
end

function HORDE:Round2(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function HORDE:GetUpgradePrice(class, ply)
    local level
    if CLIENT then
        level = MySelf:Horde_GetUpgrade(class)
    else
        level = ply:Horde_GetUpgrade(class)
    end
    if class == "horde_void_projector" or class == "horde_solar_seal" or class == "horde_astral_relic" or class == "horde_carcass" or class == "horde_pheropod" then
        local price = 800 + 25 * level
        return price
    else
        local base_price = HORDE.items[class].price
        local price = HORDE:Round2(math.max(100, base_price / 2) + math.max(10, base_price / 64) * level)
        return price
    end
end

-- Data structures
-- GLOBAL
HORDE.Stack = {}

-- Create a Table with stack functions
function HORDE.Stack:Create()

  -- stack table
  local t = {}
  -- entry table
  t._et = {}

  -- push a value on to the stack
  function t:push(...)
    if ... then
      local targs = {...}
      -- add values
      for _,v in ipairs(targs) do
        table.insert(self._et, v)
      end
    end
  end

  -- pop a value from the stack
  function t:pop(num)

    -- get num values from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
      -- get last entry
      if #self._et ~= 0 then
        table.insert(entries, self._et[#self._et])
        -- remove last value
        table.remove(self._et)
      else
        break
      end
    end
    -- return unpacked entries
    return unpack(entries)
  end

  -- get entries
  function t:getn()
    return #self._et
  end

  -- list values
  function t:list()
    for i,v in pairs(self._et) do
      print(i, v)
    end
  end
  return t
end

HORDE.Queue = {}
function HORDE.Queue:Create()
    local t = {}
    t._et = {}

    local first, last = 0, -1
    function t:push(item)
      last = last + 1
      t._et[last] = item
    end
    function t:pop()
      if first <= last then
        local value = t._et[first]
        t._et[first] = nil
        first = first + 1
        return value
      end
    end

    function t:size()
        return (last-first+1)
    end
    return t
end

--Custom Line of sight check
local function checkInSight(trace, targetent, advanced)
    if(!advanced) then
        trace.endpos = trace.endpos + targetent:OBBCenter()
        return util.TraceLine(trace).Fraction == 1
    else
        if(util.TraceLine(trace).Fraction == 1) then return true end
        trace.endpos = trace.endpos + targetent:OBBCenter()
        if(util.TraceLine(trace).Fraction == 1) then return true end
        trace.endpos = targetent:GetPos() + Vector(0, 0, targetent:OBBMaxs().z)
        if(util.TraceLine(trace).Fraction == 1) then return true end
        return false
    end
end

--[[
    checkmode :
        1 = Use Entity position for origin
        2 = Use Vector Given for origin

    originEntity = Entity that will be used for origin, only available when checkmode is 1
    originEntityCenter = Use origin entity's center position for origin
    originVector = Vector that will be used for origin, only available when checkmode is 2
    targetEntity = Entity to check

    advancedCheck = Use three points (Bottom, Center, Top) to check visibility, Will be 3x costy
    maxAngle = Maximum angle offset to target, leave empty to skip this check, only available when checkmode is 1
]]
function HORDE.IsInSight(data)
    local mode = data.checkmode || 1
    if(mode == 1) then
        local origin = data.originEntity:GetPos()
        if(data.originEntityCenter) then
            origin = origin + originEntity:OBBCenter()
        end
        local pos = data.targetEntity:GetPos()
        if(data.maxAngle) then
            local y1 = data.originEntity:GetAngles().y
            local y2 = (pos - origin):Angle().y
            if(math.NormalizeAngle(y1 - y2) > data.maxAngle) then
                return false
            end
        end
        local tr = {
            start = origin,
            endpos = pos,
            mask = MASK_SOLID_BRUSHONLY,
        }
        return checkInSight(tr, data.targetEntity, data.advancedCheck)
    else
        local pos = data.targetEntity:GetPos()
        local tr = {
            start = data.originVector,
            endpos = pos,
            mask = MASK_SOLID_BRUSHONLY,
        }
        return checkInSight(tr, data.targetEntity, data.advancedCheck)
    end
end

-- This is a SHARED file, you need to separate the codes for server and client
if(SERVER) then -- Codes for serverside
    util.AddNetworkString("Horde_ScreenEffect")

    function HORDE.SendBorderEffect(ply, data)
        net.Start("Horde_ScreenEffect")
        net.WriteTable(data)
        net.Send(ply)
    end
	--[[
	function HORDE.SetOldWeapons(player)
        player.OldWeapons = {}
        for k,v in ipairs(player:GetWeapons()) do
            table.insert(player.OldWeapons, v:GetClass())
        end
    end

    function HORDE.RestoreWeapons(player)
        if(!player.OldWeapons) then return end
        for k,v in ipairs(player.OldWeapons) do
            player:Give(v)
        end
        player.OldWeapons = {}
    end
	]]
else -- Codes for clientside
--Custom Border Screen effects
    HORDE.BorderDefaultMaterial = Material("materials/hud_effects/Rectangle_Effect_01.png")
    net.Receive("Horde_ScreenEffect", function()
        local data = net.ReadTable()
        HORDE:SetBorderEffects(data)
    end)

    HORDE.BorderEffects = {}
    
    function HORDE:RemoveAllScreenEffects()
        HORDE.BorderEffects = {}
    end
    
    function HORDE.GetFixedValue(inputNum)
        local target = 0.016666
        return inputNum / (target / RealFrameTime())
    end

    --[[
        id = ID for the border effects, it's REQUIRED
        material = Texture for the effect, leave empty for default fade texture
        color = Color for the effect, default white
        alpha = it explains itself
        time = Length of effect, default 1 seconds
        wait_til_end = Delay the fadeout until the draw time ends
        fadeoutspeed = Speed when fadingout, only works when wait_til_end is true
    ]]
    local default = {
        material = HORDE.BorderDefaultMaterial,
        color = Color(255, 255, 255, 255),
        alpha = 255,
        time = 1,
        wait_til_end = false,
        fadeoutspeed = 10,
    }
    function HORDE:SetBorderEffects(data)
        if(!data || !data.id) then return end
        local id = data.id
        local effect = {}
            effect.calpha = 255
        if(data.material) then
            data.material = Material(data.material)
        end
        if(!HORDE.BorderEffects[id]) then
            for index,val in pairs(default) do
                if(data[index]) then
                    effect[index] = data[index]
                else
                    effect[index] = val
                end
                if(index == "time") then
                    effect.endtime = CurTime() + effect[index]
                end
            end
            HORDE.BorderEffects[id] = effect
        else
            for index,val in pairs(data) do
                HORDE.BorderEffects[id][index] = val
                if(index == "time") then
                    HORDE.BorderEffects[id].endtime = CurTime() + val
                end
            end
        end
    end

    hook.Add("HUDPaintBackground", "HORDE_BorderEffect", function()
        if (!LocalPlayer():Alive()) then
            HORDE.BorderEffects = {}
        end
        for k,v in next, HORDE.BorderEffects do
            if(v.endtime <= CurTime()) then
                if(!v.wait_til_end) then
                    HORDE.BorderEffects[k] = nil
                    continue
                else
                    v.calpha = math.Clamp(v.calpha - HORDE.GetFixedValue(v.fadeoutspeed), 0, 255)
                    if(v.calpha <= 0) then
                        HORDE.BorderEffects[k] = nil
                        continue
                    end
                end
            end
            if(!v.wait_til_end) then
                v.calpha = v.alpha * math.Clamp((v.endtime - CurTime()) / v.time, 0, 1)
            end
            surface.SetDrawColor(v.color.r, v.color.g, v.color.b, v.calpha)
            surface.SetMaterial(v.material)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        end
    end)
    
    ---------Experimental Circle Paint----------------
    local clr = Color(0, 0, 0, 0)
    function HORDE.MaskedSphereRing(pos, radius, steps, thickness, color)
        cam.IgnoreZ(false)
        render.SetStencilEnable(true)
        render.SetStencilCompareFunction(STENCIL_ALWAYS)
        render.SetStencilPassOperation(STENCIL_KEEP)
        render.SetStencilFailOperation(STENCIL_KEEP)
        render.SetStencilZFailOperation(STENCIL_KEEP)
        render.SetStencilReferenceValue(1)
        render.SetStencilTestMask(255)
        render.SetStencilWriteMask(255)
        render.ClearStencil()
        render.SetColorMaterial()

        local r1, r2 = radius, radius + thickness

        render.SetStencilCompareFunction(STENCIL_ALWAYS)
        render.SetStencilZFailOperation(STENCIL_INCRSAT)
        render.DrawSphere(pos, -r2, steps, steps, clr)
        render.SetStencilZFailOperation(STENCIL_DECR)
        render.DrawSphere(pos, r2, steps, steps, clr)
        render.SetStencilZFailOperation(STENCIL_INCR)
        render.DrawSphere(pos, -r1, steps, steps, clr)
        render.SetStencilZFailOperation(STENCIL_DECR)
        render.DrawSphere(pos, r1, steps, steps, clr)

        local dir = LocalPlayer():EyeAngles():Forward()

        render.SetStencilCompareFunction( STENCIL_EQUAL )
        render.SetStencilReferenceValue( 1 )
        render.DrawQuadEasy(EyePos() + dir * 10, -dir, 200, 200, color, 0)

        render.SetStencilEnable(false)
    end
    --[[
    net.Receive("Horde_GetPerkLevelBonus", function()
        local ply = net.ReadEntity()
        local perk = net.ReadString()
        local bonus = net.ReadFloat()
        if not ply:IsValid() then return end
        ply:Horde_SetPerkLevelBonus(perk, bonus)
    end)
    ]]
    
    --network this so arccw attachments know you're in trader zone
    net.Receive("Horde_IsInBuyZone", function()
        local int = net.ReadBool()
        local ply = LocalPlayer()
        if not ply:IsValid() then return end
        ply.Horde_CanBuy = int
    end)
    
    --network this so arccw attachments know you're in trader time
    net.Receive("Horde_IsInBreakTime", function()
        local int = net.ReadBool()
        local ply = LocalPlayer()
        if not ply:IsValid() then return end
        ply.Horde_IsInBreakTime = int
    end)
    
    ---------- highlighted text test ---------------------------------------------------------
    --[[
    local label = vgui.Create("RichText", ui)
    label:SetPos(imggap, title:GetY() + title:GetTall() + imggap)
    label:SetSize(maxwide, ui:GetTall())
    label:SetFontInternal("ZScenario-UISmall2x")
    label:InsertColorChange(255, 255, 255, 255)
    local clr = color_white
    local expected_tag, expected_endtag, expecting_endtag = "<clr>", "<clr>", false
    local skipTo = -1
    local tmp = ""
    for i = 1, #str do
        local f = string.sub(str, i, i + 4)
        if(!expecting_endtag) then
            if(f == expected_tag) then
                expecting_endtag = true
                local r, g, b = 255, 255, 255
                local hex = string.sub(str, i + 6, i + 11)
                label:InsertColorChange(tonumber(string.sub(hex, 1, 2), 16), tonumber(string.sub(hex, 3, 4), 16), tonumber(string.sub(hex, 5, 6), 16), 255)
                skipTo = i + 12
            end
        else
            if(f == expected_tag) then
                expecting_endtag = false
                label:InsertColorChange(255, 255, 255, 255)
                skipTo = i + 4
            end
        end
        if(i > skipTo) then
            label:AppendText(str[i])
        end
    end
    ]]
    ------------------------------------------------------------------------
    
    hook.Add("PreDrawOpaqueRenderables", "Horde_Circle_Preview_Range", function(depth, skybox, skybox3d)
        hook.Run("PreDraw_ImmersionBreakingCircles")
    end)
    
    
end
