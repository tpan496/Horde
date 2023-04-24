local PANEL = {}

function PANEL:Init()
    self:SetSize(ScrW() / 2, ScreenScale(35))
	self:SetPos(ScrW() / 2 - (self:GetWide() / 2), ScreenScale(6))
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
    panel:SetSize(ScreenScale(230/4),ScreenScale(8))
    panel:SetBackgroundColor(HORDE.color_hollow)
    local avatar = vgui.Create("AvatarImage", panel)
    avatar:Dock(LEFT)
    avatar:SetSize(ScreenScale(8),ScreenScale(8))
    avatar:SetPlayer(ply, 32)
    local name_label = vgui.Create("DPanel", panel)
    name_label:Dock(LEFT)
    name_label:SetSize(ScreenScale(130-32)/4,ScreenScale(8))
    name_label.Paint = function ()
        if not ply:IsValid() then return end
        draw.SimpleText(ply:GetName(), "Horde_Ready", ScreenScale(2.5), ScreenScale(1.5), Color(255,255,255))
    end

    local status_label = vgui.Create("DPanel", panel)
    status_label:SetSize(ScreenScale(22.5), ScreenScale(8))
    status_label:Dock(RIGHT)
    status_label.Paint = function ()
        if status == 0 then
            draw.SimpleText(translate.Get("Game_Not Ready"), "Horde_Ready", 0, ScreenScale(1.5), Color(255,255,255))
        else
            draw.SimpleText("    " .. translate.Get("Game_Ready"), "Horde_Ready", 0, ScreenScale(1.5), HORDE.color_crimson)
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
HORDE.HelpPanel:SetSize(ScreenScale(250), ScreenScale(15))
HORDE.HelpPanel:SetPos(ScrW() / 2 - ScreenScale(250) / 2, ScrH() - ScreenScale(75/4))
HORDE.HelpPanel.Paint = function (w,h)
    if HORDE.current_wave > 0 then
        local text = translate.Get("Game_HintBottom")
        if not text or not surface.GetTextSize(text) then return end
        draw.SimpleText(text, "Info", ScreenScale(250)/2, ScreenScale(13)/4, HORDE.color_white, TEXT_ALIGN_CENTER)
    else
        local text = translate.Get("Game_HintBottomReady")
        if not text  or not surface.GetTextSize(text) then return end
        draw.SimpleText(text, "Info", ScreenScale(250) / 2, ScreenScale(13)/4, HORDE.color_white, TEXT_ALIGN_CENTER)
    end
end

local tip = ""
HORDE.TipPanel = vgui.Create("DPanel")
HORDE.TipPanel:SetSize(ScrW() * 2 / 5, ScreenScale(15))
HORDE.TipPanel:SetPos(ScrW() / 2 - ScrW() * 2 / 10, ScreenScale(6))
HORDE.TipPanel.Paint = function (w,h)
    if tip == nil or tip == "" then return end
    draw.RoundedBox(10, 0, 0, ScrW() * 2 / 5, ScreenScale(15),  Color(40,40,40,200))
    draw.DrawText("Tip: " .. tip, "Info", ScrW() * 2 / 10, ScreenScale(13/4), HORDE.color_white, TEXT_ALIGN_CENTER)
end

net.Receive("Horde_SyncTip", function()
    tip = net.ReadString()
    if tip == "" or tip == nil then
        HORDE.TipPanel:SetVisible(false)
    else
        HORDE.TipPanel:SetVisible(true)
        HORDE:ShowLeaderboardThenFadeOut()
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
