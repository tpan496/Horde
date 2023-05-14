local PANEL = {}

-- Copied from ArcCW
local function multlinetext(text, maxw, font)
    local content = ""
    local tline = ""
    local x = 0
    surface.SetFont(font)

    local newlined = string.Split(text, "\n")

    for _, line in pairs(newlined) do
        local words = string.Split(line, " ")

        for _, word in pairs(words) do
            local tx = surface.GetTextSize(word)

            if x + tx >= maxw then
                content = content .. "\n" .. tline
                tline = ""
                x = surface.GetTextSize(word)
            end

            tline = tline .. word .. " "

            x = x + surface.GetTextSize(word .. " ")
        end

        content = content .. "\n" .. tline
        tline = ""
        x = 0
    end
    return content
end

function PANEL:add_infusion(infusion, price)
    local infusion_item = self.infusion_layout:Add("DPanel")
    infusion_item:SetSize((self.infusion_scroll:GetWide() - 24) / 2, 40)
    infusion_item:SetText("")
    infusion_item:SetMouseInputEnabled(true)
    infusion_item:SetCursor("hand")
    infusion_item.bg_color = Color(50, 50, 50, 255)
    infusion_item.Paint = function ()
        if infusion_item.set_active == true then
            infusion_item.bg_color = Color(100, 100, 100, 255)
        else
            infusion_item.bg_color = Color(50, 50, 50, 255)
        end
        surface.SetDrawColor(infusion_item.bg_color)
        surface.DrawRect(0, 0, (self.infusion_scroll:GetWide() - 24) / 2, 40)

        surface.SetTextColor(Color(255,255,255))
        surface.SetFont("Item")
        surface.SetTextPos(50, 10)
        surface.DrawText(translate.Get("Infusion_" .. HORDE.Infusion_Names[infusion]) or HORDE.Infusion_Names[infusion])

        local has_infusion = MySelf:Horde_HasInfusion(self.item.class, infusion)
        --if has_infusion then
            --surface.SetDrawColor(Color(255,255,255))
            --surface.DrawOutlinedRect(0, 0, (self.infusion_scroll:GetWide() - 24) / 2, 40, 2)
        --end

        if has_infusion then
            draw.SimpleText("INFUSED", "Item", (self.infusion_scroll:GetWide() - 20) / 2 - 50, 10, HORDE.color_crimson, TEXT_ALIGN_CENTER, TEXT_ALIGN_RIGHT)
        else
            draw.SimpleText(tostring(price) .. "$", "Item", (self.infusion_scroll:GetWide() - 20) / 2 - 30, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_RIGHT) 
        end

        surface.SetDrawColor(HORDE.Infusion_Colors[infusion])
        local mat = Material("infusion/infusion.png", "mips smooth")
        surface.SetMaterial(mat)
        surface.DrawTexturedRect(7, 4, 35, 35)

        if infusion ~= HORDE.Infusion_None then
            mat = Material(HORDE.Infusion_Icons[infusion], "mips smooth")
            surface.SetMaterial(mat)
            surface.DrawTexturedRect(12, 8, 25, 25)
        end
    end
    infusion_item.OnCursorEntered = function ()
        infusion_item.bg_color = Color(100, 100, 100, 200)
        surface.PlaySound("UI/buttonrollover.wav")
    end

    infusion_item.OnCursorExited = function ()
        infusion_item.bg_color = Color(50, 50, 50, 200)
    end

    local p = self
    function infusion_item:OnMousePressed()
        surface.PlaySound("UI/buttonclick.wav")
        p.infusion = infusion

        for k, v in pairs(p.infusion_items) do
            v.set_active = false
        end
        self.set_active = true
    end

    table.insert(self.infusion_items, infusion_item)
end

