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
		label:Dock(LEFT)
		
		if name == "class" then
			local editor = vgui.Create('DComboBox', panel)
			editor:SetSize(200, height)
			editor:DockPadding(10, 10, 10, 10)
			editor:Dock(LEFT)
            local npcs = list.Get("NPC")
            for class, npc in pairs(npcs) do
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
		else
			local editor = vgui.Create('DTextEntry', panel)
			editor:SetSize(200, height)
			editor:DockPadding(10, 10, 10, 10)
			editor:Dock(LEFT)
			return editor
		end
	end

	local class_editor = create_property_editor("class", 50)
	local weight_editor = create_property_editor("weight", 50)
    local wave_editor = create_property_editor("wave", 50)

	weight_editor:SetNumeric(true)

	local save_btn = vgui.Create('DButton', modify_tab)
	save_btn:Dock(BOTTOM)
	save_btn:SetText("Save")
	save_btn.DoClick = function ()
		HORDE.CreateEnemy(
			class_editor:GetText(),
			tonumber(weight_editor:GetText()),
            tonumber(wave_editor:GetText())
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
	enemy_list:AddColumn('Class')
	enemy_list:AddColumn('Weight')
	enemy_list:AddColumn('Wave')

	enemy_list.OnClickLine = function(parent, line, selected)
		local enemy = line.enemy
		
		local menu = DermaMenu()
		
		menu:AddOption('Modify', function()
			class_editor:SetValue(enemy.class)
			weight_editor:SetValue(enemy.weight)
			wave_editor:SetValue(enemy.wave)
		end)
		
		menu:AddOption('Delete', function()
			HORDE.enemies[tostring(enemy.class) .. tostring(enemy.weight)] = nil
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
			self.enemy_list:AddLine(enemy.class, enemy.weight, enemy.wave).enemy = enemy
		end
	end

	for i, line in pairs(lines) do
		if table.HasValue(HORDE.enemies, line.enemy) then
			local enemy = line.enemy
				
			line:SetValue(1, enemy.class)
			line:SetValue(2, enemy.weight)
			line:SetValue(3, enemy.wave)
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