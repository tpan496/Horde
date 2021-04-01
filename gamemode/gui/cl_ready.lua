surface.CreateFont("Content", { font = "arial bold", size = 20 })

local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() / 2, 100)
	self:SetPos(ScrW() / 2 - (self:GetWide() / 2), 25)
    self:SetBackgroundColor(Color(0,0,0,0))
end

function PANEL:ResetReadyPanel()
    if self.ready_layout then self.ready_layout:Remove() end
    self.ready_layout = vgui.Create("DIconLayout", self)
    self.ready_layout:Dock(FILL)
    self.ready_layout:SetBorder(5)
    self.ready_layout:SetSpaceX(5)
    self.ready_layout:SetSpaceY(5)
end

function PANEL:CreateReadyPanel(ply, status)
    local panel = vgui.Create("DPanel")
    self.ready_layout:Add(panel)
    panel:SetSize(230,32)
    panel:SetBackgroundColor(HORDE.color_hollow)
    local avatar = vgui.Create("AvatarImage", panel)
    avatar:Dock(LEFT)
    avatar:SetSize(32,32)
    avatar:SetPlayer(ply, 32)
    local name_label = vgui.Create("DPanel", panel)
    name_label:Dock(LEFT)
    name_label:SetSize(130-32,32)
    name_label.Paint = function ()
        if not ply:IsValid() then return end
        draw.SimpleText(ply:GetName(), "Content", 10, 8, Color(255,255,255))
    end

    local status_label = vgui.Create("DPanel", panel)
    status_label:SetSize(90,32)
    status_label:Dock(RIGHT)
    status_label.Paint = function ()
        if status == 0 then
            draw.SimpleText("Not Ready", "Content", 0, 8, Color(255,255,255))
        else
            draw.SimpleText("    Ready", "Content", 0, 8, HORDE.color_crimson)
        end
    end
end

function PANEL:Paint(w,h)
    -- Entire Panel
	draw.RoundedBox(10, 0, 0, w, h, HORDE.color_hollow)
end

vgui.Register("HordePlayerReadyPanel", PANEL, "DPanel")

HORDE.PlayerReadyPanel = vgui.Create("HordePlayerReadyPanel")
HORDE.HelpPanel = vgui.Create("DPanel")
HORDE.HelpPanel:SetSize(300, 50)
HORDE.HelpPanel:SetPos(ScrW() / 2 - 150, ScrH() - 75)
HORDE.HelpPanel.Paint = function (w,h)
    draw.RoundedBox(10, 0, 0, 300, 50, HORDE.color_hollow)
    draw.SimpleText("F3 - Shop/Perk, F4 - Ready", "Trebuchet24", 26, 12, HORDE.color_white)
end

net.Receive("Horde_PlayerReadySync", function ()
    HORDE.player_ready = net.ReadTable()
    -- Lua sorting is just fucking retarded. Doing this on my own.
    local ready_players = {}
    local unready_players = {}
    for ply, status in pairs(HORDE.player_ready) do
        if ply:IsValid() then
            if status == 1 then
                table.insert(ready_players, ply)
            else
                table.insert(unready_players, ply)
            end
        end
    end

    if not HORDE.PlayerReadyPanel:IsValid() then return end
    HORDE.PlayerReadyPanel:ResetReadyPanel()
    for _, ply in pairs(unready_players) do
        if ply:IsValid() then
            HORDE.PlayerReadyPanel:CreateReadyPanel(ply, 0)
        end
    end
    for _, ply in pairs(ready_players) do
        if ply:IsValid() then
            HORDE.PlayerReadyPanel:CreateReadyPanel(ply, 1)
        end
    end
end)

net.Receive("Horde_RemoveReadyPanel", function()
    if HORDE.PlayerReadyPanel then
        HORDE.PlayerReadyPanel:Remove()
        HORDE.HelpPanel:SetVisible(false)
    end
end)