function PANEL:Init()
    self.infusion_items = {}
    self.infusion = HORDE.Infusion_None

    self.infusion_scroll = vgui.Create("DScrollPanel", self)
    self.infusion_scroll:Dock(TOP)
    self.infusion_scroll:DockMargin(10, 10, 10, 10)
    if ScrW() <= 1600 or ScrH() < 1080 then
        self.infusion_scroll:SetSize(ScrW() / 4, ScrH() / 2)
    else
        self.infusion_scroll:SetSize(ScrW() / 1.25 / 2, ScrH() / 1.5 / 2)
    end
    
    self.infusion_scroll.Paint = function () end

    self.infusion_layout = vgui.Create("DIconLayout", self.infusion_scroll)
    self.infusion_layout:Dock(FILL)
    self.infusion_layout:SetSpaceX(2.5)
    self.infusion_layout:SetSpaceY(5)
    self.infusion_layout.Paint = function () end

    self.infusion_description = vgui.Create("DPanel", self)
    self.infusion_description:Dock(TOP)
    self.infusion_description:DockMargin(5,2.5,5,2.5)
    if ScrW() <= 1600 or ScrH() < 1080 then
        self.infusion_description:SetTall(ScrH() / 2 - 55)
    else
        self.infusion_description:SetTall(ScrH() / 1.5 / 2 - 55)
    end
    local p = self

    self.remove_infuse_btn = vgui.Create("DButton", self)
    self.remove_infuse_btn:Dock(BOTTOM)
    self.remove_infuse_btn:DockMargin(5,2.5,5,2.5)
    self.remove_infuse_btn:SetFont("Content")
    self.remove_infuse_btn:SetTextColor(Color(255,255,255))
    self.remove_infuse_btn:SetText("Remove Infusion")
    self.remove_infuse_btn:SetTall(50)
    self.remove_infuse_btn.Paint = function () end
    self.remove_infuse_btn:SetZPos(100)
    self.remove_infuse_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    function self.remove_infuse_btn:DoClick()
        surface.PlaySound("UI/buttonclick.wav")
        net.Start("Horde_SellInfusion")
            net.WriteString(p.item.class)
        net.SendToServer()
    end

    self.infuse_btn = vgui.Create("DButton", self)
    self.infuse_btn:Dock(BOTTOM)
    self.infuse_btn:DockMargin(5,2.5,5,2.5)
    self.infuse_btn:SetFont("Content")
    self.infuse_btn:SetTextColor(Color(255,255,255))
    self.infuse_btn:SetText("Infuse")
    self.infuse_btn:SetTall(50)
    self.infuse_btn.Paint = function () end
    self.infuse_btn:SetZPos(100)
    self.infuse_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    function self.infuse_btn:DoClick()
        if p.infusion == HORDE.Infusion_None then return end
        local price = 100 + p.item.price / 5
        if (MySelf:Horde_GetMoney() < price) or (MySelf:Horde_HasInfusion(p.item.class, p.infusion) == true)  then return end
        surface.PlaySound("UI/buttonclick.wav")
        net.Start("Horde_BuyInfusion")
            net.WriteString(p.item.class)
            net.WriteUInt(p.infusion, 5)
        net.SendToServer()
    end
end

function PANEL:SetData(item)
    self.item = item
    if MySelf.Horde_Infusions and MySelf.Horde_Infusions[item.class] then
        self.infusion = MySelf.Horde_Infusions[item.class]
    else
        self.infusion = HORDE.Infusion_None
    end
    self.infusion_scroll:Remove()
    self.infusion_scroll = vgui.Create("DScrollPanel", self)
    self.infusion_scroll:Dock(TOP)
    self.infusion_scroll:DockMargin(10, 10, 10, 10)
    if ScrW() <= 1600 or ScrH() < 1080 then
        self.infusion_scroll:SetSize(ScrW() / 4, ScrH() / 2)
    else
        self.infusion_scroll:SetSize(ScrW() / 1.25 / 2, ScrH() / 1.5 / 2)
    end
    
    self.infusion_scroll.Paint = function () end
    self.infusion_layout:Clear()
    self.infusion_layout:Remove()
    self.infusion_layout = vgui.Create("DIconLayout", self.infusion_scroll)
    self.infusion_layout:Dock(FILL)
    self.infusion_layout:SetSpaceX(2.5)
    self.infusion_layout:SetSpaceY(5)
    self.infusion_layout.Paint = function () end

    self.infusion_description:Remove()
    self.infusion_description = vgui.Create("DPanel", self)
    self.infusion_description:Dock(TOP)
    self.infusion_description:DockMargin(5,2.5,5,2.5)
    if ScrW() <= 1600 or ScrH() < 1080 then
        self.infusion_description:SetTall(ScrH() / 2 - 55)
    else
        self.infusion_description:SetTall(ScrH() / 1.5 / 2 - 55)
    end

    self.infusion_items = {}

    if not item.infusions or table.IsEmpty(item.infusions) then return end
    
    for _, infusion in SortedPairsByValue(item.infusions) do
        --if MySelf:Horde_GetClass().infusions[infusion] then
            self:add_infusion(infusion, 100 + item.price / 5)
        --end
    end
end

function PANEL:Paint()
    surface.SetDrawColor(HORDE.color_hollow)
    surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    local price = 100 + self.item.price / 5
    if self.item then
        local infusion = self.infusion
        if MySelf:Horde_HasInfusion(self.item.class, infusion) == true then
            self.infuse_btn:SetText(translate.Get("Game_Infused"))
            self.infuse_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end
        elseif MySelf:Horde_GetMoney() < price  then
            self.infuse_btn:SetText("Not enough money (Need " .. tostring(price) .. "$)")
            self.infuse_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end
        elseif infusion == HORDE.Infusion_None then
            self.infuse_btn:SetText("No infusion selected.")
            self.infuse_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end
        else
            self.infuse_btn:SetText("Apply " .. HORDE.Infusion_Names[infusion] .. " infusion to " .. self.item.name .. " (" .. tostring(price) .. "$)")
            self.infuse_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end
        end

        if MySelf:Horde_GetInfusion(self.item.class) ~= HORDE.Infusion_None then
            self.remove_infuse_btn:SetVisible(true)
            self.remove_infuse_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end
        else
            self.remove_infuse_btn:SetVisible(false)
        end

        self.infusion_description.Paint = function ()
            draw.DrawText(translate.Get("Infusion_Description_" .. HORDE.Infusion_Names[infusion]) or HORDE.Infusion_Description[infusion], "Content", 50, 0, Color(200, 200, 200), TEXT_ALIGN_LEFT)
        end
    end
end

vgui.Register("HordeInfusion", PANEL, "DPanel")