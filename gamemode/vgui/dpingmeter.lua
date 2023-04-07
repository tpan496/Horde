local PANEL = {}

PANEL.IdealPing = 50
PANEL.MaxPing = 450
PANEL.RefreshTime = 1
PANEL.PingBars = 5

PANEL.m_Player = NULL
PANEL.m_Ping = 0
PANEL.NextRefresh = 0

local math_Clamp = math.Clamp
local math_max = math.max
local RealTime = RealTime

local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local draw_SimpleText = draw.SimpleText

function PANEL:Init()
end

local colPing = Color(255, 255, 60, 255)
function PANEL:Paint()
	local ping = self:GetPing()
	local pingmul = 1 - math_Clamp((ping - self.IdealPing) / self.MaxPing, 0, 1)
	local wid, hei = self:GetWide(), self:GetTall()
	local pingbars = math_max(1, self.PingBars)
	local barwidth = wid / pingbars
	local baseheight = hei / pingbars

	colPing.r = (1 - pingmul) * 255
	colPing.g = pingmul * 255

	surface_SetDrawColor(20,20,20,150)
	surface_DrawRect(0 + 33, 0, wid * 0.15, hei)

	for i=1, pingbars do
		local barheight = baseheight * i
		local x, y = 0, hei - barheight

		if i == 1 or pingmul >= i / pingbars then
			surface.SetDrawColor(colPing)
			surface.DrawRect(x + 33, y, barwidth * 0.7, barheight)
		end

	end

	draw_SimpleText(ping, "Content", 15, 7, colPing, TEXT_ALIGN_CENTER, 0)

	return true
end

function PANEL:Refresh()
	local pl = self:GetPlayer()
	if pl:IsValid() then
		self:SetPing(pl:Ping())
	else
		self:SetPing(0)
	end
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:Refresh()
	end
end

function PANEL:SetPlayer(pl)
	self.m_Player = pl or NULL
	self:Refresh()
end

function PANEL:GetPlayer()
	return self.m_Player
end

function PANEL:SetPing(ping)
	self.m_Ping = ping
end

function PANEL:GetPing()
	return self.m_Ping
end

vgui.Register("DPingMeter", PANEL, "Panel")
