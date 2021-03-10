local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() / 1.25, ScrH() / 1.5)
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))
    self:MakePopup()

    local close_btn = vgui.Create("DButton", self)
    close_btn:SetFont("marlett")
    close_btn:SetText("r")
    close_btn.Paint = function() end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(32, 32)
    close_btn:SetPos(self:GetWide() - 40, 6)
    close_btn.DoClick = function() HORDE:ToggleEnemyConfig() end

    local modify_tab = vgui.Create("DCategoryList", self)
    modify_tab:SetBackgroundColor(Color(230, 230, 230))
    modify_tab:SetSize(self:GetWide() / 2 - 210, self:GetTall() - 40)
    modify_tab:SetPos(self:GetWide() / 2, 40)

    local required_cat = modify_tab:Add("Required")
    local required_panel = vgui.Create("DPanel", modify_tab)
    required_cat:SetContents(required_panel)
    local basic_modifier_cat = modify_tab:Add("Basic Modifiers")
    local basic_modifier_panel = vgui.Create("DPanel", modify_tab)
    basic_modifier_cat:SetContents(basic_modifier_panel)
    basic_modifier_cat:SetExpanded(false)
    local elite_modifier_cat = modify_tab:Add("Elite/Boss Modifiers")
    local elite_modifier_panel = vgui.Create("DPanel", modify_tab)
    elite_modifier_cat:SetContents(elite_modifier_panel)
    elite_modifier_cat:SetExpanded(false)

    local function create_property_editor(name, height, cat_panel)
        local panel = vgui.Create("DPanel", cat_panel)
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
        label:SetWide(100)
        label:Dock(LEFT)

        if name == "class" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            local npcs = list.Get("NPC")
            for class, _ in pairs(npcs) do
                editor:AddChoice(class)
            end

            local editor_manual = vgui.Create("DTextEntry", panel)
            editor_manual:SetSize(150, height-10)
            editor_manual:SetPos(110, 5)
            editor_manual:SetVisible(false)
            function editor_manual:OnChange()
                editor:SetValue(editor_manual:GetValue())
            end

            local manual_toggle = vgui.Create("DCheckBoxLabel", panel)
            manual_toggle:SetText("Manual Input")
            manual_toggle:SetPos(150 + 100 + 20, 10)
            manual_toggle:SetTextColor(Color(0,0,0))

            function manual_toggle:OnChange(bVal)
                if bVal then
                    editor_manual:SetVisible(true)
                    editor:SetVisible(false)
                else
                    editor_manual:SetVisible(false)
                    editor:SetVisible(true)
                end
            end

            return editor
        elseif name == "wave" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSortItems(false)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            for i = 1, 10 do
                editor:AddChoice(i)
            end
            return editor
        elseif name == "color" then
            local editor1 = vgui.Create("DCheckBoxLabel", panel)
            editor1:DockPadding(10, 10, 10, 10)
            editor1:Dock(LEFT)
            editor1:SetText("Use Color")
            editor1:SetTextColor(Color(0,0,0))
            local editor2 = vgui.Create("DColorMixer", panel)
            editor2:DockPadding(10, 10, 10, 10)
            editor2:Dock(LEFT)
            editor2:SetPalette(false)
            return {enabled_editor=editor1, color_editor=editor2}
        elseif name == "weapon" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            for wpn, _ in pairs(list.Get("Weapon")) do
                editor:AddChoice(wpn)
            end
            editor:AddChoice("_gmod_default")
            editor:AddChoice("_gmod_none")
            return editor
        elseif name == "is elite" then
            local editor = vgui.Create("DCheckBox", panel)
            editor:SetPos(110, 10)
            return editor
        elseif name == "is boss" then
            local editors = {}
            local editor = vgui.Create("DCheckBox", panel)
            editor:SetPos(110, 10)
            editor:DockMargin(0,37,0,37)
            editor:Dock(LEFT)
            function editor:OnChange(bVal)
                for _, other_editor in pairs(editors) do
                    other_editor:SetVisible(bVal)
                end
            end

            local end_wave_toggle = vgui.Create("DCheckBoxLabel", panel)
            end_wave_toggle:SetText("End wave after defeated")
            end_wave_toggle:SetPos(100 + 50, 23)
            end_wave_toggle:SetTextColor(color_black)
            end_wave_toggle:SetVisible(false)
            table.insert(editors, end_wave_toggle)

            local unlimited_enemies_spawn_editor = vgui.Create("DCheckBoxLabel", panel)
            unlimited_enemies_spawn_editor:SetText("Unlimited enemies spawn during wave")
            unlimited_enemies_spawn_editor:SetPos(100 + 50, 43)
            unlimited_enemies_spawn_editor:SetTextColor(color_black)
            unlimited_enemies_spawn_editor:SetVisible(false)
            table.insert(editors, unlimited_enemies_spawn_editor)

            local enemies_spawn_threshold_label = vgui.Create("DLabel", panel)
            enemies_spawn_threshold_label:SetText("Spawn enemies after health dropped to ")
            enemies_spawn_threshold_label:SetPos(100 + 50, 63)
            enemies_spawn_threshold_label:SetTextColor(color_black)
            enemies_spawn_threshold_label:SetWide(200)
            enemies_spawn_threshold_label:SetVisible(false)
            table.insert(editors, enemies_spawn_threshold_label)
            local enemies_spawn_threshold_editor = vgui.Create("DTextEntry", panel)
            enemies_spawn_threshold_editor:SetNumeric(true)
            enemies_spawn_threshold_editor:SetPos(100 + 45 + 200, 63)
            enemies_spawn_threshold_editor:SetWide(25)
            enemies_spawn_threshold_editor:SetVisible(false)
            table.insert(editors, enemies_spawn_threshold_editor)
            local enemies_spawn_threshold_percentage_label = vgui.Create("DLabel", panel)
            enemies_spawn_threshold_percentage_label:SetText("* max health")
            enemies_spawn_threshold_percentage_label:SetPos(100 + 50 + 200 + 25, 63)
            enemies_spawn_threshold_percentage_label:SetTextColor(color_black)
            enemies_spawn_threshold_percentage_label:SetVisible(false)
            table.insert(editors, enemies_spawn_threshold_percentage_label)

            return {editor=editor, unlimited_enemies_spawn_editor=unlimited_enemies_spawn_editor, enemies_spawn_threshold_editor=enemies_spawn_threshold_editor}
        else
            local editor = vgui.Create("DTextEntry", panel)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            return editor
        end
    end

    local name_editor = create_property_editor("name", 35, required_panel)
    local class_editor = create_property_editor("class", 35, required_panel)
    local weight_editor = create_property_editor("spawn weight", 35, required_panel)
    local wave_editor = create_property_editor("wave", 35, required_panel)

    local health_editor = create_property_editor("health scaling", 35, basic_modifier_panel)
    local damage_editor = create_property_editor("damage scaling", 35, basic_modifier_panel)
    local reward_editor = create_property_editor("reward scaling", 35, basic_modifier_panel)
    local model_scale_editor = create_property_editor("model scaling", 35, basic_modifier_panel)
    local weapon_editor = create_property_editor("weapon", 35, basic_modifier_panel)
    local spawn_limit_editor = create_property_editor("spawn limit", 35, basic_modifier_panel)
    local color_editor = create_property_editor("color", 130, basic_modifier_panel)
    
    local elite_editor = create_property_editor("is elite", 35, elite_modifier_panel)
    local boss_editor = create_property_editor("is boss", 100, elite_modifier_panel)

    if GetConVarNumber("horde_default_enemy_config") == 1 or (GetConVarString("horde_external_lua_config") and GetConVarString("horde_external_lua_config") ~= "") then
        local warning_label = vgui.Create("DLabel", modify_tab)
        warning_label:DockPadding(10, 10, 10, 10)
        warning_label:Dock(TOP)
        warning_label:SetSize(modify_tab:GetWide(), 25)
        warning_label:SetTextColor(Color(255,0,0))
        warning_label:SetText("You are using default/external config! Your data won't be saved!")
    end

    weight_editor:SetNumeric(true)
    weight_editor:SetValue("1")
    wave_editor:SetValue("1")
    health_editor:SetValue("1")
    damage_editor:SetValue("1")
    reward_editor:SetValue("1")
    model_scale_editor:SetValue("1")
    spawn_limit_editor:SetValue("0")
    weapon_editor:SetValue("_gmod_default")

    local btn_panel = vgui.Create("DPanel", self)
    btn_panel:SetPos(self:GetWide() - 210, 50)
    btn_panel:SetSize(200, self:GetTall() - 200)
    btn_panel.Paint = function ()
        surface.SetDrawColor(Color(230,230,230,0))
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    end

    local save_btn = vgui.Create("DButton", btn_panel)
    save_btn:SetText("Save Enemy")
    save_btn:SetTall(40)
    save_btn:DockMargin(10, 10, 10, 10)
    save_btn:Dock(TOP)
    save_btn.DoClick = function ()
        if not name_editor:GetValue() or not class_editor:GetValue() then return end
        local color = nil
        if color_editor.enabled_editor:GetChecked() then
            color = color_editor.color_editor:GetColor()
        end
        local weapon = nil
        if weapon_editor and weapon_editor:GetText() ~= "_gmod_none" and weapon_editor:GetText() ~= "" then
            weapon = weapon_editor:GetText()
        end
        HORDE.CreateEnemy(
            name_editor:GetText(),
            class_editor:GetText(),
            weight_editor:GetFloat(),
            tonumber(wave_editor:GetText()),
            elite_editor:GetChecked(),
            health_editor:GetFloat(),
            damage_editor:GetFloat(),
            reward_editor:GetFloat(),
            model_scale_editor:GetFloat(),
            color,
            weapon,
            spawn_limit_editor:GetInt(),
            boss_editor:GetChecked()
        )

        -- Reload from disk
        net.Start("Horde_SetEnemiesData")
        net.WriteTable(HORDE.enemies)
        net.SendToServer()
        notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
    end

    local save_for_waves = vgui.Create("DPanel", btn_panel)
    save_for_waves:Dock(TOP)
    save_for_waves:DockMargin(10, 10, 10, 10)
    save_for_waves:SetTall(90)
    save_for_waves.Paint = function () end

    local boxes_pane = vgui.Create("DPanel", save_for_waves)
    boxes_pane:Dock(BOTTOM)
    boxes_pane.Paint = function () end
    boxes_pane:SetTall(50)
    local wave_start_box = vgui.Create("DComboBox", boxes_pane)
    wave_start_box:SetPos(10,10)
    wave_start_box:SetSize(50,30)
    wave_start_box:SetSortItems(false)
    local to_label = vgui.Create("DLabel", boxes_pane)
    to_label:SetText("to")
    to_label:SetTextColor(Color(0,0,0))
    to_label:SetPos(80,15)
    local wave_end_box = vgui.Create("DComboBox", boxes_pane)
    wave_end_box:SetPos(120,10)
    wave_end_box:SetSize(50,30)
    wave_end_box:SetSortItems(false)
    for i = 1, 10 do
        wave_start_box:AddChoice(i)
        wave_end_box:AddChoice(i)
    end

    local save_after_btn = vgui.Create("DButton", save_for_waves)
    save_after_btn:Dock(BOTTOM)
    save_after_btn:SetText("Save Enemy From Wave A to B:")
    save_after_btn:SetTall(40)
    save_after_btn.DoClick = function ()
        if not name_editor:GetValue() or not class_editor:GetValue() then return end
        local color = nil
        if color_editor.enabled_editor:GetChecked() then
            color = color_editor.color_editor:GetColor()
        end
        local weapon = nil
        if weapon_editor and weapon_editor:GetText() ~= "_gmod_none" and weapon_editor:GetText() ~= "" then
            weapon = weapon_editor:GetText()
        end

        local start_wave = tonumber(wave_start_box:GetText())
        local end_wave = tonumber(wave_end_box:GetText())
        if start_wave > end_wave then return end

        for i = start_wave, end_wave do
            HORDE.CreateEnemy(
            name_editor:GetText(),
            class_editor:GetText(),
            weight_editor:GetFloat(),
            i,
            elite_editor:GetChecked(),
            health_editor:GetFloat(),
            damage_editor:GetFloat(),
            reward_editor:GetFloat(),
            model_scale_editor:GetFloat(),
            color,
            weapon
        )
        end

        net.Start("Horde_SetEnemiesData")
        net.WriteTable(HORDE.enemies)
        net.SendToServer()
        notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
    end

    local load_btn = vgui.Create("DButton", btn_panel)
    load_btn:Dock(TOP)
    load_btn:DockMargin(10, 10, 10, 10)
    load_btn:SetText("OVERWRITE with Default Config")
    load_btn:SetTall(40)
    load_btn.DoClick = function ()
        Derma_Query("Overwrite?", "Overwrite with Default Config",
            "Yes",
            function()
                HORDE.enemies = {}
                HORDE.GetDefaultEnemiesData()

                net.Start("Horde_SetEnemiesData")
                net.WriteTable(HORDE.enemies)
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local del_btn = vgui.Create("DButton", btn_panel)
    del_btn:Dock(TOP)
    del_btn:DockMargin(10, 10, 10, 10)
    del_btn:SetText("Delete Everything")
    del_btn:SetTall(40)
    del_btn.DoClick = function ()
        Derma_Query("Delete Everything?", "Delete Everything",
            "Yes",
            function()
                HORDE.enemies = {}

                net.Start("Horde_SetEnemiesData")
                net.WriteTable(HORDE.enemies)
                net.SendToServer()
                notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
            end,
            "No", function() end
        )
    end

    local settings_tab = vgui.Create("DPanel", self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)

    local enemy_list = vgui.Create("DListView", settings_tab)
    enemy_list:DockMargin(10, 10, 10, 10)
    enemy_list:Dock(FILL)

    enemy_list:SetMultiSelect(false)
    enemy_list:AddColumn("Wave")
    enemy_list:AddColumn("Name")
    enemy_list:AddColumn("Class")
    enemy_list:AddColumn("Weight")

    enemy_list:SetDataHeight(20)

    enemy_list.OnClickLine = function(parent, line, selected)
        local enemy = line.enemy

        local menu = DermaMenu()

        menu:AddOption("Modify", function()
            name_editor:SetValue(enemy.name)
            class_editor:SetValue(enemy.class)
            weight_editor:SetValue(enemy.weight)
            wave_editor:SetValue(enemy.wave)
            health_editor:SetValue(enemy.health_scale and enemy.health_scale or 1)
            damage_editor:SetValue(enemy.damage_scale and enemy.damage_scale or 1)
            reward_editor:SetValue(enemy.reward_scale and enemy.reward_scale or 1)
            model_scale_editor:SetValue(enemy.model_scale and enemy.model_scale or 1)
            if enemy.color then
                color_editor.enabled_editor:SetChecked(true)
                color_editor.color_editor:SetColor(enemy.color)
            else
                color_editor.enabled_editor:SetChecked(false)
            end
            if enemy.weapon and enemy.weapon ~= "_gmod_none" and enemy.weapon ~= "" then
                weapon_editor:SetValue(enemy.weapon)
            else
                weapon_editor:SetValue("_gmod_none")
            end
            elite_editor:SetChecked(enemy.is_elite)
            boss_editor:SetChecked(enemy.is_boss and enemy.is_boss or false)
            spawn_limit_editor:SetValue(enemy.spawn_limit and enemy.spawn_limit or 0)
        end)

        menu:AddOption("Delete", function()
            HORDE.enemies[enemy.name .. tostring(enemy.wave)] = nil

			net.Start("Horde_SetEnemiesData")
            net.WriteTable(HORDE.enemies)
        	net.SendToServer()
			notification.AddLegacy("Your changes have been saved.", NOTIFY_GENERIC, 5)
        end)

        menu:AddSpacer()

        menu:Open()
    end

    self.enemy_list = enemy_list
end

function PANEL:Think()
    local lines = self.enemy_list:GetLines()

    if not HORDE.enemies then return end
    for _, enemy in pairs(HORDE.enemies) do
        local found = false
        for _, line in pairs(lines) do
            if line.enemy == enemy then
                found = true
            end
        end
        if not found then
            self.enemy_list:AddLine(enemy.wave, enemy.name, enemy.class, enemy.weight).enemy = enemy
        end

        ::cont::
    end

    for i, line in pairs(lines) do
        if table.HasValue(HORDE.enemies, line.enemy) then
            local enemy = line.enemy

            line:SetValue(1, enemy.wave)
            line:SetValue(2, enemy.name)
            line:SetValue(3, enemy.class)
            line:SetValue(4, enemy.weight)
        else
            self.enemy_list:RemoveLine(i)
        end
    end
end

function PANEL:Paint(w, h)
    -- Entire Panel
    surface.SetDrawColor(Color(230, 230, 230))
    surface.DrawRect(0, 0, w, h)

    -- Background
    surface.SetDrawColor(Color(17,148,240))
    surface.DrawRect(0, 0, w, 40)

    draw.SimpleText("Enemy Config (Some settings require restart to take effect)", "Trebuchet24", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeEnemyConfig", PANEL, "EditablePanel")
