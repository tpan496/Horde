if SERVER then return end
include("shared.lua")
include("sh_horde.lua")
include("sh_item.lua")
include("sh_class.lua")
include("sh_enemy.lua")
include("sh_custom.lua")
include("cl_economy.lua")
include("gui/cl_ready.lua")
include("gui/cl_class.lua")
include("gui/cl_description.lua")
include("gui/cl_item.lua")
include("gui/cl_itemconfig.lua")
include("gui/cl_classconfig.lua")
include("gui/cl_enemyconfig.lua")
include("gui/cl_configmenu.lua")
include("gui/cl_shop.lua")
include("gui/cl_summary.lua")
include("gui/cl_scoreboard.lua")

-- Some users report severe lag with halo
CreateConVar("horde_enable_halo", 1, FCVAR_LUA_CLIENT, "Enables highlight for last 10 enemies.")

local center_panel = vgui.Create("DPanel")
center_panel:SetSize(300, 50)
center_panel:SetPos(25, 80)
center_panel.Paint = function () end

local corner_panel = vgui.Create("DPanel")
corner_panel:SetSize(300, 50)
corner_panel:SetPos(25, 25)
corner_panel.Paint = function () end
timer.Simple(5, function ()
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    corner_panel.Paint = function ()
        draw.RoundedBox(10, 0, 0, 300, 50, Color(40,40,40,200))
        if LocalPlayer():Alive() then
            if LocalPlayer():GetHordeClass() then
                draw.SimpleText(LocalPlayer():GetHordeClass().name .. " | " .. math.min(99999,LocalPlayer():GetHordeMoney()) .. "$", "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText("Survivor" .. " | " .. math.min(99999,LocalPlayer():GetHordeMoney()) .. "$", "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            draw.SimpleText("Spectating", "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)

function HORDE:ToggleShop()
    if not HORDE.ShopGUI then
        HORDE.ShopGUI = vgui.Create('HordeShop')
        HORDE.ShopGUI:SetVisible(false)
    end
    
    if HORDE.ShopGUI:IsVisible() then
        HORDE.ShopGUI:Hide()
        gui.EnableScreenClicker(false)
    else
        HORDE.ShopGUI:Remove()
        HORDE.ShopGUI = vgui.Create('HordeShop')
        HORDE.ShopGUI:Show()
        gui.EnableScreenClicker(true)
    end
end

function HORDE:ToggleItemConfig()
    if not HORDE.ItemConfigGUI then
        HORDE.ItemConfigGUI = vgui.Create('HordeItemConfig')
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
        HORDE.EnemyConfigGUI = vgui.Create('HordeEnemyConfig')
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
        HORDE.ClassConfigGUI = vgui.Create('HordeClassConfig')
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

function HORDE:ToggleConfigMenu()
    if not HORDE.ConfigMenuGUI then
        HORDE.ConfigMenuGUI = vgui.Create('HordeConfigMenu')
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


net.Receive("Horde_HighlightEnemies", function (len, ply)
    if GetConVarNumber("horde_enable_halo") == 0 then return end
    local render = net.ReadInt(2)
    if render == 1 then
        hook.Add("PreDrawHalos", "Horde_AddPropHalos", function()
            halo.Add(ents.FindByClass("npc*"), Color(255, 0, 0), 1, 1, 2, true, true)
        end)
    else
        hook.Remove("PreDrawHalos", "Horde_AddPropHalos")
    end
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

net.Receive("Horde_ToggleConfigMenu", function ()
    HORDE:ToggleConfigMenu()
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

    gui.EnableScreenClicker(false)
end)

net.Receive('Horde_LegacyNotification', function(length)
    local str = net.ReadString()
    local type = net.ReadInt(2)
    if type == 0 then
        notification.AddLegacy(str, NOTIFY_GENERIC, 5)
    else
        notification.AddLegacy(str, NOTIFY_ERROR, 5)
    end
end)

net.Receive('Horde_RenderCenterText', function ()
    local str = net.ReadString()
    local num = net.ReadInt(8)
    if num and num >= 0 and num <= 10 then
        if HORDE.PlayerReadyPanel then
            HORDE.PlayerReadyPanel:Remove()
        end
        if num == 10 then
            surface.PlaySound("HL1/fvox/ten.wav")
        elseif num == 5 then
            surface.PlaySound("HL1/fvox/five.wav")
        elseif num == 0 then
            surface.PlaySound("ambient/alarms/manhack_alert_pass1.wav")
        else
            surface.PlaySound("cd/" .. tostring(num) ..".mp3")
        end
    end
    if GetConVarNumber("horde_enable_client_gui") == 0 then return end
    center_panel.Paint = function (w, h)
        draw.RoundedBox(10, 0, 0, 300, 50, Color(40,40,40,200))
        draw.SimpleText(str, "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)

net.Receive('Horde_GameEnd', function ()
    local mvp = net.ReadEntity()
    local mvp_damage = net.ReadInt(32)
    local mvp_kills = net.ReadInt(32)

    local damage_player = net.ReadEntity()
    local most_damage = net.ReadInt(32)

    local kills_player = net.ReadEntity()
    local most_kills = net.ReadInt(32)
    
    local money_player = net.ReadEntity()
    local most_money = net.ReadInt(32)

    local headshot_player = net.ReadEntity()
    local most_headshots = net.ReadInt(32)

    local elite_kill_player = net.ReadEntity()
    local most_elite_kills = net.ReadInt(32)

    local damage_taken_player = net.ReadEntity()
    local most_damage_taken = net.ReadInt(32)
    
    local total_damage = net.ReadInt(32)

    local maps = net.ReadTable()

    local end_gui = vgui.Create("HordeSummaryPanel")
    end_gui:SetData(mvp, mvp_damage, mvp_kills, damage_player, most_damage, kills_player, most_kills, money_player, most_money, headshot_player, most_headshots, elite_kill_player, most_elite_kills, damage_taken_player, most_damage_taken, total_damage, maps)

    HORDE.game_ended = true
end)

net.Receive("Horde_SyncItems", function ()
	HORDE.items = net.ReadTable()
end)

net.Receive("Horde_SyncEnemies", function ()
	HORDE.enemies = net.ReadTable()
end)

net.Receive("Horde_SyncClasses", function ()
    HORDE.classes = net.ReadTable()
end)

hook.Add("HUDShouldDraw", "Horde_RemoveRetardRedScreen", function(name) 
    if (name == "CHudDamageIndicator") then
       return false
    end
end)

hook.Add("InitPostEntity", "Horde_PlayerInit", function()
	net.Start("Horde_PlayerInit")
	net.SendToServer()
end )