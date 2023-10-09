local PANEL = {}

function PANEL:Init()
    local scale = 1.5
    if ScrW() <= 1300 then
        scale = 1.25
    end
    self:SetSize(ScrW() / scale, ScrH() / 1.5)
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))
    self:MakePopup()

    local close_btn = vgui.Create("DButton", self)
    local close_btn_color = HORDE.color_config_btn
    close_btn:SetFont("marlett")
    close_btn:SetText("r")
    close_btn.Paint = function() draw.RoundedBox(10, 0, 0, 40, 32, close_btn_color) end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(40, 32)
    close_btn:SetPos(self:GetWide() - 45, 4)
    close_btn.OnCursorEntered = function ()
        close_btn_color = HORDE.color_crimson
    end
    close_btn.OnCursorExited = function ()
        close_btn_color = HORDE.color_config_btn
    end
    close_btn.DoClick = function() HORDE:ToggleMapConfig() end

    local q_btn = vgui.Create("DButton", self)
    local q_btn_color = HORDE.color_config_btn
    q_btn:SetFont("Trebuchet24")
    q_btn:SetText("?")
    q_btn.Paint = function() draw.RoundedBox(10, 0, 0, 40, 32, q_btn_color) end
    q_btn:SetColor(Color(255, 255, 255))
    q_btn:SetSize(40, 32)
    q_btn:SetPos(self:GetWide() - 45 - 45, 4)
    q_btn.OnCursorEntered = function ()
        q_btn_color = HORDE.color_crimson
    end
    q_btn.OnCursorExited = function ()
        q_btn_color = HORDE.color_config_btn
    end
    q_btn.DoClick = function() gui.OpenURL("https://github.com/tpan496/Horde/wiki/Map-Config") end

    local whitelist_tab = vgui.Create("DPanel", self)
    whitelist_tab:SetSize(self:GetWide() / 4, self:GetTall() - 55 - 10)
    whitelist_tab:SetPos(self:GetWide() / 4, 50)
    whitelist_tab:SetBackgroundColor(HORDE.color_config_content_bg)

    local whitelist_label = vgui.Create("DLabel", whitelist_tab)
    whitelist_label:Dock(TOP)
    whitelist_label:DockMargin(10,10,10,10)
    whitelist_label:SetTextColor(color_black)
    whitelist_label:SetFont("Trebuchet18")
    whitelist_label:SetText("Whitelist Settings")

    local whitelist_editor = vgui.Create("DTextEntry", whitelist_tab)
    whitelist_editor:Dock(TOP)
    whitelist_editor:DockMargin(10,10,10,10)
    whitelist_editor:SetTall(30)
    whitelist_editor:SetTextColor(color_black)

    local whitelist_eg_label = vgui.Create("DLabel", whitelist_tab)
    whitelist_eg_label:Dock(TOP)
    whitelist_eg_label:DockMargin(10,0,10,0)
    whitelist_eg_label:SetTall(30)
    whitelist_eg_label:SetText("e.g. zs_heat")
    whitelist_eg_label:SetTextColor(color_black)

    local whitelist_btn = vgui.Create("DButton", whitelist_tab)
    whitelist_btn:Dock(TOP)
    whitelist_btn:DockMargin(10,5,10,5)
    whitelist_btn:SetTall(30)
    whitelist_btn:SetText("<-- Add to whitelist")
    whitelist_btn.DoClick = function ()
        HORDE.map_whitelist[whitelist_editor:GetText()] = whitelist_editor:GetText()
        net.Start("Horde_SetMapsWhitelistData")
            if HORDE.map_whitelist then net.WriteTable(HORDE.map_whitelist) else net.WriteTable({}) return end
        net.SendToServer()
        HORDE:PlayNotification("Your changes have been saved.")
    end

    local whitelist_del_btn = vgui.Create("DButton", whitelist_tab)
    whitelist_del_btn:Dock(BOTTOM)
    whitelist_del_btn:DockMargin(10,5,10,10)
    whitelist_del_btn:SetTall(30)
    whitelist_del_btn:SetText("Delete Whitelist")
    whitelist_del_btn.DoClick = function ()
        Derma_Query("Delete Everything?", "Delete Whitelist",
            "Yes",
            function()
                HORDE.map_whitelist = {}

                net.Start("Horde_SetMapsWhitelistData")
                    net.WriteTable({})
                net.SendToServer()
                HORDE:PlayNotification("Your changes have been saved.")
            end,
            "No", function() end
        )
    end

    local whitelist_list_tab = vgui.Create("DPanel", self)
    whitelist_list_tab:SetPos(0, 40)
    whitelist_list_tab:SetSize(self:GetWide() / 4, self:GetTall() - 40 - 3)
    whitelist_list_tab:SetBackgroundColor(HORDE.color_none)
    
    local whitelist_list = vgui.Create("DListView", whitelist_list_tab)
    whitelist_list:DockMargin(10, 10, 10, 10)
    whitelist_list:Dock(FILL)

    whitelist_list:SetMultiSelect(false)
    whitelist_list:AddColumn("Map")

    whitelist_list:SetDataHeight(20)

    whitelist_list.OnClickLine = function(parent, line, selected)
        local menu = DermaMenu()
        local map = line.map

        menu:AddOption("Modify", function()
            whitelist_editor:SetText(map)
        end)

        menu:AddOption("Delete", function()
            HORDE.map_whitelist[map] = nil
			net.Start("Horde_SetMapsWhitelistData")
                if HORDE.map_whitelist then net.WriteTable(HORDE.map_whitelist) else net.WriteTable({}) return end
            net.SendToServer()
			HORDE:PlayNotification("Your changes have been saved.")
        end)

        menu:AddSpacer()
        menu:Open()
    end

    self.whitelist_list = whitelist_list

    local blacklist_tab = vgui.Create("DPanel", self)
    blacklist_tab:SetSize(self:GetWide() / 4, self:GetTall() - 55 - 10)
    blacklist_tab:SetPos(self:GetWide() * 3 / 4, 50)
    blacklist_tab:SetBackgroundColor(HORDE.color_config_content_bg)

    local blacklist_label = vgui.Create("DLabel", blacklist_tab)
    blacklist_label:Dock(TOP)
    blacklist_label:DockMargin(10,5,10,5)
    blacklist_label:SetTall(30)
    blacklist_label:SetTextColor(color_black)
    blacklist_label:SetFont("Trebuchet18")
    blacklist_label:SetText("Blacklist Settings")

    local blacklist_editor = vgui.Create("DTextEntry", blacklist_tab)
    blacklist_editor:Dock(TOP)
    blacklist_editor:DockMargin(10,10,10,10)
    blacklist_editor:SetTall(30)
    blacklist_editor:SetTextColor(color_black)
    
    local blacklist_eg_label = vgui.Create("DLabel", blacklist_tab)
    blacklist_eg_label:Dock(TOP)
    blacklist_eg_label:DockMargin(10,0,10,0)
    blacklist_eg_label:SetTall(30)
    blacklist_eg_label:SetText("e.g. gm_construct")
    blacklist_eg_label:SetTextColor(color_black)

    local blacklist_btn = vgui.Create("DButton", blacklist_tab)
    blacklist_btn:Dock(TOP)
    blacklist_btn:DockMargin(10,5,10,5)
    blacklist_btn:SetTall(30)
    blacklist_btn:SetText("<-- Add to blacklist")
    blacklist_btn.DoClick = function ()
        net.Start("Horde_SetMapsBlacklistData")
        HORDE.map_blacklist[blacklist_editor:GetText()] = blacklist_editor:GetText()
            if HORDE.map_blacklist then net.WriteTable(HORDE.map_blacklist) else net.WriteTable({}) return end
        net.SendToServer()
        HORDE:PlayNotification("Your changes have been saved.")
    end

    local blacklist_del_btn = vgui.Create("DButton", blacklist_tab)
    blacklist_del_btn:Dock(BOTTOM)
    blacklist_del_btn:DockMargin(10,5,10,10)
    blacklist_del_btn:SetTall(30)
    blacklist_del_btn:SetText("Delete Blacklist")
    blacklist_del_btn.DoClick = function ()
        Derma_Query("Delete Everything?", "Delete Blacklist",
            "Yes",
            function()
                HORDE.map_blacklist = {}

                net.Start("Horde_SetMapsBlacklistData")
                    net.WriteTable({})
                net.SendToServer()
                HORDE:PlayNotification("Your changes have been saved.")
            end,
            "No", function() end
        )
    end

    local blacklist_list_tab = vgui.Create("DPanel", self)
    blacklist_list_tab:SetPos(self:GetWide() / 2, 40)
    blacklist_list_tab:SetSize(self:GetWide() / 4, self:GetTall() - 40 - 3)
    blacklist_list_tab:SetBackgroundColor(HORDE.color_none)
    
    local blacklist_list = vgui.Create("DListView", blacklist_list_tab)
    blacklist_list:DockMargin(10, 10, 10, 10)
    blacklist_list:Dock(FILL)

    blacklist_list:SetMultiSelect(false)
    blacklist_list:AddColumn("Map")

    blacklist_list:SetDataHeight(20)

    blacklist_list.OnClickLine = function(parent, line, selected)
        local menu = DermaMenu()
        local map = line.map

        menu:AddOption("Modify", function()
            blacklist_editor:SetText(map)
        end)

        menu:AddOption("Delete", function()
            HORDE.map_blacklist[map] = nil
			net.Start("Horde_SetMapsBlacklistData")
                if HORDE.map_blacklist then net.WriteTable(HORDE.map_blacklist) else net.WriteTable({}) return end
            net.SendToServer()
			HORDE:PlayNotification("Your changes have been saved.")
        end)

        menu:AddSpacer()
        menu:Open()
    end

    self.blacklist_list = blacklist_list
