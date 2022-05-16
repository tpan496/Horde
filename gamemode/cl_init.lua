include("shared.lua")
include("sh_particles.lua")
include("sh_translate.lua")
include("sh_horde.lua")
include("sh_gadget.lua")
include("sh_status.lua")
include("sh_damage.lua")
include("sh_infusion.lua")
include("sh_item.lua")
include("sh_class.lua")
include("sh_mutation.lua")
include("sh_enemy.lua")
include("sh_perk.lua")
include("sh_maps.lua")
include("sh_custom.lua")
include("sh_rank.lua")
include("sh_sync.lua")
include("sh_misc.lua")

include("cl_economy.lua")
include("cl_achievement.lua")
include("gui/cl_gameinfo.lua")
include("gui/cl_status.lua")
include("gui/cl_ready.lua")
include("gui/cl_class.lua")
include("gui/cl_description.lua")
include("gui/cl_infusion.lua")
include("gui/cl_item.lua")
include("gui/cl_itemconfig.lua")
include("gui/cl_classconfig.lua")
include("gui/cl_enemyconfig.lua")
include("gui/cl_mapconfig.lua")
include("gui/cl_configmenu.lua")
include("gui/cl_shop.lua")
include("gui/cl_stats.lua")
include("gui/cl_summary.lua")
include("gui/cl_scoreboard.lua")
include("gui/cl_3d2d.lua")
include("gui/cl_subclassbutton.lua")
include("gui/cl_perkbutton.lua")

-- Some users report severe lag with halo
CreateConVar("horde_enable_halo", 1, FCVAR_LUA_CLIENT, "Enables highlight for last 10 enemies.")

function HORDE:ToggleShop()
    if not HORDE.ShopGUI then
        HORDE.ShopGUI = vgui.Create("HordeShop")
        HORDE.ShopGUI:SetVisible(false)
    end

    if HORDE.ShopGUI:IsVisible() then
        HORDE.ShopGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.ShopGUI:Remove()
        if HORDE.StatsGUI then
            HORDE.StatsGUI:Remove()
        end
        HORDE.ShopGUI = vgui.Create("HordeShop")
        HORDE.ShopGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

function HORDE:ToggleStats()
    if not HORDE.StatsGUI then
        HORDE.StatsGUI = vgui.Create("HordeStats")
        HORDE.StatsGUI:SetVisible(false)
    end

    if HORDE.StatsGUI:IsVisible() then
        HORDE.StatsGUI:Hide()
        gui.EnableScreenClicker(false)
        timer.Remove("Horde_PollStats")
    else
        if HORDE.ShopGUI then
            HORDE.ShopGUI:Remove()
        end
        HORDE.StatsGUI:Remove()
        HORDE.StatsGUI = vgui.Create("HordeStats")
        HORDE.StatsGUI:Show()
        gui.EnableScreenClicker(true)
        HORDE:GetStats()
        timer.Create("Horde_PollStats", 1, 0, function ()
            HORDE:GetStats()
        end)
    end
end

function HORDE:ToggleItemConfig()
    if not HORDE.ItemConfigGUI then
        HORDE.ItemConfigGUI = vgui.Create("HordeItemConfig")
        HORDE.ItemConfigGUI:SetVisible(false)
    end

    if HORDE.ItemConfigGUI:IsVisible() then
        HORDE.ItemConfigGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.ItemConfigGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

function HORDE:ToggleEnemyConfig()
    if not HORDE.EnemyConfigGUI then
        HORDE.EnemyConfigGUI = vgui.Create("HordeEnemyConfig")
        HORDE.EnemyConfigGUI:SetVisible(false)
    end

    if HORDE.EnemyConfigGUI:IsVisible() then
        HORDE.EnemyConfigGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.EnemyConfigGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

function HORDE:ToggleClassConfig()
    if not HORDE.ClassConfigGUI then
        HORDE.ClassConfigGUI = vgui.Create("HordeClassConfig")
        HORDE.ClassConfigGUI:SetVisible(false)
    end

    if HORDE.ClassConfigGUI:IsVisible() then
        HORDE.ClassConfigGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.ClassConfigGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

