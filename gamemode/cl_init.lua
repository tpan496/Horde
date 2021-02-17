if SERVER then return end

include("shared.lua")
include("sh_config.lua")
include("cl_economy.lua")
include("class/sh_class.lua")
include("gui/cl_class.lua")
include("gui/cl_description.lua")
include("gui/cl_item.lua")
include("gui/cl_itemconfig.lua")
include("gui/cl_enemyconfig.lua")
include("gui/cl_shop.lua")

local center_panel = vgui.Create("DPanel")
center_panel:SetSize(300, 50)
center_panel:SetPos(25, 80)
center_panel.Paint = function () end

local corner_panel = vgui.Create("DPanel")
corner_panel:SetSize(300, 50)
corner_panel:SetPos(25, 25)
corner_panel.Paint = function () end
timer.Simple(5, function ()
	corner_panel.Paint = function ()
		draw.RoundedBox(10, 0, 0, 300, 50, Color(40,40,40,200))
		if LocalPlayer():Alive() then
			draw.SimpleText(LocalPlayer():GetClass().name .. " | " .. math.min(99999,LocalPlayer():GetMoney()) .. "$", "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

net.Receive("Horde_HighlightEnemies", function (len, ply)
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
	--timer.Remove("RemoveCenterText")
	--timer.Create("RemoveCenterText", 5, 1, function ()
	--	center_panel.Paint = function (w, h) end
	--end)
	center_panel.Paint = function (w, h)
		draw.RoundedBox(10, 0, 0, 300, 50, Color(40,40,40,200))
		draw.SimpleText(str, "Trebuchet24", 150, 25, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)