end

function PANEL:Think()
    local whitelist_lines = self.whitelist_list:GetLines()
    if HORDE.map_whitelist then
        for _, map in pairs(HORDE.map_whitelist) do
            local found = false
            for _, line in pairs(whitelist_lines) do
                if line.map == map then
                    found = true
                end
            end
            if not found then
                self.whitelist_list:AddLine(map).map = map
            end
        end

        for i, line in pairs(whitelist_lines) do
            if table.HasValue(HORDE.map_whitelist, line.map) then
                line:SetValue(1, line.map)
            else
                self.whitelist_list:RemoveLine(i)
            end
        end
    end
    local blacklist_lines = self.blacklist_list:GetLines()
    if HORDE.map_blacklist then
        for _, map in pairs(HORDE.map_blacklist) do
            local found = false
            for _, line in pairs(blacklist_lines) do
                if line.map == map then
                    found = true
                end
            end
            if not found then
                self.blacklist_list:AddLine(map).map = map
            end
        end

        for i, line in pairs(blacklist_lines) do
            if table.HasValue(HORDE.map_blacklist, line.map) then
                line:SetValue(1, line.map)
            else
                self.blacklist_list:RemoveLine(i)
            end
        end
    end
end

function PANEL:Paint(w, h)
    -- Entire Panel
    draw.RoundedBox(10, 0, 0, w, h, HORDE.color_config_bg)

    -- Background
    draw.RoundedBox(10, 0, 0, w, 40, HORDE.color_config_bar)

    draw.SimpleText("Horde Map Configuration", "Trebuchet24", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeMapConfig", PANEL, "EditablePanel")