function HORDE:ToggleMapConfig()
    if not HORDE.MapConfigGUI then
        HORDE.MapConfigGUI = vgui.Create("HordeMapConfig")
        HORDE.MapConfigGUI:SetVisible(false)
    end
    
    if HORDE.MapConfigGUI:IsVisible() then
        HORDE.MapConfigGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.MapConfigGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

function HORDE:ToggleConfigMenu()
    if not HORDE.ConfigMenuGUI then
        HORDE.ConfigMenuGUI = vgui.Create("HordeConfigMenu")
        HORDE.ConfigMenuGUI:SetVisible(false)
    end

    if HORDE.ConfigMenuGUI:IsVisible() then
        HORDE.ConfigMenuGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.ConfigMenuGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

-- Entity Highlights
HORDE.Player_Looking_At_Minion = nil
if GetConVarNumber("horde_enable_halo") == 1 then
    hook.Add("PreDrawHalos", "Horde_AddMinionHalos", function()
        local ent = util.TraceLine(util.GetPlayerTrace(LocalPlayer())).Entity
        if ent and ent:IsValid() then
            if ent:GetNWEntity("HordeOwner") and ent:GetNWEntity("HordeOwner") == LocalPlayer() then
                -- Do not highlight minions if they do not belong to you
                halo.Add({ent}, Color(0, 255, 0), 1, 1, 1, true, true)
                HORDE.Player_Looking_At_Minion = ent
            end
        else
            HORDE.Player_Looking_At_Minion = nil
        end
    end)
end

net.Receive("Horde_HighlightEntities", function (len, ply)
    if GetConVarNumber("horde_enable_halo") == 0 then return end
    local render = net.ReadInt(3)
    if render == HORDE.render_highlight_enemies then
        hook.Add("PreDrawHalos", "Horde_AddEnemyHalos", function()
            local enemies = ents.FindByClass("npc*")
            for key, enemy in pairs(enemies) do
                if enemy:GetNWEntity("HordeOwner"):IsPlayer() then
                    -- Do not highlight friendly minions
                    enemies[key] = nil
                end
            end
            halo.Add(enemies, Color(255, 0, 0), 1, 1, 1, true, true)
        end)
    elseif render == HORDE.render_highlight_ammoboxes then
        hook.Add("PreDrawHalos", "Horde_AddAmmoBoxHalos", function()
            halo.Add(ents.FindByClass("horde_ammobox"), Color(0, 255, 0), 1, 1, 1, true, true)
        end)
        timer.Simple(10, function ()
            hook.Remove("PreDrawHalos", "Horde_AddAmmoBoxHalos")
        end)
    else
        hook.Remove("PreDrawHalos", "Horde_AddEnemyHalos")
        hook.Remove("PreDrawHalos", "Horde_AddAmmoBoxHalos")
    end
end)

net.Receive("Horde_DeathMarkHighlight", function(len,ply)
    local entity = net.ReadEntity()
    local idx = entity:EntIndex()
    hook.Add("PreDrawHalos", "Horde_DeathMarkHalo" .. idx, function()
        if !entity:IsValid() then hook.Remove("PreDrawHalos", "Horde_DeathMarkHalo" .. idx) end
        halo.Add({entity}, Color(255, 0, 255), 3, 3, 1, true, true)
    end)
end)

net.Receive("Horde_RemoveDeathMarkHighlight", function(len,ply)
    hook.Remove("PreDrawHalos", "Horde_DeathMarkHalo" .. net.ReadEntity():EntIndex())
end)

net.Receive("Horde_ToggleShop", function ()
    HORDE:ToggleShop()
end)

net.Receive("Horde_ToggleItemConfig", function ()
    HORDE:ToggleItemConfig()
end)

net.Receive("Horde_ToggleEnemyConfig", function ()
    HORDE:ToggleEnemyConfig()
end)

net.Receive("Horde_ToggleClassConfig", function ()
    HORDE:ToggleClassConfig()
end)

