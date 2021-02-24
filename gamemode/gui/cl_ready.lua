if SERVER then return end

surface.CreateFont('Content', { font = 'arial bold', size = 20 })

local PANEL = {}
local ready_panels = {}

function PANEL:Init()
    self:SetSize(1024, 100)
	self:SetPos(ScrW() / 2 - (self:GetWide() / 2), 25)
    self:SetBackgroundColor(Color(0,0,0,0))

    local scroll_panel = vgui.Create('DScrollPanel', self)
    scroll_panel:Dock(FILL)

    local ready_layout = vgui.Create('DIconLayout', scroll_panel)
    ready_layout:Dock(FILL)
    ready_layout:SetBorder(5)
    ready_layout:SetSpaceX(5)
    ready_layout:SetSpaceY(5)
    self.ready_layout = ready_layout
end

function PANEL:CreateReadyPanel(ply, status)
    local panel = vgui.Create('DPanel')
    self.ready_layout:Add(panel)
    print("create", ply)
    panel:SetSize(200,50)
    local avatar = vgui.Create('AvatarImage', panel)
    avatar:Dock(LEFT)
    avatar:SetSize(16,16)
    avatar:SetPlayer(ply, 16)
    local label = vgui.Create('Panel', panel)
    label:Dock(LEFT)
    label.Paint = function ()
        if status then
            draw.SimpleText("Not Ready", "Content", 0, 20, Color(255,255,255))
        else
            draw.SimpleText("Ready", "Content", 0, 20, HORDE.color_crimson)
        end
    end
end

function PANEL:Paint(w,h)
    -- Entire Panel
	draw.RoundedBox(10, 0, 0, w, h, HORDE.color_hollow)
end

vgui.Register('HordePlayerReadyPanel', PANEL, 'DPanel')


HORDE.PlayerReadyPanel = vgui.Create('HordePlayerReadyPanel')
HORDE.PlayerReadyPanel:SetVisible(true)

net.Receive("Horde_PlayerReadySync", function ()
    HORDE.player_ready = net.ReadTable()
    PrintTable(HORDE.player_ready)
    for _, panel in pairs(ready_panels) do
        panel:Remove()
    end
    for ply, status in pairs(HORDE.player_ready) do
        HORDE.PlayerReadyPanel:CreateReadyPanel(ply, status)
    end
end)