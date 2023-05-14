local PANEL = {}
PANEL.m_Team = 0
PANEL.NextRefresh = 0
PANEL.RefreshTime = 2

function PANEL:Init()

    self.m_HeaderPanel = vgui.Create("DPanel", self)
    self.m_HeaderPanel:SetPaintBackground(false)

    self.ClassPanel = self.m_HeaderPanel:Add("DPanel")

	self.m_NameLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
	self.m_ClassLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
    self.m_GadgetLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
    self.m_PerksLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
    self.m_MoneyLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
    self.m_KillsLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
    self.m_DeathsLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)
    self.m_PingLabel = HORDE:EasyLabel(self.m_HeaderPanel, " ", "Content", color_white)

	self:InvalidateLayout()
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:RefreshContents()
	end
end

function PANEL:PerformLayout()

    local w = self:GetWide()
	local h = self:GetTall()

    self.m_HeaderPanel:SetSize(w, h)

	self.m_NameLabel:AlignLeft(w * 0.05)
    self.m_NameLabel:CenterVertical()
    self.m_NameLabel:SizeToContents()

    self.ClassPanel:SetSize(32,32)
    self.ClassPanel:AlignLeft(w * 0.15)
    self.ClassPanel:CenterVertical()
    self.ClassPanel:SizeToContents()
    self.ClassPanel:SetPaintBackground(false)
	self.ClassPanel:SetMouseInputEnabled(false)

	self.m_ClassLabel:AlignLeft(w * 0.25)
	self.m_ClassLabel:CenterVertical()
    self.m_ClassLabel:SizeToContents()

    self.m_PerksLabel:AlignLeft(w * 0.36)
	self.m_PerksLabel:CenterVertical()
    self.m_PerksLabel:SizeToContents()

    self.m_GadgetLabel:AlignLeft(w * 0.54)
	self.m_GadgetLabel:CenterVertical()
    self.m_GadgetLabel:SizeToContents()

    self.m_MoneyLabel:AlignRight(w * 0.26)
	self.m_MoneyLabel:CenterVertical()
    self.m_MoneyLabel:SizeToContents()

    self.m_KillsLabel:AlignRight(w * 0.18, 0)
	self.m_KillsLabel:CenterVertical()
    self.m_KillsLabel:SizeToContents()

    self.m_DeathsLabel:AlignRight(w * 0.1, 0)
	self.m_DeathsLabel:CenterVertical()
    self.m_DeathsLabel:SizeToContents()

    self.m_PingLabel:AlignRight(w * 0.0275)
	self.m_PingLabel:CenterVertical()
    self.m_PingLabel:SizeToContents()

end

function PANEL:RefreshContents()

    local w = self:GetWide()

	self.m_NameLabel:SetText( translate.Get("Scoreboard_Name"))
    self.m_NameLabel:SizeToContents()

	self.m_ClassLabel:SetText( translate.Get("Scoreboard_Class") )
    self.m_ClassLabel:SizeToContents()

    self.m_GadgetLabel:SetText( translate.Get("Scoreboard_Gadget") )
    self.m_GadgetLabel:SizeToContents()

    self.m_PerksLabel:SetText( translate.Get("Scoreboard_Perks") )
    self.m_PerksLabel:SizeToContents()

    self.m_MoneyLabel:SetText( translate.Get("Scoreboard_Money") )
    self.m_MoneyLabel:SizeToContents()

    self.m_KillsLabel:SetText( translate.Get("Scoreboard_Kill") )
    self.m_KillsLabel:SizeToContents()

    self.m_DeathsLabel:SetText( translate.Get("Scoreboard_Death") )
    self.m_DeathsLabel:SizeToContents()

    self.m_PingLabel:SetText( translate.Get("Scoreboard_Ping") )
    self.m_PingLabel:SizeToContents()

	self:InvalidateLayout()
end

function PANEL:Paint()
	local wid, hei = self:GetWide(), self:GetTall()

    draw.RoundedBoxEx(8, 0, 0, wid, hei, Color(40,40,40,210), true, true, false, false)

	--surface.SetDrawColor(40,40,40,200)
	--surface.DrawRect(0, 0, wid, hei)

    surface.SetDrawColor(Color(255,255,255))
	surface.DrawRect(0, 42, wid, hei - 42)

	return true
end

vgui.Register("DHeaderPanel", PANEL, "Panel")