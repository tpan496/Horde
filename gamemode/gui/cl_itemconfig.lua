if SERVER then return end

local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() / 1.5, ScrH() / 1.5)
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))
    self:MakePopup()

    local close_btn = vgui.Create('DButton', self)
    close_btn:SetFont('marlett')
    close_btn:SetText('r')
    close_btn.Paint = function() end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(32, 32)
    close_btn:SetPos(self:GetWide() - 40, 8)
    close_btn.DoClick = function() HORDE:ToggleItemConfig() end

    local modify_tab = vgui.Create('DPanel', self)
    modify_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)
    modify_tab:SetPos(self:GetWide() / 2, 40)

    local function create_property_editor(name, height)
        local panel = vgui.Create('DPanel', modify_tab)
        panel:DockPadding(10, 10, 10, 10)
        panel:SetSize(modify_tab:GetWide(), height)
        panel:Dock(TOP)

        local label = vgui.Create('DLabel', panel)
        label:SetText(name)
        label:SetTextColor(Color(0,0,0))
        label:DockPadding(10, 10, 10, 10)
        label:Dock(LEFT)
        label:SetWide(150)
        
        if name == "category" then
            local editor = vgui.Create('DComboBox', panel)
            editor:SetSize(200, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            editor:AddChoice("Melee")
            editor:AddChoice("Pistol")
            editor:AddChoice("SMG")
            editor:AddChoice("Shotgun")
            editor:AddChoice("Rifle")
            editor:AddChoice("MG")
            editor:AddChoice("Explosive")
            editor:AddChoice("Special")
            editor:AddChoice("Equipment")
            return editor
        elseif name == "class" then
            local editor = vgui.Create('DComboBox', panel)
            editor:SetSize(200, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            for wpn, _ in pairs(list.Get("Weapon")) do
                editor:AddChoice(wpn)
            end
            return editor
        elseif name == "whitelist" then
            local editors = {}
            for _, class in pairs(HORDE.classes) do
                local editor = vgui.Create('DCheckBoxLabel', panel)
                editor:SetSize(100, height)
                editor:Dock(LEFT)
                editor:SetText(class.name)
                editor:SetTextColor(Color(0,0,0))
                editor:SetChecked(true)
                table.insert(editors, editor)
            end
            
            return editors
        else
            local editor = vgui.Create('DTextEntry', panel)
            editor:SetSize(200, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            return editor
        end
    end

    local class_editor = create_property_editor("class", 45)
    local category_editor = create_property_editor("category", 45)
    local name_editor = create_property_editor("name", 45)
    local price_editor = create_property_editor("price", 45)
    local weight_editor = create_property_editor("weight", 45)
    local description_editor = create_property_editor("description", 100)
    local whitelist_editors = create_property_editor("whitelist", 45)
    local ammo_price_editor = create_property_editor("ammo price", 45)
    local secondary_ammo_price_editor = create_property_editor("secondary ammo price", 45)

    if GetConVarNumber("horde_default_item_config") == 1 or (GetConVarString("horde_external_lua_config") and GetConVarString("horde_external_lua_config") ~= "") then
        local warning_label = vgui.Create('DLabel', modify_tab)
        warning_label:DockPadding(10, 10, 10, 10)
        warning_label:Dock(TOP)
        warning_label:SetSize(modify_tab:GetWide(), 25)
        warning_label:SetTextColor(Color(255,0,0))
        warning_label:SetText("You are using default/external config! Your data won't be saved!")
    end

    price_editor:SetNumeric(true)
    price_editor:SetValue("0")
    weight_editor:SetNumeric(true)
    weight_editor:SetValue("0")
    description_editor:SetMultiline(true)
    ammo_price_editor:SetNumeric(true)
    ammo_price_editor:SetValue("0")
    secondary_ammo_price_editor:SetNumeric(true)
    secondary_ammo_price_editor:SetValue("0")

    local save_btn = vgui.Create('DButton', modify_tab)
    save_btn:Dock(BOTTOM)
    save_btn:SetText("Save Item")
    save_btn.DoClick = function ()
        local whitelist = {Survivor=false, Medic=false, Demolition=false, Assault=false, Heavy=false}
        for _, editor in pairs(whitelist_editors) do
            if editor:GetChecked() then
                whitelist[editor:GetText()] = true
            end
        end
        if not category_editor:GetValue() or not name_editor:GetValue() or not class_editor:GetValue() then return end

        HORDE.CreateItem(
            category_editor:GetText(),
            name_editor:GetText(),
            class_editor:GetText(),
            price_editor:GetInt() or 0,
            weight_editor:GetInt() or 0,
            description_editor:GetText() or "",
            whitelist,
            ammo_price_editor:GetInt() or 0,
            secondary_ammo_price_editor:GetInt() or 0
        )
        -- Reload from disk
        net.Start("Horde_SetItemsData")
        net.WriteTable(HORDE.items)
        net.SendToServer()
        notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
    end

    local load_btn = vgui.Create('DButton', modify_tab)
    load_btn:Dock(TOP)
    load_btn:SetText("OVERWRITE with Default Config")
    load_btn.DoClick = function ()
        Derma_Query('Overwrite?', 'Overwrite with Default Config',
            'Yes',
            function()
                HORDE.items = {}
                HORDE.GetDefaultItemsData()
                HORDE.GetSpecialItems()

                net.Start("Horde_SetItemsData")
                net.WriteTable(HORDE.items)
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            'No', function() end
        )
    end

    local del_btn = vgui.Create('DButton', modify_tab)
    del_btn:Dock(TOP)
    del_btn:SetText("Delete Everything")
    del_btn.DoClick = function ()
        Derma_Query('Delete Everything?', 'Delete Everything',
            'Yes',
            function()
                HORDE.items = {}
                HORDE.GetSpecialItems()

                net.Start("Horde_SetItemsData")
                net.WriteTable(HORDE.items)
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            'No', function() end
        )
    end

    local settings_tab = vgui.Create('DPanel', self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)
    local item_list = vgui.Create("DListView", settings_tab)
    item_list:DockMargin(10, 10, 10, 10)
    item_list:Dock(FILL)

    item_list:SetMultiSelect(false)
    item_list:AddColumn('Class')
    item_list:AddColumn('Category')
    item_list:AddColumn('Name')
    item_list:AddColumn('Price')
    item_list:AddColumn('Weight')
    item_list:AddColumn('Description')

    item_list.OnClickLine = function(parent, line, selected)
        local item = line.item
        
        local menu = DermaMenu()
        
        menu:AddOption('Modify', function()
            category_editor:SetValue(item.category)
            name_editor:SetValue(item.name)
            class_editor:SetValue(item.class)
            price_editor:SetValue(item.price)
            weight_editor:SetValue(item.weight)
            description_editor:SetValue(item.description)
            for _, editor in pairs(whitelist_editors) do
                if item.whitelist then
                    if item.whitelist[editor:GetText()] then
                        editor:SetChecked(true)
                    else
                        editor:SetChecked(false)
                    end
                end
            end
            ammo_price_editor:SetValue(item.ammo_price and item.ammo_price or HORDE.default_ammo_price)
            secondary_ammo_price_editor:SetValue(item.secondary_ammo_price and item.secondary_ammo_price or -1)
        end)
        
        menu:AddOption('Delete', function()
            HORDE.items[item.class] = nil

			net.Start("Horde_SetItemsData")
            net.WriteTable(HORDE.items)
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
            self.item_list:AddLine(item.category, item.name, item.class, item.price, item.weight, item.description).item = item
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
            line:SetValue(6, item.description)
        else
            self.item_list:RemoveLine(i)
        end
    end
end

function PANEL:Paint(w, h)
    -- Derma_DrawBackgroundBlur(self)

    -- Entire Panel
    surface.SetDrawColor(Color(40, 40, 40, 255))
    surface.DrawRect(0, 0, w, h)

    -- Background
    surface.SetDrawColor(Color(40, 40, 40, 255))
    surface.DrawRect(0, 0, w, 48)

    draw.SimpleText("Item Config (Some settings require restarting current game to take effect)", 'Heading', 10, 24, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register('HordeItemConfig', PANEL, 'EditablePanel')