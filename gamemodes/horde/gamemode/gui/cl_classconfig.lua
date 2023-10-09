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
    close_btn.DoClick = function() HORDE:ToggleClassConfig() end

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
    q_btn.DoClick = function() gui.OpenURL("https://github.com/tpan496/Horde/wiki/Class-Config") end

    local modify_tab = vgui.Create("DCategoryList", self)
    modify_tab:SetBackgroundColor(HORDE.color_config_content_bg)
    modify_tab:SetSize(self:GetWide() / 2 - 150, self:GetTall() - 50 - 12)
    modify_tab:SetPos(self:GetWide() / 2, 50)

    local basic_cat = modify_tab:Add("Basic")
    local basic_panel = vgui.Create("DPanel", modify_tab)
    basic_cat:SetContents(basic_panel)
    basic_panel:SetBackgroundColor(HORDE.color_none)

    local perks_cat = modify_tab:Add("Perks")
    local perks_panel = vgui.Create("DPanel", modify_tab)
    perks_cat:SetContents(perks_panel)
    perks_panel:SetBackgroundColor(HORDE.color_none)

    local function create_property_editor(name, height, cat_panel)
        local panel = vgui.Create("DPanel", cat_panel)
        panel:DockPadding(10, 10, 10, 10)
        panel:SetSize(modify_tab:GetWide(), height)
        panel:Dock(TOP)
        panel:SetBackgroundColor(HORDE.color_none)

        local label = vgui.Create("DLabel", panel)
        label:SetText(name)
        label:SetTextColor(Color(0,0,0))
        label:DockPadding(10, 10, 10, 10)
        label:SetWide(100)
        label:Dock(LEFT)
        if name == "class name" then
            local editor = vgui.Create("DLabel", panel)
            editor:SetSize(175, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            editor:SetTextColor(Color(0,0,0))
            return editor
        elseif name == "Tier 0" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSize(175, 30)
            editor:SetPos(110, 10)
            for class,perk in pairs(HORDE.perks) do
                editor:AddChoice(class)
            end
            return editor
        elseif name == "Tier 1" or name == "Tier 2" or name == "Tier 3" or name == "Tier 4" then
            local editor_title = vgui.Create("DTextEntry", panel)
            editor_title:SetSize(175, 30)
            editor_title:SetPos(110, 15)

            local label_left = vgui.Create("DLabel", panel)
            label_left:SetText("L")
            label_left:SetTextColor(Color(0,0,0))
            label_left:SetPos(90, 50)

            local editor_left = vgui.Create("DComboBox", panel)
            editor_left:SetSize(175, 30)
            editor_left:SetPos(110, 45)
            for class,perk in pairs(HORDE.perks) do
                editor_left:AddChoice(class)
            end

            local label_right = vgui.Create("DLabel", panel)
            label_right:SetText("R")
            label_right:SetTextColor(Color(0,0,0))
            label_right:SetPos(90, 80)

            local editor_right = vgui.Create("DComboBox", panel)
            editor_right:SetSize(175, 30)
            editor_right:SetPos(110, 75)
            for class,perk in pairs(HORDE.perks) do
                editor_right:AddChoice(class)
            end

            local editors = {editor_title=editor_title, editor_left=editor_left, editor_right=editor_right}
            return editors
        elseif name == "player model" then
            local editor = vgui.Create("DTextEntry", panel)
            editor:SetSize(175, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)

            local eg = vgui.Create("DLabel", panel)
            eg:SetSize(175, height)
            eg:SetPos(290, 0)
            eg:SetText("e.g. alyx, css_arctic")
            eg:SetTextColor(color_black)
            return editor
        else
            local editor = vgui.Create("DTextEntry", panel)
            editor:SetSize(175, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            return editor
        end
    end

    local name_editor = create_property_editor("class name", 50, basic_panel)
    local display_name_editor = create_property_editor("display name", 50, basic_panel)
    local description_editor = create_property_editor("extra description", 200, basic_panel)
    local model_editor = create_property_editor("player model", 50, basic_panel)
    local icon_editor = create_property_editor("icon", 50, basic_panel)
    local perks0_editor = create_property_editor("Tier 0", 50, perks_panel)
    local perks1_editors = create_property_editor("Tier 1", 120, perks_panel)
    local perks2_editors = create_property_editor("Tier 2", 120, perks_panel)
    local perks3_editors = create_property_editor("Tier 3", 120, perks_panel)
    local perks4_editors = create_property_editor("Tier 4", 120, perks_panel)

    name_editor:SetText("")
    display_name_editor:SetText("")
    description_editor:SetMultiline(true)
    model_editor:SetText("")

    if GetConVarNumber("horde_default_class_config") == 1 then
        local warning_label = vgui.Create("DLabel", modify_tab)
        warning_label:DockMargin(10, 10, 10, 10)
        warning_label:Dock(TOP)
        warning_label:SetSize(modify_tab:GetWide(), 50)
        warning_label:SetTextColor(Color(255,0,0))
        warning_label:SetText("You are using default config!\nYour data won't be saved!")
        warning_label:SetFont("Heading")
    end

    local btn_panel = vgui.Create("DPanel", self)
    btn_panel:SetPos(self:GetWide() - 150, 50)
    btn_panel:SetSize(150, self:GetTall() - 58)
    btn_panel:SetBackgroundColor(HORDE.color_none)

    local save_btn = vgui.Create("DButton", btn_panel)
    save_btn:Dock(TOP)
    save_btn:SetText("Save")
    save_btn:SetTall(30)
    save_btn:DockMargin(10, 5, 10, 5)
    save_btn.DoClick = function ()
        if GetConVarNumber("horde_default_class_config") == 1 then return end
        local name = name_editor:GetValue()
        local model = nil
        if model_editor:GetValue() ~= "" then model = model_editor:GetValue() end

        local icon = nil
        if icon_editor:GetValue() ~= "" then icon = icon_editor:GetValue() end
        
        local base_perk = nil
        if perks0_editor:GetValue() ~= "" then base_perk = perks0_editor:GetValue() end

        local perk1title = nil
        if perks1_editors.editor_title:GetValue() ~= "" then perk1title = perks1_editors.editor_title:GetValue() end

        local perk1l = nil
        if perks1_editors.editor_left:GetValue() ~= "" then perk1l = perks1_editors.editor_left:GetValue() end

        local perk1r = nil
        if perks1_editors.editor_right:GetValue() ~= "" then perk1r = perks1_editors.editor_right:GetValue() end

        local perk2title = nil
        if perks2_editors.editor_title:GetValue() ~= "" then perk2title = perks2_editors.editor_title:GetValue() end

        local perk2l = nil
        if perks2_editors.editor_left:GetValue() ~= "" then perk2l = perks2_editors.editor_left:GetValue() end

        local perk2r = nil
        if perks2_editors.editor_right:GetValue() ~= "" then perk2r = perks2_editors.editor_right:GetValue() end

        local perk3title = nil
        if perks3_editors.editor_title:GetValue() ~= "" then perk3title = perks3_editors.editor_title:GetValue() end
    
        local perk3l = nil
        if perks3_editors.editor_left:GetValue() ~= "" then perk3l = perks3_editors.editor_left:GetValue() end

        local perk3r = nil
        if perks3_editors.editor_right:GetValue() ~= "" then perk3r = perks3_editors.editor_right:GetValue() end

        local perk4title = nil
        if perks4_editors.editor_title:GetValue() ~= "" then perk4title = perks4_editors.editor_title:GetValue() end
    
        local perk4l = nil
        if perks4_editors.editor_left:GetValue() ~= "" then perk4l = perks4_editors.editor_left:GetValue() end

        local perk4r = nil
        if perks4_editors.editor_right:GetValue() ~= "" then perk4r = perks4_editors.editor_right:GetValue() end
        
        if name and HORDE.classes[name] then
            HORDE.classes[name].display_name = display_name_editor:GetValue()
            HORDE.classes[name].extra_description = description_editor:GetValue()
            HORDE.classes[name].model = model
            HORDE.classes[name].icon = icon
            if base_perk then HORDE.classes[name].base_perk = base_perk end
            if not HORDE.classes[name].perks then
                HORDE.classes[name].perks =  {
                    [1] = {title = "", choices = {"", ""}},
                    [2] = {title = "", choices = {"", ""}},
                    [3] = {title = "", choices = {"", ""}},
                    [4] = {title = "", choices = {"", ""}},
                }
            end

            if perk1title then HORDE.classes[name].perks[1].title = perk1title end
            if perk2title then HORDE.classes[name].perks[2].title = perk2title end
            if perk3title then HORDE.classes[name].perks[3].title = perk3title end
            if perk4title then HORDE.classes[name].perks[4].title = perk4title end
            if perk1l then HORDE.classes[name].perks[1].choices[1] = perk1l end
            if perk1r then HORDE.classes[name].perks[1].choices[2] = perk1r end
            if perk2l then HORDE.classes[name].perks[2].choices[1] = perk2l end
            if perk2r then HORDE.classes[name].perks[2].choices[2] = perk2r end
            if perk3l then HORDE.classes[name].perks[3].choices[1] = perk3l end
            if perk3r then HORDE.classes[name].perks[3].choices[2] = perk3r end
            if perk4l then HORDE.classes[name].perks[4].choices[1] = perk4l end
            if perk4r then HORDE.classes[name].perks[4].choices[2] = perk4r end

            net.Start("Horde_SetClassData")
            net.WriteTable(HORDE.classes)
            net.SendToServer()
            HORDE:PlayNotification("Your changes have been saved.")
        end
    end

    local reset_btn = vgui.Create("DButton", btn_panel)
    reset_btn:Dock(BOTTOM)
    reset_btn:SetText("Reset Everything")
    reset_btn:SetTall(30)
    reset_btn:DockMargin(10, 5, 10, 5)
    reset_btn.DoClick = function ()
        if GetConVarNumber("horde_default_class_config") == 1 then return end
        HORDE.classes = {}
        HORDE:GetDefaultClassesData()

        net.Start("Horde_SetClassData")
        net.WriteTable(HORDE.classes)
        net.SendToServer()
        HORDE:PlayNotification("Your changes have been saved.")
    end

    local settings_tab = vgui.Create("DPanel", self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40 - 3)
    settings_tab:SetBackgroundColor(HORDE.color_none)

    local class_list = vgui.Create("DListView", settings_tab)
    class_list:DockMargin(10, 10, 10, 10)
    class_list:Dock(FILL)

    class_list:SetMultiSelect(false)
    class_list:AddColumn("Display Name")
    class_list:AddColumn("Description")

    class_list:SetDataHeight(40)

    function LoadPerks(class, editors, i)
        if not class.perks or not class.perks[i] then
            return
        end
        editors.editor_title:SetValue(class.perks[i].title)
        editors.editor_left:SetValue(class.perks[i].choices[1])
        editors.editor_right:SetValue(class.perks[i].choices[2])
    end

    class_list.OnClickLine = function(parent, line, selected)
        local class = line.class

        local menu = DermaMenu()

        menu:AddOption("Modify", function()
            name_editor:SetText(class.name)
            display_name_editor:SetValue(class.display_name)
            description_editor:SetValue(class.extra_description)
            model_editor:SetValue(class.model or "")
            icon_editor:SetValue(class.icon or "")
            perks0_editor:SetValue(class.base_perk or "")
            LoadPerks(class, perks1_editors, 1)
            LoadPerks(class, perks2_editors, 2)
            LoadPerks(class, perks3_editors, 3)
            LoadPerks(class, perks4_editors, 4)
        end)

        menu:AddSpacer()

        menu:Open()
    end

    self.class_list = class_list
end

function PANEL:Think()
    local lines = self.class_list:GetLines()

    for _, class in pairs(HORDE.classes) do
        local found = false
        for _, line in pairs(lines) do
            if line.class == class then
                found = true
            end
        end
        if not found then
            self.class_list:AddLine(class.display_name, class.description).class = class
        end
    end

    for i, line in pairs(lines) do
        if table.HasValue(HORDE.classes, line.class) then
            local class = line.class

            line:SetValue(1, class.display_name)
            line:SetValue(2, class.extra_description)
        else
            self.class_list:RemoveLine(i)
        end
    end
end

function PANEL:Paint(w, h)
    -- Entire Panel
    draw.RoundedBox(10, 0, 0, w, h, HORDE.color_config_bg)

    -- Background
    draw.RoundedBox(10, 0, 0, w, 40, HORDE.color_config_bar)

    draw.SimpleText("Horde Class Configuration", "Trebuchet24", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeClassConfig", PANEL, "EditablePanel")