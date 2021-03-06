if SERVER then return end

surface.CreateFont("Item", { font = 'arial bold', size = 20 })

local PANEL = {}

function PANEL:Init()
	self.name = ""
	self.bg_color = Color(50,50,50, 200)
	self.bg_color_poor = Color(30,30,30, 200)
	self.text_color = Color(255,255,255)
	self.text_color_poor = Color(100,0,0)
end

function PANEL:DoClick()
	self.description_panel:SetData(self.item)
end

function PANEL:OnCursorEntered()
	self.bg_color = Color(100, 100, 100, 200)
end

function PANEL:OnCursorExited()
	self.bg_color = Color(50,50,50, 200)
end

function PANEL:SetData(item, description_panel)
	self.item = item
	self.name = item.name
	self.description = item.description
	self.weight = item.weight
	self.price = item.price
	self.description_panel = description_panel

	local btn = vgui.Create("DButton", self)
	btn:Dock(FILL)
	btn:SetText("")
	btn.Paint = function ()
		surface.SetDrawColor(Color(0, 0, 0, 0))
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	end

	function btn:DoClick()
		self:GetParent():DoClick()
		surface.PlaySound("UI/buttonclick.wav")
	end

	function btn:OnCursorEntered()
		self:GetParent():OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")
	end

	function btn:OnCursorExited()
		self:GetParent():OnCursorExited()
	end

	self.buy_btn = btn

	local weight_panel = vgui.Create("DLabel", self)
	weight_panel:Dock(RIGHT)
	weight_panel:SetSize(50, weight_panel:GetTall())
	weight_panel:SetFont("Item")
	weight_panel:SetText("[" .. tostring(self.weight) .."]")
	self.weight_panel = weight_panel

	local price_panel = vgui.Create("DLabel", self)
	price_panel:Dock(RIGHT)
	price_panel:SetSize(80, price_panel:GetTall())
	price_panel:SetFont("Item")
	self.price_panel = price_panel
end

function PANEL:Paint()
	if self.item ~= nil then
		local is_rich = LocalPlayer():GetHordeMoney() >= self.item.price and LocalPlayer():GetHordeWeight() >= self.item.weight
		surface.SetDrawColor(self.bg_color)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
		surface.SetFont("Item")

		if LocalPlayer():HasWeapon(self.item.class) then
			self.price_panel:SetTextColor(HORDE.color_crimson)
			self.price_panel:SetText("Owned")
		else
			if is_rich then
				surface.SetTextColor(self.text_color)
				self.weight_panel:SetTextColor(self.text_color)
				self.price_panel:SetTextColor(self.text_color)
			else
				surface.SetTextColor(self.text_color_poor)
				self.weight_panel:SetTextColor(self.text_color_poor)
				self.price_panel:SetTextColor(self.text_color_poor)
			end
			self.price_panel:SetText(tostring(self.price) .. "$")
		end

		surface.SetTextColor(Color(255,255,255))
		surface.SetTextPos(10, self:GetTall() / 2 - 10)
		surface.DrawText(self.name)

		if self.item.entity_properties and self.item.entity_properties.is_arccw_attachment and ArcCW.AttachmentTable[self.item.class] then
			local icon = ArcCW.AttachmentTable[self.item.class].Icon
			if icon then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(icon)
				surface.DrawTexturedRect(self:GetWide() - 64, -10, 60, 60)
			end
			self.weight_panel:SetVisible(false)
		else
			self.weight_panel:SetVisible(true)
		end
	end
end

vgui.Register("HordeShopItem", PANEL, "DPanel")