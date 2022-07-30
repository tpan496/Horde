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
        draw.SimpleText(ply:GetName(), "Content", 10, 6, Color(255,255,255))
    end

    local status_label = vgui.Create("DPanel", panel)
    status_label:SetSize(90,32)
    status_label:Dock(RIGHT)
    status_label.Paint = function ()
        if status == 0 then
            draw.SimpleText(translate.Get("Game_Not Ready"), "Content", 0, 6, Color(255,255,255))
        else
            draw.SimpleText("    " .. translate.Get("Game_Ready"), "Content", 0, 6, HORDE.color_crimson)
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
HORDE.HelpPanel:SetSize(500, 50)
HORDE.HelpPanel:SetPos(ScrW() / 2 - 250, ScrH() - 75)
HORDE.HelpPanel.Paint = function (w,h)
    if HORDE.current_wave > 0 then
        local text = translate.Get("Game_HintBottom")
        if not text or not surface.GetTextSize(text) then return end
        local len = math.min(500, surface.GetTextSize(text) * 1.5)
        draw.RoundedBox(10, math.max(0, 250 - len/2), 0, len, 50, HORDE.color_hollow)
        draw.SimpleText(text, "Info", math.max(0, 200 - len/2) + len / 2, 13, HORDE.color_white, TEXT_ALIGN_CENTER)
    else
        local text = translate.Get("Game_HintBottomReady")
        if not text  or not surface.GetTextSize(text) then return end
        local len = math.min(500, surface.GetTextSize(text) * 1.5)
        draw.RoundedBox(10, math.max(0, 250 - len/2), 0, len, 50, HORDE.color_hollow)
        draw.SimpleText(text, "Info", math.max(0, 200 - len/2) + len / 2, 13, HORDE.color_white, TEXT_ALIGN_CENTER)
    end
end

local tip = ""
HORDE.TipPanel = vgui.Create("DPanel")
HORDE.TipPanel:SetSize(ScrW() * 2 / 5, 50)
HORDE.TipPanel:SetPos(ScrW() / 2 - ScrW() * 2 / 5 / 2, 25)
HORDE.TipPanel.Paint = function (w,h)
    if tip == nil or tip == "" then return end
    draw.RoundedBox(10, 0, 0, ScrW() * 2 / 5, 50,  Color(40,40,40,200))
    draw.DrawText(translate.Format("Game_Tip_X", translate.Get("Tip_" .. tip) or tip), "Info", ScrW() * 2 / 5 / 2, 13, HORDE.color_white, TEXT_ALIGN_CENTER)
end

net.Receive("Horde_SyncTip", function()
    tip = net.ReadString()
    if tip == "" or tip == nil then
        HORDE.TipPanel:SetVisible(false)
    else
        HORDE.TipPanel:SetVisible(true)
    end
end)

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
