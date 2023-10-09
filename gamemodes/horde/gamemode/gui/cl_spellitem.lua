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
    self.description_panel:SetVisible(true)
end

function PANEL:OnCursorEntered()
    self.bg_color = Color(100, 100, 100, 200)
end

function PANEL:OnCursorExited()
    self.bg_color = Color(50,50,50, 200)
end

function PANEL:SetData(item, description_panel)
    self.item = item
    self.name = item.PrintName
    self.loc_name = translate.Get("Spell_" .. self.name) or self.name
    self.icon = Material(item.Icon, "mips smooth")

    if self.item.Upgrades then
        self.loc_name = self.loc_name .. " +" .. tostring(MySelf:Horde_GetSpellUpgrade(self.item.ClassName))
    end

    self.description = item.Description
    self.price = item.Price or 0
    self.skull_tokens = item.skull_tokens or 0
    self.description_panel = description_panel
    self.player_class = MySelf:Horde_GetClass().name

    self.level_satisfy = true
    if self.item.Levels then
        for class, level in pairs(self.item.Levels) do
            if MySelf:Horde_GetLevel(class) < level then
                self.level_satisfy = false
                break
            end
        end
    end

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

    local price_panel = vgui.Create("DLabel", self)
    price_panel:Dock(RIGHT)
    price_panel:SetSize(80, price_panel:GetTall())
    price_panel:SetFont("Item")
    price_panel:SetContentAlignment(6)
    self.price_panel = price_panel
end

function PANEL:Paint()
    if self.item ~= nil then
        local is_rich = MySelf:Horde_GetMoney() >= (self.item.Price or 0)
        surface.SetDrawColor(self.bg_color)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        surface.SetFont("Item")

        if MySelf:Horde_HasSpell(self.item.ClassName) == true then
            self.price_panel:SetTextColor(HORDE.color_crimson)
            self.price_panel:SetText("Owned")
        else
            if is_rich then
                surface.SetTextColor(self.text_color)
                self.price_panel:SetTextColor(self.text_color)
            else
                surface.SetTextColor(self.text_color_poor)
                self.price_panel:SetTextColor(self.text_color_poor)
            end
            self.price_panel:SetText(tostring(self.price) .. "$   ")
        end

        if (MySelf:Horde_HasSpell(self.item.ClassName) == false) and (not self.level_satisfy) then
            surface.SetTextColor(Color(80,80,80))
        else
            surface.SetTextColor(Color(255,255,255))
        end
        surface.SetTextPos(10, self:GetTall() / 2 - 10)
        surface.DrawText(self.loc_name)
        surface.SetDrawColor(255, 255, 255, 255)

        if self.icon then
            surface.SetMaterial(self.icon)
            surface.DrawTexturedRect(self:GetWide() - 128, 0, 40, 40)
        end
    end
end

vgui.Register("HordeShopSpellItem", PANEL, "DPanel")