net.Receive("Horde_ToggleMapConfig", function ()
    HORDE:ToggleMapConfig()
end)

net.Receive("Horde_ToggleConfigMenu", function ()
    HORDE:ToggleConfigMenu()
end)

net.Receive("Horde_ToggleStats", function ()
    HORDE:ToggleStats()
end)

net.Receive("Horde_ForceCloseShop", function ()
    if HORDE.ShopGUI then
        if HORDE.ShopGUI:IsVisible() then
            HORDE.ShopGUI:Hide()
        end
    end

    if HORDE.ItemConfigGUI then
        if HORDE.ItemConfigGUI:IsVisible() then
            HORDE.ItemConfigGUI:Hide()
        end
    end

    if HORDE.EnemyConfigGUI then
        if HORDE.EnemyConfigGUI:IsVisible() then
            HORDE.EnemyConfigGUI:Hide()
        end
    end

    HORDE.TipPanel:SetVisible(false)

    gui.EnableScreenClicker(false)
end)

net.Receive("Horde_LegacyNotification", function(length)
    local str = net.ReadString()
    local type = net.ReadInt(2)
    if type == 0 then
        notification.AddLegacy(str, NOTIFY_GENERIC, 5)
    else
        notification.AddLegacy(str, NOTIFY_ERROR, 5)
    end
end)

net.Receive("Horde_SyncItems", function ()
    local len = net.ReadUInt(32)
    local data = net.ReadData(len)
    local str = util.Decompress(data)
    HORDE.items = util.JSONToTable(str)
end)

net.Receive("Horde_SyncEnemies", function ()
    local len = net.ReadUInt(32)
    local data = net.ReadData(len)
    local str = util.Decompress(data)
    HORDE.enemies = util.JSONToTable(str)
end)

net.Receive("Horde_SyncDifficulty", function ()
    HORDE.difficulty = net.ReadUInt(3)
end)

net.Receive("Horde_SyncMaps", function ()
    HORDE.map_whitelist = net.ReadTable()
    HORDE.map_blacklist = net.ReadTable()
end)

net.Receive("Horde_SyncMutations", function ()
    HORDE.mutations = net.ReadTable()
end)

hook.Add("HUDShouldDraw", "Horde_RemoveRetardRedScreen", function(name)
    if (name == "CHudDamageIndicator") then
       return false
    end
end)

net.Receive("Horde_GameEnd", function ()
    local status = net.ReadString()

    local mvp = net.ReadEntity()
    local mvp_damage = net.ReadInt(32)
    local mvp_kills = net.ReadInt(32)

    local damage_player = net.ReadEntity()
    local most_damage = net.ReadInt(32)

    local kills_player = net.ReadEntity()
    local most_kills = net.ReadInt(32)

    local most_heal_player = net.ReadEntity()
    local most_heal = net.ReadInt(32)

    local headshot_player = net.ReadEntity()
    local most_headshots = net.ReadInt(32)

    local elite_kill_player = net.ReadEntity()
    local most_elite_kills = net.ReadInt(32)

    local damage_taken_player = net.ReadEntity()
    local most_damage_taken = net.ReadInt(32)

    local total_damage = net.ReadInt(32)

    local maps = net.ReadTable()

    local end_gui = vgui.Create("HordeSummaryPanel")
    end_gui:SetData(status, mvp, mvp_damage, mvp_kills, damage_player, most_damage, kills_player, most_kills, most_heal_player, most_heal, headshot_player, most_headshots, elite_kill_player, most_elite_kills, damage_taken_player, most_damage_taken, total_damage, maps)
end)

killicon.AddAlias("arccw_horde_awp", "arccw_go_awp")
killicon.AddAlias("arccw_horde_barret", "arccw_mw2_barrett")
killicon.Add("arccw_nade_medic", "arccw/weaponicons/arccw_nade_medic", Color(0, 0, 0, 255))
killicon.Add("npc_turret_floor", "vgui/hud/npc_turret_floor", Color(0, 0, 0, 255))