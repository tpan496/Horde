local PANEL = {}

function PANEL:Init()
    if ScrW() < 1400 then
        self:SetSize(ScrW(), ScrH())
    else
        self:SetSize(ScrW() / 1.25, ScrH() / 1.5)
    end

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
    close_btn.DoClick = function() HORDE:ToggleItemConfig() end

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
    q_btn.DoClick = function() gui.OpenURL("https://github.com/tpan496/Horde/wiki/Item-Config") end

    local modify_tab = vgui.Create("DCategoryList", self)
    modify_tab:SetBackgroundColor(HORDE.color_config_content_bg)
    modify_tab:SetSize(self:GetWide() / 2 - 150, self:GetTall() - 50 - 12)
    modify_tab:SetPos(self:GetWide() / 2, 50)

    local entity_type_cat = modify_tab:Add("Entity Type")
    local entity_type_panel = vgui.Create("DPanel", modify_tab)
    entity_type_cat:SetContents(entity_type_panel)
    entity_type_panel:SetBackgroundColor(HORDE.color_none)
    local entity_properties_cat = modify_tab:Add("Entity Properties")
    local entity_properties_panel = vgui.Create("DPanel", modify_tab)
    entity_properties_cat:SetContents(entity_properties_panel)
    entity_properties_panel:SetBackgroundColor(HORDE.color_none)

    local ammo_price_editor
    local secondary_ammo_price_editor
    local category_editor
    local description_editor
    local shop_icon_editor
    local level_editors
    local weapon_categories = HORDE.categories
    local entity_categories = HORDE.entity_categories
    local weight_editor
    local function create_property_editor(name, height, cat_panel, categories)
        local panel = vgui.Create("DPanel", cat_panel)
        panel:DockPadding(10, 5, 10, 5)
        panel:SetSize(modify_tab:GetWide(), height)
        panel:Dock(TOP)
        panel:SetBackgroundColor(HORDE.color_none)

        local label = vgui.Create("DLabel", panel)
        label:SetText(name)
        label:SetTextColor(Color(0,0,0))
        label:DockPadding(10, 10, 10, 10)
        label:Dock(LEFT)
        label:SetWide(80)

        if name == "category" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSize(200, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            editor:SetSortItems(false)
            for _, category in pairs(categories) do
                editor:AddChoice(category)
            end
            return editor
        elseif name == "class" then
            -- Entiy selector
            local entity_checkboxes_panel = vgui.Create("DPanel", panel)
            entity_checkboxes_panel:Dock(TOP)
            entity_checkboxes_panel:DockPadding(0, 5, 0, 5)
            entity_checkboxes_panel:SetSize(300, height/3)
            entity_checkboxes_panel.Paint = function() end
            local entity_types = {"weapon_entity", "give_entity", "drop_entity", "gadget_entity"}
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
            weapon_editor:AddChoice("_horde_armor_100")

            local weapon_editor_manual = vgui.Create("DTextEntry", panel)
            weapon_editor_manual:SetSize(200, 25)
            weapon_editor_manual:SetPos(90, 50)
            weapon_editor_manual:SetVisible(false)

            function weapon_editor:OnChange()
                weapon_editor_manual:SetValue(weapon_editor:GetValue())
            end

            function weapon_editor_manual:OnChange()
                weapon_editor:SetValue(weapon_editor_manual:GetValue())
            end

            local weapon_manual_toggle = vgui.Create("DCheckBoxLabel", panel)
            weapon_manual_toggle:SetText("Manual Input")
            weapon_manual_toggle:SetPos(90, 90)
            weapon_manual_toggle:SetTextColor(Color(0,0,0))

            function weapon_manual_toggle:OnChange(bVal)
                if bVal then
                    weapon_editor_manual:SetVisible(true)
                    weapon_editor:SetVisible(false)
                else
                    weapon_editor_manual:SetVisible(false)
                    weapon_editor:SetVisible(true)
                end
            end

            local entity_editor = vgui.Create("DTextEntry", editor_panel)
            entity_editor:SetSize(200, height/3)
            entity_editor:DockPadding(0, 10, 0, 10)
            entity_editor:Dock(LEFT)
            entity_editor:SetVisible(false)

            local give_editors = vgui.Create("DPanel", panel)
            give_editors:Dock(TOP)
            give_editors:DockPadding(0, 5, 0, 5)
            give_editors:SetSize(300, height/3-5)
            give_editors.Paint = function() end
            give_editors:SetVisible(false)

            local arccw_attachment_editor = vgui.Create("DCheckBoxLabel", give_editors)
            arccw_attachment_editor:SetSize(100, height/3)
            arccw_attachment_editor:DockPadding(5, 0, 5, 0)
            arccw_attachment_editor:Dock(LEFT)
            arccw_attachment_editor:SetTextColor(Color(0,0,0))
            arccw_attachment_editor:SetText("ArcCW Attachment")
            arccw_attachment_editor:SetChecked(false)

            local arccw_attachment_type_editor = vgui.Create("DComboBox", give_editors)
            arccw_attachment_type_editor:SetSize(100, height/3)
            arccw_attachment_type_editor:DockPadding(5, 0, 5, 0)
            arccw_attachment_type_editor:Dock(LEFT)
            arccw_attachment_type_editor:SetVisible(false)
            arccw_attachment_type_editor:SetTextColor(Color(0,0,0))
            arccw_attachment_type_editor:SetVisible(false)

            for _, category in pairs(HORDE.arccw_attachment_categories) do
                arccw_attachment_type_editor:AddChoice(category)
            end

            function arccw_attachment_editor:OnChange(bVal)
                if bVal == false then
                    category_editor:Clear()
                    for _, category in pairs(entity_categories) do
                        category_editor:AddChoice(category)
                    end
                    arccw_attachment_type_editor:SetVisible(false)
                else
                    category_editor:Clear()
                    for _, category in pairs(entity_categories) do
                        category_editor:AddChoice(category)
                    end
                    category_editor:AddChoice("Attachment")
                    arccw_attachment_type_editor:SetVisible(true)
                end
            end

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
            hor_editor:SetValue(50)

            local ver_label = vgui.Create("DLabel", drop_editors)
            ver_label:SetText("z")
            ver_label:SetSize(10, height/3)
            ver_label:SetTextColor(Color(0,0,0))
            ver_label:DockMargin(5, 0, 5, 0)
            ver_label:Dock(LEFT)

            local ver_editor = vgui.Create("DTextEntry", drop_editors)
            ver_editor:SetSize(25, height/3)
            ver_editor:DockMargin(5, 0, 5, 0)
            ver_editor:Dock(LEFT)
            ver_editor:SetNumeric(true)
            ver_editor:SetValue(15)

            local yaw_label = vgui.Create("DLabel", drop_editors)
            yaw_label:SetText("yaw")
            yaw_label:SetSize(25, height/3)
            yaw_label:SetTextColor(Color(0,0,0))
            yaw_label:DockMargin(5, 0, 5, 0)
            yaw_label:Dock(LEFT)

            local yaw_editor = vgui.Create("DTextEntry", drop_editors)
            yaw_editor:SetSize(25, height/3)
            yaw_editor:DockMargin(5, 0, 5, 0)
            yaw_editor:Dock(LEFT)
            yaw_editor:SetNumeric(true)
            yaw_editor:SetValue(0)

            local limit_label = vgui.Create("DLabel", drop_editors)
            limit_label:SetText("limit")
            limit_label:SetSize(25, height/3)
            limit_label:SetTextColor(Color(0,0,0))
            limit_label:DockMargin(5, 0, 5, 0)
            limit_label:Dock(LEFT)

            local limit_editor = vgui.Create("DTextEntry", drop_editors)
            limit_editor:SetSize(25, height/3)
            limit_editor:DockMargin(5, 0, 5, 0)
            limit_editor:Dock(LEFT)
            limit_editor:SetNumeric(true)
            limit_editor:SetValue(5)

            local gadget_editor = vgui.Create("DComboBox", editor_panel)
            gadget_editor:SetSize(200, height/3)
            gadget_editor:DockPadding(10, 10, 10, 10)
            gadget_editor:Dock(LEFT)
            gadget_editor:SetVisible(false)
            for gadget, _ in pairs(HORDE.gadgets) do
                gadget_editor:AddChoice(gadget)
            end

            local entity_label = vgui.Create("DLabel", panel)
            entity_label:SetText("entity")
            entity_label:SetSize(200, height / 3)
            entity_label:SetPos(10,7)
            entity_label:SetTextColor(Color(0,0,0))

            local start_pos = 0
            for _, type in pairs(entity_types) do
                local checkbox = vgui.Create("DCheckBoxLabel", entity_checkboxes_panel)
                checkbox:SetSize(100, height/3)
                checkbox:SetPos(start_pos, 15)
                if type == "weapon_entity" then
                    checkbox:SetText("weapon")
                elseif type == "give_entity" then
                    checkbox:SetText("give")
                elseif type == "drop_entity" then
                    checkbox:SetText("drop")
                elseif type == "gadget_entity" then
                    checkbox:SetText("gadget")
                end
                checkbox:SetTextColor(Color(0,0,0))
                checkbox:SetChecked(true)
                start_pos = start_pos + 70
                entity_checkboxes[type] = checkbox
                if type == "weapon_entity" then
                    checkbox:SetChecked(true)
                else
                    checkbox:SetChecked(false)
                end
                function checkbox:OnChange(bVal)
                    if bVal == true then
                        for _, box in pairs(entity_checkboxes) do
                            box:SetChecked(false)
                        end
                        checkbox:SetChecked(true)
                        if type == "weapon_entity" then
                            weapon_editor:SetVisible(true)
                            weapon_manual_toggle:SetVisible(true)
                            weapon_manual_toggle:SetChecked(false)
                            entity_editor:SetVisible(false)
                            drop_editors:SetVisible(false)
                            gadget_editor:SetVisible(false)
                            ammo_price_editor:SetVisible(true)
                            secondary_ammo_price_editor:SetVisible(true)
                            weight_editor:SetVisible(true)
                            category_editor:Clear()
                            for _, category in pairs(weapon_categories) do
                                if category == "Gadget" then goto cont end
                                category_editor:AddChoice(category)
                                ::cont::
                            end
                            drop_editors:SetVisible(false)
                            give_editors:SetVisible(false)
                            description_editor:SetVisible(true)
                            shop_icon_editor:SetVisible(true)
                        else
                            weapon_editor:SetVisible(false)
                            weapon_manual_toggle:SetVisible(false)
                            weapon_editor_manual:SetVisible(false)
                            if type == "drop_entity" then
                                drop_editors:SetVisible(true)
                                give_editors:SetVisible(false)
                                category_editor:Clear()
                                for _, category in pairs(entity_categories) do
                                    category_editor:AddChoice(category)
                                end
                                gadget_editor:SetVisible(false)
                                entity_editor:SetVisible(true)
                                description_editor:SetVisible(true)
                                shop_icon_editor:SetVisible(true)
                            elseif type == "give_entity" then
                                drop_editors:SetVisible(false)
                                give_editors:SetVisible(true)
                                arccw_attachment_editor:OnChange()
                                gadget_editor:SetVisible(false)
                                entity_editor:SetVisible(true)
                                category_editor:Clear()
                                for _, category in pairs(entity_categories) do
                                    category_editor:AddChoice(category)
                                end
                                description_editor:SetVisible(true)
                                shop_icon_editor:SetVisible(true)
                            else
                                drop_editors:SetVisible(false)
                                give_editors:SetVisible(false)
                                category_editor:Clear()
                                category_editor:AddChoice("Gadget")
                                gadget_editor:SetVisible(true)
                                entity_editor:SetVisible(false)
                                description_editor:SetVisible(false)
                                shop_icon_editor:SetVisible(false)
                            end
                            ammo_price_editor:SetVisible(false)
                            secondary_ammo_price_editor:SetVisible(false)
                            weight_editor:SetVisible(false)
                        end
                    else
                        checkbox:SetChecked(false)
                    end
                end
            end

            return {checkboxes=entity_checkboxes, editors={weapon_editor=weapon_editor, weapon_manual_toggle=weapon_manual_toggle, weapon_editor_manual=weapon_editor_manual, entity_editor=entity_editor, give_editors=give_editors, give_arccw_attachment_editor=arccw_attachment_editor, give_arccw_attachment_type_editor=arccw_attachment_type_editor, drop_editors=drop_editors, drop_editor_x = hor_editor, drop_editor_z = ver_editor, drop_editor_yaw = yaw_editor, drop_editor_limit = limit_editor, gadget_editor = gadget_editor}}
        elseif name == "whitelist" then
            local editors = {}
            local start_pos = 70
            local start_pos_2 = 70
            local i = 1
            local classes = {"Survivor", "Assault", "Heavy", "Medic", "Demolition", "Ghost", "Engineer", "Berserker", "Warden", "Cremator"}
            for _, class in pairs(classes) do
                local editor = vgui.Create("DCheckBoxLabel", panel)
                editor:SetSize(75, height / 2)
                if i <= 5 then
                    editor:SetPos(start_pos, 25)
                    start_pos = start_pos + 75
                else
                    editor:SetPos(start_pos_2, 45)
                    start_pos_2 = start_pos_2 + 75
                end
                editor:SetText(class)
                editor:SetTextColor(Color(0,0,0))
                editor:SetChecked(true)
                table.insert(editors, editor)
                i = i + 1
            end

            return editors
        elseif name == "levels" then
            local label = vgui.Create("DLabel", panel)
            label:SetText("(0-99) 5=Amateur, 10=Skilled, 15=Pro, etc.")
            label:SetTextColor(Color(0,0,0))
            label:SetPos(80,100)
            label:SetWide(200)

            local editors = {}
            local start_pos = 80
            local start_pos_2 = 80
            local i = 1
            local classes = {"Survivor", "Assault", "Heavy", "Medic", "Demolition", "Ghost", "Engineer", "Berserker", "Warden", "Cremator"}
            for _, class in pairs(classes) do
                local editor = vgui.Create("DTextEntry", panel)
                editor:SetSize(25, 25)

                local editor_label = vgui.Create("DLabel", panel)
                editor_label:SetText(class)
                editor_label:SetTextColor(Color(0,0,0))
                if i <= 5 then
                    editor:SetPos(start_pos, 25)
                    editor_label:SetPos(start_pos + 30, 25)
                    start_pos = start_pos + 75
                else
                    editor:SetPos(start_pos_2, 65)
                    editor_label:SetPos(start_pos_2 + 30, 65)
                    start_pos_2 = start_pos_2 + 75
                end

                table.insert(editors, {editor=editor, label=editor_label})
                i = i + 1
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

    local class_editors = create_property_editor("class", 40 * 3, entity_type_panel)
    category_editor = create_property_editor("category", 35, entity_type_panel, weapon_categories)
    local name_editor = create_property_editor("name", 35, entity_type_panel)
    local price_editor = create_property_editor("price", 35, entity_properties_panel)
    local skull_tokens_editor = create_property_editor("skull tokens", 35, entity_properties_panel)
    weight_editor = create_property_editor("weight", 35, entity_properties_panel)
    description_editor = create_property_editor("description", 100, entity_properties_panel)
    local whitelist_editors = create_property_editor("whitelist", 40 * 2, entity_properties_panel)
    ammo_price_editor = create_property_editor("ammo price", 35, entity_properties_panel)
    secondary_ammo_price_editor = create_property_editor("alt ammo price", 35, entity_properties_panel)
    shop_icon_editor = create_property_editor("shop icon", 35, entity_properties_panel)
    level_editors = create_property_editor("levels", 150, entity_properties_panel)

    if GetConVarNumber("horde_default_item_config") == 1 or (GetConVarString("horde_external_lua_config") and GetConVarString("horde_external_lua_config") ~= "") then
        local warning_label = vgui.Create("DLabel", modify_tab)
        warning_label:DockMargin(10, 10, 10, 10)
        warning_label:Dock(TOP)
        warning_label:SetSize(modify_tab:GetWide(), 50)
        warning_label:SetTextColor(Color(255,0,0))
        warning_label:SetText("You are using default/external config!\nYour data won't be saved!")
        warning_label:SetFont("Heading")
    end

    price_editor:SetNumeric(true)
    price_editor:SetValue("0")
    skull_tokens_editor:SetNumeric(true)
    skull_tokens_editor:SetValue("0")
    weight_editor:SetNumeric(true)
    weight_editor:SetValue("0")
    description_editor:SetMultiline(true)
    ammo_price_editor:SetNumeric(true)
    ammo_price_editor:SetValue("0")
    secondary_ammo_price_editor:SetNumeric(true)
    secondary_ammo_price_editor:SetValue("0")

    local btn_panel = vgui.Create("DPanel", self)
    btn_panel:SetPos(self:GetWide() - 150, 50)
    btn_panel:SetSize(150, self:GetTall() - 58)
    btn_panel.Paint = function ()
        surface.SetDrawColor(HORDE.color_none)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    end

    local save_btn = vgui.Create("DButton", btn_panel)
    save_btn:Dock(TOP)
    save_btn:DockMargin(10,5,10,5)
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
                    entity_properties.is_arccw_attachment = class_editor.give_arccw_attachment_editor:GetChecked()
                    if entity_properties.is_arccw_attachment == true then
                        entity_properties.arccw_attachment_type = class_editor.give_arccw_attachment_type_editor:GetValue()
                    end
                elseif type == "drop_entity" then
                    class_type = HORDE.ENTITY_PROPERTY_DROP
                    entity_properties.x = class_editor.drop_editor_x:GetFloat()
                    entity_properties.z = class_editor.drop_editor_z:GetFloat()
                    entity_properties.yaw = class_editor.drop_editor_yaw:GetFloat()
                    entity_properties.limit = class_editor.drop_editor_limit:GetInt()
                elseif type == "gadget_entity" then
                    class_type = HORDE.ENTITY_PROPERTY_GADGET
                end
                
                entity_properties.type = class_type
                break
            end
        end

        if class_type == HORDE.ENTITY_PROPERTY_WPN then
            class = class_editor.weapon_editor:GetValue()
        elseif class_type == HORDE.ENTITY_PROPERTY_GADGET then
            class = class_editor.gadget_editor:GetValue()
        else
            class = class_editor.entity_editor:GetValue()
        end

        local whitelist = {Survivor=false, Medic=false, Demolition=false, Assault=false, Heavy=false}
        for _, editor in pairs(whitelist_editors) do
            if editor:GetChecked() then
                whitelist[editor:GetText()] = true
            end
        end

        local shop_icon = shop_icon_editor:GetValue()

        local levels = {}
        for _, editor in pairs(level_editors) do
            if editor.editor:GetInt() and editor.editor:GetInt() > 0 then
                levels[editor.label:GetText()] = editor.editor:GetInt()
            end
        end

        if not category_editor:GetValue() or not name_editor:GetValue() or class == "" then return end

        HORDE:CreateItem(
            category_editor:GetText(),
            name_editor:GetText(),
            class,
            price_editor:GetInt() or 0,
            weight_editor:GetInt() or 0,
            description_editor:GetText() or "",
            whitelist,
            ammo_price_editor:GetInt() or 0,
            secondary_ammo_price_editor:GetInt() or 0,
            entity_properties,
            shop_icon,
            levels,
            skull_tokens_editor:GetInt() or 0
        )
        -- Reload from disk
        local tab = util.TableToJSON(HORDE.items)
        local str = util.Compress(tab)
        net.Start("Horde_SetItemsData")
            net.WriteUInt(string.len(str), 32)
            net.WriteData(str, string.len(str))
        net.SendToServer()
        notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
    end

    local load_btn = vgui.Create("DButton", btn_panel)
    load_btn:Dock(BOTTOM)
    load_btn:DockMargin(10,5,10,5)
    load_btn:SetTall(30)
    load_btn:SetText("OVERWRITE with Default")
    load_btn.DoClick = function ()
        Derma_Query("Overwrite?", "Overwrite with Default",
            "Yes",
            function()
                HORDE.items = {}
                HORDE:GetDefaultItemsData()

                local tab = util.TableToJSON(HORDE.items)
                local str = util.Compress(tab)
                net.Start("Horde_SetItemsData")
                    net.WriteUInt(string.len(str), 32)
                    net.WriteData(str, string.len(str))
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local gadget_btn = vgui.Create("DButton", btn_panel)
    gadget_btn:Dock(BOTTOM)
    gadget_btn:DockMargin(10,5,10,5)
    gadget_btn:SetTall(30)
    gadget_btn:SetText("Add Default Gadgets")
    gadget_btn.DoClick = function ()
        Derma_Query("Add Default Gadgets?", "Default Gadgets",
            "Yes",
            function()
                HORDE:GetDefaultGadgets()

                local tab = util.TableToJSON(HORDE.items)
                local str = util.Compress(tab)
                net.Start("Horde_SetItemsData")
                    net.WriteUInt(string.len(str), 32)
                    net.WriteData(str, string.len(str))
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local del_btn = vgui.Create("DButton", btn_panel)
    del_btn:Dock(BOTTOM)
    del_btn:DockMargin(10,5,10,5)
    del_btn:SetTall(30)
    del_btn:SetText("Delete Everything")
    del_btn.DoClick = function ()
        Derma_Query("Delete Everything?", "Delete Everything",
            "Yes",
            function()
                HORDE.items = {}

                local tab = util.TableToJSON(HORDE.items)
                local str = util.Compress(tab)
                net.Start("Horde_SetItemsData")
                    net.WriteUInt(string.len(str), 32)
                    net.WriteData(str, string.len(str))
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local settings_tab = vgui.Create("DPanel", self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40 - 3)
    settings_tab:SetBackgroundColor(HORDE.color_none)
    
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
        if item.entity_properties then class_type = item.entity_properties.type end
        local class_editor = class_editors.editors

        local menu = DermaMenu()

        menu:AddOption("Modify", function()
            for type, checkbox in pairs(class_checkboxes) do
                if class_type == HORDE.ENTITY_PROPERTY_WPN and type == "weapon_entity" then
                    checkbox:SetChecked(true)
                    class_editor.drop_editors:SetVisible(false)
                    class_editor.give_editors:SetVisible(false)
                    class_editor.weapon_manual_toggle:SetVisible(true)
                    class_editor.weapon_editor_manual:SetVisible(false)
                    class_editor.weapon_manual_toggle:SetChecked(false)
                    class_editor.gadget_editor:SetVisible(false)
                elseif class_type == HORDE.ENTITY_PROPERTY_GIVE and type == "give_entity" then
                    checkbox:SetChecked(true)
                    class_editor.drop_editors:SetVisible(false)
                    class_editor.give_editors:SetVisible(true)
                    class_editor.weapon_manual_toggle:SetVisible(false)
                    class_editor.weapon_editor_manual:SetVisible(false)
                    class_editor.gadget_editor:SetVisible(false)
                elseif class_type == HORDE.ENTITY_PROPERTY_DROP and type == "drop_entity" then
                    checkbox:SetChecked(true)
                    class_editor.drop_editors:SetVisible(true)
                    class_editor.give_editors:SetVisible(false)
                    class_editor.weapon_manual_toggle:SetVisible(false)
                    class_editor.weapon_editor_manual:SetVisible(false)
                    class_editor.gadget_editor:SetVisible(false)
                elseif class_type == HORDE.ENTITY_PROPERTY_GADGET and type == "gadget_entity" then
                    checkbox:SetChecked(true)
                    class_editor.drop_editors:SetVisible(false)
                    class_editor.give_editors:SetVisible(false)
                    class_editor.weapon_manual_toggle:SetVisible(false)
                    class_editor.weapon_editor_manual:SetVisible(false)
                    class_editor.gadget_editor:SetVisible(true)
                else
                    checkbox:SetChecked(false)
                end
            end
    
            if class_type == HORDE.ENTITY_PROPERTY_WPN then
                class_editor.weapon_editor:SetVisible(true)
                class_editor.weapon_editor:SetValue(item.class)
                class_editor.weapon_editor_manual:SetValue(item.class)
                class_editor.entity_editor:SetVisible(false)
                class_editor.gadget_editor:SetVisible(false)
                category_editor:Clear()
                for _, category in pairs(weapon_categories) do
                    if category == "Gadget" then goto cont end
                    category_editor:AddChoice(category)
                    ::cont::
                end
                ammo_price_editor:SetVisible(true)
                secondary_ammo_price_editor:SetVisible(true)
                description_editor:SetVisible(true)
                shop_icon_editor:SetVisible(true)
            else
                ammo_price_editor:SetVisible(false)
                secondary_ammo_price_editor:SetVisible(false)
                description_editor:SetVisible(true)
                shop_icon_editor:SetVisible(true)
                if class_type == HORDE.ENTITY_PROPERTY_DROP then
                    class_editor.drop_editor_x:SetValue(item.entity_properties.x)
                    class_editor.drop_editor_z:SetValue(item.entity_properties.z)
                    class_editor.drop_editor_yaw:SetValue(item.entity_properties.yaw)
                    class_editor.drop_editor_limit:SetValue(item.entity_properties.limit)
                    class_editor.entity_editor:SetVisible(true)
                    category_editor:Clear()
                    for _, category in pairs(entity_categories) do
                        category_editor:AddChoice(category)
                    end
                elseif class_type == HORDE.ENTITY_PROPERTY_GIVE then
                    if item.entity_properties.is_arccw_attachment and item.entity_properties.is_arccw_attachment == true then
                        class_editor.give_arccw_attachment_editor:SetChecked(true)
                        class_editor.give_arccw_attachment_type_editor:SetValue(item.entity_properties.arccw_attachment_type)
                        class_editor.give_arccw_attachment_type_editor:SetVisible(true)
                    else
                        class_editor.give_arccw_attachment_editor:SetChecked(false)
                    end
                    class_editor.entity_editor:SetVisible(true)
                    category_editor:Clear()
                    for _, category in pairs(entity_categories) do
                        category_editor:AddChoice(category)
                    end
                elseif class_type == HORDE.ENTITY_PROPERTY_GADGET then
                    class_editor.gadget_editor:SetVisible(true)
                    class_editor.entity_editor:SetVisible(false)
                    class_editor.gadget_editor:SetValue(item.class)
                    category_editor:Clear()
                    category_editor:AddChoice("Gadget")
                    description_editor:SetVisible(false)
                    shop_icon_editor:SetVisible(false)
                end
                class_editor.weapon_editor:SetVisible(false)
                class_editor.entity_editor:SetValue(item.class)
            end

            category_editor:SetValue(item.category)
            name_editor:SetValue(item.name)
            price_editor:SetValue(item.price)
            skull_tokens_editor:SetValue(item.skull_tokens or 0)
            weight_editor:SetValue(item.weight)
            description_editor:SetValue(item.description)
            for _, editor in pairs(whitelist_editors) do
                if item.whitelist then
                    if item.whitelist[editor:GetText()] then
                        editor:SetChecked(true)
                    else
                        editor:SetChecked(false)
                    end
                else
                    editor:SetChecked(true)
                end
            end
            ammo_price_editor:SetValue(item.ammo_price and item.ammo_price or HORDE.default_ammo_price)
            secondary_ammo_price_editor:SetValue(item.secondary_ammo_price and item.secondary_ammo_price or -1)
            shop_icon_editor:SetValue(item.shop_icon or "")

            for _, editor in pairs(level_editors) do
                if item.levels then
                    if item.levels[editor.label:GetText()] then
                        editor.editor:SetValue(item.levels[editor.label:GetText()])
                    else
                        editor.editor:SetValue("")
                    end
                else
                    editor.editor:SetValue("")
                end
            end
        end)

        menu:AddOption("Delete", function()
            HORDE.items[item.class] = nil

            local tab = util.TableToJSON(HORDE.items)
            local str = util.Compress(tab)
            net.Start("Horde_SetItemsData")
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
            line:SetValue(2, translate.Get("Shop_" .. item.category) or item.category)
            line:SetValue(3, item.name)
            line:SetValue(4, item.price)
            line:SetValue(5, item.weight)
        else
            self.item_list:RemoveLine(i)
        end
    end
end

function PANEL:Paint(w, h)
    -- Entire Panel
    draw.RoundedBox(10, 0, 0, w, h, HORDE.color_config_bg)

    -- Background
    draw.RoundedBox(10, 0, 0, w, 40, HORDE.color_config_bar)

    draw.SimpleText("Horde Item Configuration", "Trebuchet24", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeItemConfig", PANEL, "EditablePanel")