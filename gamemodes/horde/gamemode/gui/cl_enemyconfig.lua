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
    close_btn.DoClick = function() HORDE:ToggleEnemyConfig() end

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
    q_btn.DoClick = function() gui.OpenURL("https://github.com/tpan496/Horde/wiki/Enemy-Config") end

    local modify_tab = vgui.Create("DCategoryList", self)
    modify_tab:SetBackgroundColor(HORDE.color_config_content_bg)
    modify_tab:SetSize(self:GetWide() / 2 - 150, self:GetTall() - 50 - 12)
    modify_tab:SetPos(self:GetWide() / 2, 50)

    local required_cat = modify_tab:Add("Required")
    local required_panel = vgui.Create("DPanel", modify_tab)
    required_cat:SetContents(required_panel)
    required_panel:SetBackgroundColor(HORDE.color_none)
    local basic_modifier_cat = modify_tab:Add("Basic Modifiers")
    local basic_modifier_panel = vgui.Create("DPanel", modify_tab)
    basic_modifier_cat:SetContents(basic_modifier_panel)
    basic_modifier_cat:SetExpanded(false)
    basic_modifier_panel:SetBackgroundColor(HORDE.color_none)
    local elite_modifier_cat = modify_tab:Add("Elite/Boss Modifiers")
    local elite_modifier_panel = vgui.Create("DPanel", modify_tab)
    elite_modifier_cat:SetContents(elite_modifier_panel)
    elite_modifier_cat:SetExpanded(false)
    elite_modifier_panel:SetBackgroundColor(HORDE.color_none)
    local mut_modifier_cat = modify_tab:Add("Mutation Modifiers")
    local mut_modifier_panel = vgui.Create("DPanel", modify_tab)
    mut_modifier_cat:SetContents(mut_modifier_panel)
    mut_modifier_cat:SetExpanded(false)
    mut_modifier_panel:SetBackgroundColor(HORDE.color_none)
    local gadget_modifier_cat = modify_tab:Add("Gadget Drop")
    local gadget_modifier_panel = vgui.Create("DPanel", modify_tab)
    gadget_modifier_cat:SetContents(gadget_modifier_panel)
    gadget_modifier_cat:SetExpanded(false)
    gadget_modifier_panel:SetBackgroundColor(HORDE.color_none)

    local function create_property_editor(name, height, cat_panel)
        local panel = vgui.Create("DPanel", cat_panel)
        panel:DockPadding(10, 5, 10, 5)
        panel:SetSize(modify_tab:GetWide(), height)
        panel:Dock(TOP)
        panel:SetBackgroundColor(HORDE.color_none)

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
            editor:DockMargin(0,57,0,57)
            editor:Dock(LEFT)
            function editor:OnChange(bVal)
                if bVal then
                    for _, other_editor in pairs(editors) do
                        other_editor:SetVisible(true)
                    end
                else
                    for _, other_editor in pairs(editors) do
                        other_editor:SetVisible(false)
                    end
                end
            end

            local end_wave_editor = vgui.Create("DCheckBoxLabel", panel)
            local unlimited_enemies_spawn_editor = vgui.Create("DCheckBoxLabel", panel)
            
            end_wave_editor:SetText("End wave after defeated")
            end_wave_editor:SetPos(100 + 50, 23)
            end_wave_editor:SetTextColor(color_black)
            end_wave_editor:SetVisible(false)
            function end_wave_editor:OnChange(bVal)
                if not bVal then
                    unlimited_enemies_spawn_editor:SetChecked(false)
                end
            end
            table.insert(editors, end_wave_editor)

            unlimited_enemies_spawn_editor:SetText("Unlimited enemies spawn during wave")
            unlimited_enemies_spawn_editor:SetPos(100 + 50, 43)
            unlimited_enemies_spawn_editor:SetTextColor(color_black)
            unlimited_enemies_spawn_editor:SetVisible(false)
            function unlimited_enemies_spawn_editor:OnChange(bVal)
                if bVal then
                    end_wave_editor:SetChecked(true)
                end
            end
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
            enemies_spawn_threshold_editor:SetValue(0.5)
            enemies_spawn_threshold_editor:SetVisible(false)
            table.insert(editors, enemies_spawn_threshold_editor)
            local enemies_spawn_threshold_percentage_label = vgui.Create("DLabel", panel)
            enemies_spawn_threshold_percentage_label:SetText("* max health")
            enemies_spawn_threshold_percentage_label:SetPos(100 + 50 + 200 + 25, 63)
            enemies_spawn_threshold_percentage_label:SetTextColor(color_black)
            enemies_spawn_threshold_percentage_label:SetVisible(false)
            table.insert(editors, enemies_spawn_threshold_percentage_label)

            local music_label = vgui.Create("DLabel", panel)
            music_label:SetText("Boss Music")
            music_label:SetTextColor(color_black)
            music_label:SetWide(100)
            music_label:SetPos(100 + 50, 83)
            music_label:SetVisible(false)
            table.insert(editors, music_label)
            local music_editor = vgui.Create("DTextEntry", panel)
            music_editor:SetWide(100)
            music_editor:SetPos(100 + 50 + 90, 83)
            music_editor:SetVisible(false)
            table.insert(editors, music_editor)

            local music_duration_label = vgui.Create("DLabel", panel)
            music_duration_label:SetText("Music Duration (s)")
            music_duration_label:SetTextColor(color_black)
            music_duration_label:SetWide(100)
            music_duration_label:SetPos(100 + 50, 103)
            music_duration_label:SetVisible(false)
            table.insert(editors, music_duration_label)
            local music_duration_editor = vgui.Create("DTextEntry", panel)
            music_duration_editor:SetWide(100)
            music_duration_editor:SetPos(100 + 50 + 90, 103)
            music_duration_editor:SetNumeric()
            music_duration_editor:SetVisible(false)
            table.insert(editors, music_duration_editor)

            local boss_note_label = vgui.Create("DLabel", panel)
            boss_note_label:SetText("*Note: Boss kill reward is global.")
            boss_note_label:SetPos(100 + 50, 123)
            boss_note_label:SetTextColor(color_black)
            boss_note_label:SetVisible(false)
            boss_note_label:SetWide(200)
            table.insert(editors, boss_note_label)

            return {is_boss_editor=editor, end_wave_editor=end_wave_editor, unlimited_enemies_spawn_editor=unlimited_enemies_spawn_editor, enemies_spawn_threshold_editor=enemies_spawn_threshold_editor, music_editor=music_editor, music_duration_editor=music_duration_editor}
        elseif name == "mutation" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSortItems(false)
            editor:SetSize(150, 25)
            editor:SetPos(110, 10)

            editor:AddChoice("")
            for class,_ in pairs(HORDE.mutations) do
                editor:AddChoice(class)
            end

            local mut_label = vgui.Create("DLabel", panel)
            mut_label:SetText("No Mutation Selected")
            mut_label:SetTextColor(color_black)
            mut_label:SetSize(300, height/2)
            mut_label:SetPos(110, 40)

            function editor:OnSelect(index, value, data)
                if value == "" then
                    mut_label:SetText("No Mutation Selected")
                else
                    mut_label:SetText(HORDE.mutations[value])
                end
            end

            return editor
        elseif name == "spawn limit" then
            local editor = vgui.Create("DTextEntry", panel)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)

            local warning_label = vgui.Create("DLabel", panel)
            warning_label:SetColor(color_black)
            warning_label:SetText("0 -- No limit")
            warning_label:SetPos(275, 8)
            warning_label:SetWide(100)
            return editor
        elseif name == "gadget" then
            local editor = vgui.Create("DComboBox", panel)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            for class, item in pairs(HORDE.items) do
                if item.category == "Gadget" and HORDE.gadgets[class].Droppable then
                    editor:AddChoice(class)
                end
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
    local skin_editor = create_property_editor("skin", 35, basic_modifier_panel)
    local model_editor = create_property_editor("model override", 35, basic_modifier_panel)
    local spawn_limit_editor = create_property_editor("spawn limit", 35, basic_modifier_panel)
    local color_editor = create_property_editor("color", 130, basic_modifier_panel)
    
    local elite_editor = create_property_editor("is elite", 35, elite_modifier_panel)
    local boss_editors = create_property_editor("is boss", 140, elite_modifier_panel)

    local mut_editor = create_property_editor("mutation", 70, mut_modifier_panel)

    local gadget_editor = create_property_editor("gadget", 35, gadget_modifier_panel)
    local gadget_drop_editor = create_property_editor("drop rate", 35, gadget_modifier_panel)

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
    skin_editor:SetNumeric(true)
    skin_editor:SetValue("")
    model_scale_editor:SetValue("1")
    spawn_limit_editor:SetValue("0")
    weapon_editor:SetValue("_gmod_default")
    mut_editor:SetValue("")
    gadget_editor:SetValue("")
    gadget_drop_editor:SetValue("")

    local btn_panel = vgui.Create("DPanel", self)
    btn_panel:SetPos(self:GetWide() - 150, 50)
    btn_panel:SetSize(150, self:GetTall() - 58)
    btn_panel.Paint = function ()
        surface.SetDrawColor(HORDE.color_none)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    end

    local save_btn = vgui.Create("DButton", btn_panel)
    save_btn:SetText("Save Enemy")
    save_btn:SetTall(30)
    save_btn:DockMargin(10, 5, 10, 5)
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
        local boss_properties = {}
        boss_properties.is_boss = boss_editors.is_boss_editor:GetChecked()
        boss_properties.end_wave = boss_editors.end_wave_editor:GetChecked()
        boss_properties.unlimited_enemies_spawn = boss_editors.unlimited_enemies_spawn_editor:GetChecked()
        boss_properties.enemies_spawn_threshold = tonumber(boss_editors.enemies_spawn_threshold_editor:GetText())
        boss_properties.music = boss_editors.music_editor:GetText()
        boss_properties.music_duration = tonumber(boss_editors.music_duration_editor:GetText())

        local skin = nil
        if skin_editor:GetText() ~= "" then
            skin = tonumber(skin_editor:GetText())
        end

        local gadget_drop = {}
        gadget_drop.gadget = gadget_editor:GetText()
        if gadget_drop_editor:GetText() and gadget_drop_editor:GetText() ~= "" then
            gadget_drop.drop_rate = math.max(0, tonumber(gadget_drop_editor:GetText()) or 0)
        end
        
        if gadget_drop.gadget and gadget_drop.gadget ~= "" and gadget_drop.drop_rate and gadget_drop.drop_rate > 0 then
        else
            gadget_drop = nil
        end

        HORDE:CreateEnemy(
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
            boss_properties,
            mut_editor:GetText(),
            skin,
            model_editor:GetText(),
            nil,
            gadget_drop
        )

        -- Reload from disk
        local tab = util.TableToJSON(HORDE.enemies)
        local str = util.Compress(tab)
        net.Start("Horde_SetEnemiesData")
            net.WriteUInt(string.len(str), 32)
            net.WriteData(str, string.len(str))
        net.SendToServer()
        HORDE:PlayNotification("Your changes have been saved.")
    end

    local save_for_waves = vgui.Create("DPanel", btn_panel)
    save_for_waves:Dock(TOP)
    save_for_waves:DockMargin(10, 0, 10, 0)
    save_for_waves:SetTall(90)
    save_for_waves.Paint = function () end

    local boxes_pane = vgui.Create("DPanel", save_for_waves)
    boxes_pane:Dock(BOTTOM)
    boxes_pane:SetTall(50)
    boxes_pane:SetBackgroundColor(HORDE.color_none)

    local wave_start_box = vgui.Create("DComboBox", boxes_pane)
    wave_start_box:SetPos(0,10)
    wave_start_box:SetSize(50,30)
    wave_start_box:SetSortItems(false)
    
    local to_label = vgui.Create("DLabel", boxes_pane)
    to_label:SetText("to")
    to_label:SetTextColor(Color(0,0,0))
    to_label:SetPos(65,15)
    
    local wave_end_box = vgui.Create("DComboBox", boxes_pane)
    wave_end_box:SetPos(85,10)
    wave_end_box:SetSize(50,30)
    wave_end_box:SetSortItems(false)
    for i = 1, 10 do
        wave_start_box:AddChoice(i)
        wave_end_box:AddChoice(i)
    end

    local save_after_btn = vgui.Create("DButton", save_for_waves)
    save_after_btn:Dock(BOTTOM)
    save_after_btn:SetText("Copy From Wave A to B:")
    save_after_btn:SetTall(30)
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

        local boss_properties = {}
        boss_properties.is_boss = boss_editors.is_boss_editor:GetChecked()
        boss_properties.end_wave = boss_editors.end_wave_editor:GetChecked()
        boss_properties.unlimited_enemies_spawn = boss_editors.unlimited_enemies_spawn_editor:GetChecked()
        boss_properties.enemies_spawn_threshold = tonumber(boss_editors.enemies_spawn_threshold_editor:GetText())
        boss_properties.music = boss_editors.music_editor:GetText()
        boss_properties.music_duration = tonumber(boss_editors.music_duration_editor:GetText())

        local skin = nil
        if skin_editor:GetText() ~= "" then
            skin = tonumber(skin_editor:GetText())
        end

        local gadget_drop = {}
        gadget_drop.gadget = gadget_editor:GetText()
        if gadget_drop_editor:GetText() and gadget_drop_editor:GetText() ~= "" then
            gadget_drop.drop_rate = math.max(0, tonumber(gadget_drop_editor:GetText()) or 0)
        end
        
        if gadget_drop.gadget and gadget_drop.gadget ~= "" and gadget_drop.drop_rate and gadget_drop.drop_rate > 0 then
        else
            gadget_drop = nil
        end

        local start_wave = tonumber(wave_start_box:GetText())
        local end_wave = tonumber(wave_end_box:GetText())
        if start_wave > end_wave then return end
        
        for i = start_wave, end_wave do
            HORDE:CreateEnemy(
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
                weapon,
                spawn_limit_editor:GetInt(),
                boss_properties,
                mut_editor:GetText(),
                skin,
                model_editor:GetText(),
                nil,
                gadget_drop
            )
        end

        local tab = util.TableToJSON(HORDE.enemies)
        local str = util.Compress(tab)
        net.Start("Horde_SetEnemiesData")
            net.WriteUInt(string.len(str), 32)
            net.WriteData(str, string.len(str))
        net.SendToServer()
        HORDE:PlayNotification("Your changes have been saved.")
    end

    local load_btn = vgui.Create("DButton", btn_panel)
    load_btn:Dock(BOTTOM)
    load_btn:DockMargin(10, 5, 10, 5)
    load_btn:SetText("OVERWRITE with Default")
    load_btn:SetTall(30)
    load_btn.DoClick = function ()
        Derma_Query("Overwrite?", "Overwrite with Default",
            "Yes",
            function()
                HORDE.enemies = {}
                HORDE:GetDefaultEnemiesData()

                local tab = util.TableToJSON(HORDE.enemies)
                local str = util.Compress(tab)
                net.Start("Horde_SetEnemiesData")
                    net.WriteUInt(string.len(str), 32)
                    net.WriteData(str, string.len(str))
                net.SendToServer()
                HORDE:PlayNotification("Your changes have been saved.")
            end,
            "No", function() end
        )
    end

    local load_defaut_btn = vgui.Create("DButton", btn_panel)
    load_defaut_btn:Dock(BOTTOM)
    load_defaut_btn:DockMargin(10,5,10,5)
    load_defaut_btn:SetTall(30)
    load_defaut_btn:SetText("Add Default Enemies")
    load_defaut_btn.DoClick = function ()
        Derma_Query("Add Default Enemies?", "Default Enemies",
            "Yes",
            function()
                HORDE:GetDefaultEnemiesData()

                local tab = util.TableToJSON(HORDE.enemies)
                local str = util.Compress(tab)
                net.Start("Horde_SetEnemiesData")
                    net.WriteUInt(string.len(str), 32)
                    net.WriteData(str, string.len(str))
                net.SendToServer()
                HORDE:PlayNotification("Your changes have been saved.")
            end,
            "No", function() end
        )
    end

    local del_btn = vgui.Create("DButton", btn_panel)
    del_btn:Dock(BOTTOM)
    del_btn:DockMargin(10, 5, 10, 5)
    del_btn:SetText("Delete Everything")
    del_btn:SetTall(30)
    del_btn.DoClick = function ()
        Derma_Query("Delete Everything?", "Delete Everything",
            "Yes",
            function()
                HORDE.enemies = {}

                local tab = util.TableToJSON(HORDE.enemies)
                local str = util.Compress(tab)
                net.Start("Horde_SetEnemiesData")
                    net.WriteUInt(string.len(str), 32)
                    net.WriteData(str, string.len(str))
                net.SendToServer()
                HORDE:PlayNotification("Your changes have been saved.")
            end,
            "No", function() end
        )
    end

    local settings_tab = vgui.Create("DPanel", self)
    settings_tab:SetPos(0, 40)
    settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40 - 3)
    settings_tab:SetBackgroundColor(HORDE.color_none)

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
            spawn_limit_editor:SetValue(enemy.spawn_limit and enemy.spawn_limit or 0)
            local boss_properties = enemy.boss_properties
            if boss_properties and boss_properties.is_boss and boss_properties.is_boss == true then
                boss_editors.is_boss_editor:SetChecked(true)
                boss_editors.is_boss_editor:OnChange(true)
                boss_editors.end_wave_editor:SetChecked(boss_properties.end_wave)
                boss_editors.unlimited_enemies_spawn_editor:SetChecked(boss_properties.unlimited_enemies_spawn)
                boss_editors.enemies_spawn_threshold_editor:SetValue(boss_properties.enemies_spawn_threshold)
                boss_editors.music_editor:SetValue(boss_properties.music and boss_properties.music or "")
                boss_editors.music_duration_editor:SetValue(boss_properties.music_duration and boss_properties.music_duration or "")
            else
                boss_editors.is_boss_editor:OnChange(false)
                boss_editors.is_boss_editor:SetChecked(false)
            end
            mut_editor:ChooseOption(enemy.mutation or "")
            skin_editor:SetValue(enemy.skin or "")
            model_editor:SetValue(enemy.model or "")
            if enemy.gadget_drop and enemy.gadget_drop.drop_rate and enemy.gadget_drop.drop_rate > 0 then
                gadget_editor:SetValue(enemy.gadget_drop.gadget)
                gadget_drop_editor:SetValue(enemy.gadget_drop.drop_rate)
            end
        end)

        menu:AddOption("Delete", function()
            HORDE.enemies[enemy.name .. tostring(enemy.wave)] = nil

            local tab = util.TableToJSON(HORDE.enemies)
            local str = util.Compress(tab)
			net.Start("Horde_SetEnemiesData")
                net.WriteUInt(string.len(str), 32)
                net.WriteData(str, string.len(str))
        	net.SendToServer()
			HORDE:PlayNotification("Your changes have been saved.")
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
    draw.RoundedBox(10, 0, 0, w, h, HORDE.color_config_bg)

    -- Background
    draw.RoundedBox(10, 0, 0, w, 40, HORDE.color_config_bar)

    draw.SimpleText("Horde Enemy Configuration", "Trebuchet24", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeEnemyConfig", PANEL, "EditablePanel")
