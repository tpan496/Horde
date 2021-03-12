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
    close_btn:SetFont("marlett")
    close_btn:SetText("r")
    close_btn.Paint = function() end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(32, 32)
    close_btn:SetPos(self:GetWide() - 40, 8)
    close_btn.DoClick = function() HORDE:ToggleItemConfig() end

    local modify_tab = vgui.Create("DScrollPanel", self)
    modify_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)
    modify_tab:SetPos(self:GetWide() / 2, 40)

    local save_btn = vgui.Create("DButton", modify_tab)
    save_btn:Dock(TOP)
    save_btn:DockMargin(10,10,10,10)
    save_btn:SetTall(30)
    save_btn:SetText("Save Item")
    save_btn.DoClick = function ()
        -- Reload from disk
        net.Start("Horde_SetItemsData")
        local tab = util.TableToJSON(HORDE.items)
        local str = util.Compress(tab)
        net.WriteUInt(string.len(str), 32)
        net.WriteData(str, string.len(str))
        net.SendToServer()
        notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
    end

    local settings_tab = vgui.Create("DPanel", self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)
    local item_list = vgui.Create("DListView", settings_tab)
    item_list:DockMargin(10, 10, 10, 10)
    item_list:Dock(FILL)

    item_list:SetMultiSelect(false)
    item_list:AddColumn("Map")

    item_list:SetDataHeight(20)

    item_list.OnClickLine = function(parent, line, selected)
        local item = line.item

        local menu = DermaMenu()

        menu:AddOption("Modify", function()
            
        end)

        menu:AddOption("Delete", function()
            

			net.Start("Horde_SetItemsData")
            local tab = util.TableToJSON(HORDE.items)
            local str = util.Compress(tab)
            net.WriteUInt(string.len(str), 32)
            net.WriteData(str, string.len(str))
        	net.SendToServer()
			notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
        end)

        menu:AddSpacer()

        menu:Open()
    end

    self.item_list = item_list
end

function PANEL:Think()
    local lines = self.item_list:GetLines()

    for _, item in pairs(HORDE.items) do
        local found = false
        for _, line in pairs(lines) do
            if line.item == item then
                found = true
            end
        end
        if not found then
            self.item_list:AddLine(item.category, item.name, item.class, item.price, item.weight).item = item
        end
    end

    for i, line in pairs(lines) do
        if table.HasValue(HORDE.items, line.item) then
            local item = line.item

            line:SetValue(1, item.class)
            line:SetValue(2, item.category)
            line:SetValue(3, item.name)
            line:SetValue(4, item.price)
            line:SetValue(5, item.weight)
        else
            self.item_list:RemoveLine(i)
        end
    end
end

function PANEL:Paint(w, h)
    -- Derma_DrawBackgroundBlur(self)

    -- Entire Panel
    surface.SetDrawColor(Color(230, 230, 230, 255))
    surface.DrawRect(0, 0, w, h)

    -- Background
    surface.SetDrawColor(Color(40, 40, 40, 255))
    surface.DrawRect(0, 0, w, 48)

    draw.SimpleText("Item Config (Some settings require restarting current game to take effect)", "Heading", 10, 24, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeItemConfig", PANEL, "EditablePanel")