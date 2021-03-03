if SERVER then return end

local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() / 1.5, ScrH() / 1.5)
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

    local function create_property_editor(name, height)
        local panel = vgui.Create("DPanel", modify_tab)
        panel:DockPadding(10, 5, 10, 5)
        panel:SetSize(modify_tab:GetWide(), height)
        panel:Dock(TOP)
        panel.Paint = function ()
            surface.SetDrawColor(Color(230,230,230))
            surface.DrawRect(0, 0, modify_tab:GetWide(), height)
        end

        local label = vgui.Create("DLabel", panel)
        label:SetText(name)
        label:SetTextColor(Color(0,0,0))
        label:DockPadding(10, 10, 10, 10)
        label:Dock(LEFT)
        label:SetWide(150)

        if name == "category" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSize(200, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            editor:SetSortItems(false)
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
            -- Entiy selector
            local entity_checkboxes_panel = vgui.Create("DPanel", panel)
            entity_checkboxes_panel:Dock(TOP)
            entity_checkboxes_panel:DockPadding(0, 5, 0, 5)
            entity_checkboxes_panel:SetSize(300, height/3)
            entity_checkboxes_panel.Paint = function() end
            local entity_types = {"weapon_entity", "give_entity", "drop_entity"}
            local entity_checkboxes = {}

            local editor_panel = vgui.Create("DPanel", panel)
            editor_panel:Dock(TOP)
            editor_panel:DockPadding(0, 5, 0, 5)
            editor_panel:SetSize(300, height/3-5)
            editor_panel.Paint = function() end
            
            local weapon_editor = vgui.Create("DComboBox", editor_panel)
            weapon_editor:SetSize(200, height/3)
            weapon_editor:DockPadding(10, 10, 10, 10)
            weapon_editor:Dock(LEFT)
            for wpn, _ in pairs(list.Get("Weapon")) do
                weapon_editor:AddChoice(wpn)
            end

            local entity_editor = vgui.Create("DTextEntry", editor_panel)
            entity_editor:SetSize(200, height/3)
            entity_editor:DockPadding(10, 10, 10, 10)
            entity_editor:Dock(LEFT)
            entity_editor:SetVisible(false)

            local drop_editors = vgui.Create("DPanel", panel)
            drop_editors:Dock(TOP)
            drop_editors:DockPadding(0, 5, 0, 5)
            drop_editors:SetSize(300, height/3-5)
            drop_editors.Paint = function() end
            drop_editors:SetVisible(false)

            local hor_label = vgui.Create("DLabel", drop_editors)
            hor_label:SetText("x")
            hor_label:SetSize(10, height/3)
            hor_label:SetTextColor(Color(0,0,0))
            hor_label:DockMargin(5, 0, 5, 0)
            hor_label:Dock(LEFT)
            
            local hor_editor = vgui.Create("DTextEntry", drop_editors)
            hor_editor:SetSize(25, height/3)
            hor_editor:DockMargin(5, 0, 5, 0)
            hor_editor:Dock(LEFT)
            hor_editor:SetNumeric(true)
            hor_editor:SetValue(10)

            local ver_label = vgui.Create("DLabel", drop_editors)
            ver_label:SetText("y")
            ver_label:SetSize(10, height/3)
            ver_label:SetTextColor(Color(0,0,0))
            ver_label:DockMargin(5, 0, 5, 0)
            ver_label:Dock(LEFT)

            local ver_editor = vgui.Create("DTextEntry", drop_editors)
            ver_editor:SetSize(25, height/3)
            ver_editor:DockMargin(5, 0, 5, 0)
            ver_editor:Dock(LEFT)
            ver_editor:SetNumeric(true)
            ver_editor:SetValue(10)

            local start_pos = 0
            for _, type in pairs(entity_types) do
                local checkbox = vgui.Create("DCheckBoxLabel", entity_checkboxes_panel)
                checkbox:SetSize(100, height/3)
                checkbox:SetPos(start_pos, 15)
                checkbox:SetText(type)
                checkbox:SetTextColor(Color(0,0,0))
                checkbox:SetChecked(true)
                start_pos = start_pos + 100
                entity_checkboxes[type] = checkbox
                if type == "weapon_entity" then
                    checkbox:SetChecked(true)
                else
                    checkbox:SetChecked(false)
                end
                checkbox.OnChange = function (bVal)
                    if bVal then
                        for _, box in pairs(entity_checkboxes) do
                            box:SetChecked(false)
                        end
                        checkbox:SetChecked(true)
                        if type == "weapon_entity" then
                            weapon_editor:SetVisible(true)
                            entity_editor:SetVisible(false)
                            drop_editors:SetVisible(false)
                        else
                            weapon_editor:SetVisible(false)
                            entity_editor:SetVisible(true)
                            if type == "drop_entity" then
                                drop_editors:SetVisible(true)
                            else
                                drop_editors:SetVisible(false)
                            end
                        end
                    else
                        checkbox:SetChecked(false)
                    end
                end
            end

            return {checkboxes=entity_checkboxes, editors={weapon_editor=weapon_editor, entity_editor=entity_editor, drop_editor_x = hor_editor, drop_editor_z = ver_editor}}
        elseif name == "whitelist" then
            local editors = {}
            local start_pos = 70
            for _, class in pairs(HORDE.classes) do
                local editor = vgui.Create("DCheckBoxLabel", panel)
                editor:SetSize(75, height)
                editor:SetPos(start_pos, 15)
                editor:SetText(class.name)
                editor:SetTextColor(Color(0,0,0))
                editor:SetChecked(true)
                start_pos = start_pos + 75
                table.insert(editors, editor)
            end

            return editors
        else
            local editor = vgui.Create("DTextEntry", panel)
            editor:SetSize(200, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            return editor
        end
    end

    local class_editors = create_property_editor("class", 40 * 3)
    local category_editor = create_property_editor("category", 40)
    local name_editor = create_property_editor("name", 40)
    local price_editor = create_property_editor("price", 40)
    local weight_editor = create_property_editor("weight", 40)
    local description_editor = create_property_editor("description", 100)
    local whitelist_editors = create_property_editor("whitelist", 40)
    local ammo_price_editor = create_property_editor("ammo price", 40)
    local secondary_ammo_price_editor = create_property_editor("secondary ammo price", 40)

    if GetConVarNumber("horde_default_item_config") == 1 or (GetConVarString("horde_external_lua_config") and GetConVarString("horde_external_lua_config") ~= "") then
        local warning_label = vgui.Create("DLabel", modify_tab)
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

    local save_btn = vgui.Create("DButton", modify_tab)
    save_btn:Dock(TOP)
    save_btn:DockMargin(10,10,10,10)
    save_btn:SetTall(30)
    save_btn:SetText("Save Item")
    save_btn.DoClick = function ()
        local class = ""
        local class_checkboxes = class_editors.checkboxes
        local class_type = HORDE.ENTITY_PROPERTY_WPN
        local class_editor = class_editors.editors
        local entity_properties = {type=class_type}
         for type, checkbox in pairs(class_checkboxes) do
            if checkbox:GetChecked() then
                if type == "weapon_entity" then
                    class_type = HORDE.ENTITY_PROPERTY_WPN
                elseif type == "give_entity" then
                    class_type = HORDE.ENTITY_PROPERTY_GIVE
                elseif type == "drop_entity" then
                    class_type = HORDE.ENTITY_PROPERTY_DROP
                    entity_properties.x = class_editor.drop_editor_x:GetFloat()
                    entity_properties.z = class_editor.drop_editor_z:GetFloat()
                end
                
                entity_properties.type = class_type
                break
            end
        end

        if class_type == HORDE.ENTITY_PROPERTY_WPN then
            class = class_editor.weapon_editor:GetValue()
        else
            class = class_editor.entity_editor:GetValue()
        end

        local whitelist = {Survivor=false, Medic=false, Demolition=false, Assault=false, Heavy=false}
        for _, editor in pairs(whitelist_editors) do
            if editor:GetChecked() then
                whitelist[editor:GetText()] = true
            end
        end
        if not category_editor:GetValue() or not name_editor:GetValue() or class == "" then return end
        print(class)

        HORDE.CreateItem(
            category_editor:GetText(),
            name_editor:GetText(),
            class,
            price_editor:GetInt() or 0,
            weight_editor:GetInt() or 0,
            description_editor:GetText() or "",
            whitelist,
            ammo_price_editor:GetInt() or 0,
            secondary_ammo_price_editor:GetInt() or 0,
            entity_properties
        )
        -- Reload from disk
        net.Start("Horde_SetItemsData")
        net.WriteTable(HORDE.items)
        net.SendToServer()
        notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
    end

    local load_btn = vgui.Create("DButton", modify_tab)
    load_btn:Dock(TOP)
    load_btn:DockMargin(10,10,10,10)
    load_btn:SetTall(30)
    load_btn:SetText("OVERWRITE with Default Config")
    load_btn.DoClick = function ()
        Derma_Query('Overwrite?', 'Overwrite with Default Config',
            "Yes",
            function()
                HORDE.items = {}
                HORDE.GetDefaultItemsData()
                HORDE.GetSpecialItems()

                net.Start("Horde_SetItemsData")
                net.WriteTable(HORDE.items)
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local del_btn = vgui.Create("DButton", modify_tab)
    del_btn:Dock(TOP)
    del_btn:DockMargin(10,10,10,10)
    del_btn:SetTall(30)
    del_btn:SetText("Delete Everything")
    del_btn.DoClick = function ()
        Derma_Query('Delete Everything?', 'Delete Everything',
            "Yes",
            function()
                HORDE.items = {}
                HORDE.GetSpecialItems()

                net.Start("Horde_SetItemsData")
                net.WriteTable(HORDE.items)
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local settings_tab = vgui.Create("DPanel", self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)
    local item_list = vgui.Create("DListView", settings_tab)
    item_list:DockMargin(10, 10, 10, 10)
    item_list:Dock(FILL)

    item_list:SetMultiSelect(false)
    item_list:AddColumn("Class")
    item_list:AddColumn("Category")
    item_list:AddColumn("Name")
    item_list:AddColumn("Price")
    item_list:AddColumn("Weight")

    item_list:SetDataHeight(20)

    item_list.OnClickLine = function(parent, line, selected)
        local item = line.item
        local class_checkboxes = class_editors.checkboxes
        local class_type = HORDE.ENTITY_PROPERTY_WPN
        local class_editor = class_editors.editors
        local entity_properties = line.item.entity_properties

        local menu = DermaMenu()

        menu:AddOption("Modify", function()
            for i, checkbox in ipairs(class_checkboxes) do
                if i == entity_properties.type then
                    checkbox:SetChecked(true)
                else
                    checkbox:SetChecked(false)
                end
            end
    
            if class_type == HORDE.ENTITY_PROPERTY_WPN then
                class_editor.weapon_editor:SetVisible(true)
                class_editor.weapon_editor:SetValue(item.class)
                class_editor.entity_editor:SetVisible(false)
            else
                if class_type == HORDE.ENTITY_PROPERTY_DROP then
                    class_editor.drop_editor_x:SetValue(item.entity_properties.x)
                    class_editor.drop_editor_z:SetValue(item.entity_properties.z)
                end
                class_editor.weapon_editor:SetVisible(false)
                class_editor.entity_editor:SetValue(item.class)
                class_editor.entity_editor:SetVisible(true)
            end

            category_editor:SetValue(item.category)
            name_editor:SetValue(item.name)
            --class_editor:SetValue(item.class)
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

        menu:AddOption("Delete", function()
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