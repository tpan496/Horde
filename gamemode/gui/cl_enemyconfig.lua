if SERVER then return end

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

    local modify_tab = vgui.Create("DScrollPanel", self)
    modify_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)
    modify_tab:SetPos(self:GetWide() / 2, 40)

    local function create_property_editor(name, height)
        local panel = vgui.Create("DPanel", modify_tab)
        panel:DockPadding(10, 10, 10, 10)
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
        elseif name == "elite" then
            local editor = vgui.Create("DCheckBox", panel)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            editor:SetWide(30)
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
        else
            local editor = vgui.Create("DTextEntry", panel)
            editor:SetSize(150, height)
            editor:DockPadding(10, 10, 10, 10)
            editor:Dock(LEFT)
            return editor
        end
    end

    local name_editor = create_property_editor("name", 45)
    local class_editor = create_property_editor("class", 45)
    local weight_editor = create_property_editor("weight", 45)
    local wave_editor = create_property_editor("wave", 45)
    local elite_editor = create_property_editor("elite", 45)
    local health_editor = create_property_editor("health scaling", 45)
    local damage_editor = create_property_editor("damage scaling", 45)
    local reward_editor = create_property_editor("reward scaling", 45)
    local model_scale_editor = create_property_editor("model scaling", 45)
    local weapon_editor = create_property_editor("weapon", 45)
    local color_editor = create_property_editor("color", 130)

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
            weapon
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
        Derma_Query('Overwrite?', 'Overwrite with Default Config',
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
        Derma_Query('Delete Everything?', 'Delete Everything',
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
            elite_editor:SetChecked(enemy.is_elite)
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
    -- Derma_DrawBackgroundBlur(self)

    -- Entire Panel
    surface.SetDrawColor(Color(230, 230, 230))
    surface.DrawRect(0, 0, w, h)

    -- Background
    surface.SetDrawColor(Color(40, 40, 40))
    surface.DrawRect(0, 0, w, 48)

    draw.SimpleText("Enemy Config (Some settings require restarting current game to take effect)", "Heading", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeEnemyConfig", PANEL, "EditablePanel")