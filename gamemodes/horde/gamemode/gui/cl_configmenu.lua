local PANEL = {}

function PANEL:Init()
    self:SetSize(256, 400)
    self:SetPos((ScrW() / 2) - (self:GetWide() / 2), (ScrH() / 2) - (self:GetTall() / 2))
    self:MakePopup()

    local close_btn = vgui.Create("DButton", self)
    close_btn:SetFont("marlett")
    close_btn:SetText("r")
    close_btn.Paint = function() end
    close_btn:SetColor(Color(255, 255, 255))
    close_btn:SetSize(32, 32)
    close_btn:SetPos(self:GetWide() - 40, 5)

    close_btn.DoClick = function()
        HORDE:ToggleConfigMenu()
    end


    local itemconfig = vgui.Create("DButton", self)
    itemconfig:SetSize(500, 64)
    itemconfig:Dock(TOP)
    itemconfig:DockMargin(10, 48, 10, 0)
    itemconfig:SetText("Item Config")
    itemconfig:SetFont("Heading")
    itemconfig.DoClick = function()
        RunConsoleCommand("horde_item_config")
        HORDE:ToggleConfigMenu()
    end

    local enemyconfig = vgui.Create("DButton", self)
    enemyconfig:SetSize(700, 64)
    enemyconfig:Dock(TOP)
    enemyconfig:DockMargin(10, 4, 10, 0)
    enemyconfig:SetText("Enemy Config")
    enemyconfig:SetFont("Heading")
    enemyconfig.DoClick = function()
        RunConsoleCommand("horde_enemy_config")
        HORDE:ToggleConfigMenu()
    end

    local classconfig = vgui.Create("DButton", self)
    classconfig:SetSize(700, 64)
    classconfig:Dock(TOP)
    classconfig:DockMargin(10, 4, 10, 0)
    classconfig:SetText("Class Config")
    classconfig:SetFont("Heading")
    classconfig.DoClick = function()
        RunConsoleCommand("horde_class_config")
        HORDE:ToggleConfigMenu()
    end

    local mapconfig = vgui.Create("DButton", self)
    mapconfig:SetSize(700, 64)
    mapconfig:Dock(TOP)
    mapconfig:DockMargin(10, 4, 10, 0)
    mapconfig:SetText("Map Config")
    mapconfig:SetFont("Heading")
    mapconfig.DoClick = function()
        RunConsoleCommand("horde_map_config")
        HORDE:ToggleConfigMenu()
    end

    local stats = vgui.Create("DButton", self)
    stats:SetSize(700, 64)
    stats:Dock(TOP)
    stats:DockMargin(10, 4, 10, 0)
    stats:SetText("Player Info")
    stats:SetFont("Heading")
    stats.DoClick = function()
        RunConsoleCommand("horde_stats")
        HORDE:ToggleConfigMenu()
    end
end

function PANEL:Paint(w, h)
    -- Derma_DrawBackgroundBlur(self)

    -- Entire Panel
    surface.SetDrawColor(HORDE.color_config_bar)
    surface.DrawRect(0, 0, w, h)

    -- Background
    surface.SetDrawColor(HORDE.color_config_bar)
    surface.DrawRect(0, 0, w, 40)

    draw.SimpleText("Configuration Menu", "Trebuchet24", 10, 22, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("HordeConfigMenu", PANEL, "Panel")