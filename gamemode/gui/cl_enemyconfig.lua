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
	close_btn.DoClick = function() HORDE:ToggleEnemyConfig() end

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
		label:SetWide(100)
		label:Dock(LEFT)
		
		if name == "class" then
			local editor = vgui.Create('DComboBox', panel)
			editor:SetSize(200, height)
			editor:DockPadding(10, 10, 10, 10)
			editor:Dock(LEFT)
            local npcs = list.Get("NPC")
            for class, _ in pairs(npcs) do
                editor:AddChoice(class)
            end
            return editor
        elseif name == "wave" then
            local editor = vgui.Create('DComboBox', panel)
            editor:SetSize(200, height)
			editor:DockPadding(10, 10, 10, 10)
			editor:Dock(LEFT)
            for i = 1, HORDE.max_waves do
                editor:AddChoice(i)
            end
            return editor
		elseif name == "elite" then
			local editor = vgui.Create('DCheckBox', panel)
			editor:DockPadding(10, 10, 10, 10)
			editor:Dock(LEFT)
			editor:SetWide(30)
			return editor
		elseif name == "color" then
			local editor1 = vgui.Create('DCheckBoxLabel', panel)
			editor1:DockPadding(10, 10, 10, 10)
			editor1:Dock(LEFT)
			editor1:SetText("Use Color")
			editor1:SetTextColor(Color(0,0,0))
			local editor2 = vgui.Create('DColorMixer', panel)
			editor2:DockPadding(10, 10, 10, 10)
			editor2:Dock(LEFT)
			editor2:SetPalette(false)
			return {enabled_editor=editor1, color_editor=editor2}
		else
			local editor = vgui.Create('DTextEntry', panel)
			editor:SetSize(200, height)
			editor:DockPadding(10, 10, 10, 10)
			editor:Dock(LEFT)
			return editor
		end
	end

	local name_editor = create_property_editor("name", 50)
	local class_editor = create_property_editor("class", 50)
	local weight_editor = create_property_editor("weight", 50)
    local wave_editor = create_property_editor("wave", 50)
	local elite_editor = create_property_editor("elite", 50)
	local health_editor = create_property_editor("health scaling", 50)
	local damage_editor = create_property_editor("damage scaling", 50)
	local reward_editor = create_property_editor("reward scaling", 50)
	local model_scale_editor = create_property_editor("model scaling", 50)
	local color_editor = create_property_editor("color", 150)

    if GetConVarNumber("horde_default_enemy_config") then
        local warning_label = vgui.Create('DLabel', modify_tab)
        warning_label:DockPadding(10, 10, 10, 10)
        warning_label:Dock(TOP)
        warning_label:SetSize(modify_tab:GetWide(), 50)
        warning_label:SetTextColor(Color(0,0,0))
        warning_label:SetText("You are using default config! Your data won't be saved!")
    end

	weight_editor:SetNumeric(true)

	local save_btn = vgui.Create('DButton', modify_tab)
	save_btn:Dock(BOTTOM)
	save_btn:SetText("Save")
	save_btn.DoClick = function ()
		local color = nil
		if color_editor.enabled_editor:GetChecked() then
			color = color_editor.color_editor:GetColor()
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
			color
		)
        HORDE.FinalizeEnemies()
	end

	local settings_tab = vgui.Create('DPanel', self)
	settings_tab:SetPos(0, 40)
	settings_tab:SetSize(self:GetWide() / 2, self:GetTall() - 40)

	local enemy_list = vgui.Create("DListView", settings_tab)
	enemy_list:DockMargin(10, 10, 10, 10)
	enemy_list:Dock(FILL)

	enemy_list:SetMultiSelect(false)
	enemy_list:AddColumn('Wave')
	enemy_list:AddColumn('Name')
	enemy_list:AddColumn('Class')
	enemy_list:AddColumn('Weight')

	enemy_list.OnClickLine = function(parent, line, selected)
		local enemy = line.enemy
		
		local menu = DermaMenu()
		
		menu:AddOption('Modify', function()
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
		end)
		
		menu:AddOption('Delete', function()
			HORDE.enemies[enemy.name .. tostring(enemy.wave)] = nil
            HORDE.FinalizeEnemies()
		end)

		menu:AddSpacer()
		
		menu:Open()
	end

	self.enemy_list = enemy_list
end

function PANEL:Think()
	local lines = self.enemy_list:GetLines()

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
	Derma_DrawBackgroundBlur(self)

    -- Entire Panel
	surface.SetDrawColor(Color(40, 40, 40, 255))
	surface.DrawRect(0, 0, w, h)

    -- Background
	surface.SetDrawColor(Color(40, 40, 40, 255))
	surface.DrawRect(0, 0, w, 48)

	draw.SimpleText("Enemy Config (Some settings require restarting current game to take effect)", 'Heading', 10, 24, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register('HordeEnemyConfig', PANEL, 'EditablePanel')