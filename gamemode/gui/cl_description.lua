surface.CreateFont("Title", { font = "arial bold", size = 30 })
surface.CreateFont("Warning", { font = "arial bold", size = 30, strikeout = true })
surface.CreateFont("Content", { font = "arial bold", size = 20 })

local PANEL = {}

function PANEL:Init()
    self.description = ""
    self.buy_btn = vgui.Create("DButton", self)
    self.buy_btn:Dock(BOTTOM)
    self.buy_btn:DockMargin(5,2.5,5,2.5)
    self.buy_btn:SetFont("Content")
    self.buy_btn:SetTextColor(Color(0,0,0,0))
    self.buy_btn:SetText("")
    self.buy_btn:SetTall(50)
    self.buy_btn.Paint = function () end
    self.buy_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    self.sell_btn = vgui.Create("DButton", self)
    self.sell_btn:Dock(BOTTOM)
    self.sell_btn:DockMargin(5,2.5,5,2.5)
    self.sell_btn:SetFont("Content")
    self.sell_btn:SetTall(50)
    self.sell_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end
    self.sell_btn:SetVisible(false)

    self.ammo_panel = vgui.Create("DPanel", self)
    self.ammo_panel:Dock(BOTTOM)
    self.ammo_panel:DockMargin(5,2.5,5,2.5)
    self.ammo_panel:SetTall(50)

    self.ammo_one_btn = vgui.Create("DButton", self.ammo_panel)
    self.ammo_one_btn:Dock(LEFT)
    self.ammo_one_btn:DockMargin(0,0,2.5,0)
    self.ammo_one_btn:SetFont("Content")
    self.ammo_one_btn:SetTextColor(Color(0,0,0,0))
    self.ammo_one_btn:SetText("")
    self.ammo_one_btn:SetTall(50)
    self.ammo_one_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    self.ammo_ten_btn = vgui.Create("DButton", self.ammo_panel)
    self.ammo_ten_btn:Dock(LEFT)
    self.ammo_ten_btn:DockMargin(2.5,0,0,0)
    self.ammo_ten_btn:SetFont("Content")
    self.ammo_ten_btn:SetTextColor(Color(0,0,0,0))
    self.ammo_ten_btn:SetText("")
    self.ammo_ten_btn:SetTall(50)
    self.ammo_ten_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    self.ammo_secondary_btn = vgui.Create("DButton", self)
    self.ammo_secondary_btn:Dock(BOTTOM)
    self.ammo_secondary_btn:DockMargin(5,2.5,5,2.5)
    self.ammo_secondary_btn:SetFont("Content")
    self.ammo_secondary_btn:SetTextColor(Color(0,0,0,0))
    self.ammo_secondary_btn:SetText("")
    self.ammo_secondary_btn:SetTall(50)
    self.ammo_secondary_btn.Paint = function () end
    self.ammo_secondary_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end

    self.ammo_panel.Paint = function () end
    self.ammo_one_btn.Paint = function () end
    self.ammo_ten_btn.Paint = function () end

    self.current_ammo_panel = vgui.Create("DPanel", self)
    self.current_ammo_panel:Dock(BOTTOM)
    self.current_ammo_panel:SetTall(50)
    self.current_ammo_panel.Paint = function () end

    function self.buy_btn:DoClick()
        self:GetParent():DoClick()
    end

    function self.ammo_one_btn:DoClick()
        self:GetParent():GetParent():AmmoDoClick(1)
    end

    function self.ammo_ten_btn:DoClick()
        self:GetParent():GetParent():AmmoDoClick(10)
    end

    function self.ammo_secondary_btn:DoClick()
        self:GetParent():AmmoDoClick(-1)
    end

    function self.sell_btn:DoClick()
        self:GetParent():SellDoClick()
    end
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not self.item.class then
        Derma_Query("Changing class will remove all your items!", "Change Class",
            "Yes",
            function()
                net.Start("Horde_SelectClass")
                net.WriteString(self.item.name)
                net.SendToServer()
            end,
            "No", function() end
        )
        --warning_panel:SetFont("Title")
        return
    end
    if LocalPlayer():GetHordeMoney() < self.item.price or LocalPlayer():GetHordeWeight() < self.item.weight then return end
    local drop_entities = LocalPlayer():GetHordeDropEntities()
    if self.item.entity_properties and self.item.entity_properties.limit and self.item.entity_properties.limit > 0 and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP and drop_entities[self.item.class] and drop_entities[self.item.class] >= self.item.entity_properties.limit then return end
    -- Buy the item
    net.Start("Horde_BuyItem")
    net.WriteString(self.item.class)
    net.SendToServer()
end

function PANEL:AmmoDoClick(count)
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if count == -1 then
        -- Secondary ammo
        if self.item.secondary_ammo_price <= 0 or LocalPlayer():GetHordeMoney() < self.item.secondary_ammo_price then return end
        -- Buy the item
        net.Start("Horde_BuyItemAmmoSecondary")
        net.WriteString(self.item.class)
        net.SendToServer()
        return
    end
    local price = self.item.ammo_price and self.item.ammo_price or HORDE.default_ammo_price
    price = price * count
    if LocalPlayer():GetHordeMoney() < price then return end
    -- Buy the item
    net.Start("Horde_BuyItemAmmoPrimary")
    net.WriteString(self.item.class)
    net.WriteInt(count,16)
    net.SendToServer()
end

function PANEL:SellDoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not self.item.class then return end
    if LocalPlayer():HasWeapon(self.item.class) or (self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP) then
        Derma_Query("Sell Item?!", "Sell",
                "Yes",
                function()
                    -- Sell the item
                    net.Start("Horde_SellItem")
                    net.WriteString(self.item.class)
                    net.SendToServer()
                end,
                "No", function() end
            )
    end
end

function PANEL:SetData(item)
    self.item = item
end

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

function PANEL:Paint()
    surface.SetDrawColor(HORDE.color_hollow)
    surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    if self.item then
        if self.item.entity_properties and self.item.entity_properties.is_arccw_attachment then
            local icon = nil
            local description = ""
            local atttbl = ArcCW.AttachmentTable[self.item.class]
            if atttbl.Description then
                description = multlinetext(ArcCW.AttachmentTable[self.item.class].Description, self:GetWide() - 64, "Item")
                -- TODO: This should take two parameters. Second one seems useless?
                local pros, cons = ArcCW:GetProsCons(atttbl)
                description = description .. "\n\n"
                description = description .. "Pros: \n\n"
                for _, pro in pairs(pros) do
                    description = description .. pro .. "\n"
                end
                description = description .. "\n\nCons: \n\n"
                for _, con in pairs(cons) do
                    description = description .. con .. "\n"
                end
                description = description .. "\n\nEquip by Pressing C."
            end
            if atttbl.Icon then 
                icon = ArcCW.AttachmentTable[self.item.class].Icon
                draw.DrawText(self.item.name, "Title", self:GetWide() / 2 - 64, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
                draw.DrawText(description, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                if icon then
                    surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
                    local mat = icon
                    surface.SetMaterial(mat) -- Use our cached material
                    surface.DrawTexturedRect(self:GetWide() / 2 + surface.GetTextSize(self.item.name) / 2, 15, 64, 64)
                end
            else
                draw.DrawText(self.item.name, "Title", self:GetWide() / 2 , 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
                draw.DrawText(description, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            end
            
        elseif self.item.fixed_description and self.item.extra_description then
            draw.DrawText(self.item.name, "Title", self:GetWide() / 2 - string.len(self.item.name) - 20, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(self.item.fixed_description .. self.item.extra_description, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
            local mat = Material("materials/" .. self.item.name .. ".png", "mips smooth")
            surface.SetMaterial(mat) -- Use our cached material
            surface.DrawTexturedRect(self:GetWide() / 2 + string.len(self.item.name) * 2 + 20, 28, 40, 40)
        else
            draw.DrawText(self.item.description, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            draw.DrawText(self.item.name, "Title", self:GetWide() / 2, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        end

        -- Check if this is a class or an item
        if not self.item.class then
            self.buy_btn:SetTextColor(Color(255,255,255))
            self.buy_btn:SetText("Select Class (Your Items Will Be Removed)")
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end
            self.ammo_one_btn:SetVisible(false)
            self.ammo_ten_btn:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel:SetVisible(false)
            self.sell_btn:SetVisible(false)
            return
        end

        if LocalPlayer():HasWeapon(self.item.class) then
            self.buy_btn:SetTextColor(Color(255,255,255))
            self.buy_btn:SetText("OWNED")
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(Color(40,40,40))
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            self.sell_btn:SetVisible(true)
            self.sell_btn:SetTextColor(Color(255,255,255))
            self.sell_btn:SetText("Sell for " .. tostring(math.floor(self.item.price * 0.25)) .. "$")
            self.sell_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            if self.item.category ~= "Melee" and self.item.category ~= "Equipment" then
                self.ammo_one_btn:SetVisible(true)
                self.ammo_ten_btn:SetVisible(true)

                if self.item.ammo_price and self.item.ammo_price >= 0 then
                    self.ammo_one_btn:SetTextColor(Color(255,255,255))
                    local price = self.item.ammo_price and self.item.ammo_price or HORDE.default_ammo_price
                    self.ammo_one_btn:SetText("Buy Ammo Clip x 1 (" .. tostring(price) .. "$)")
                    self.ammo_one_btn:SetWide(self:GetWide() / 2)
                    self.ammo_one_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetParent():GetParent():GetWide()/2, 200)
                    end


                    self.ammo_ten_btn:SetTextColor(Color(255,255,255))
                    self.ammo_ten_btn:SetText("Buy Ammo Clip x 10 (" .. tostring(price * 10) .. "$)")
                    self.ammo_ten_btn:SetWide(self:GetWide() / 2)
                    self.ammo_ten_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetParent():GetParent():GetWide()/2, 200)
                    end
                end

                if self.item.secondary_ammo_price and self.item.secondary_ammo_price > 0 then
                    self.ammo_secondary_btn:SetVisible(true)
                    self.ammo_secondary_btn:SetTextColor(Color(255,255,255))
                    self.ammo_secondary_btn:SetText("Buy Secondary Ammo x 1 (" .. tostring(self.item.secondary_ammo_price) .. "$)")
                    self.ammo_secondary_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetWide(), 200)
                    end
                else
                    self.ammo_secondary_btn:SetVisible(false)
                end

                self.current_ammo_panel.Paint = function ()
                    local wpn = LocalPlayer():GetWeapon(self.item.class)
                    local clip_ammo = wpn:Clip1()
                    local total_ammo = LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType())
                    if wpn:GetSecondaryAmmoType() > 0 then
                        local clip_ammo2 = wpn:Clip2()
                        local total_ammo2 = LocalPlayer():GetAmmoCount(wpn:GetSecondaryAmmoType())
                        draw.SimpleText("Primary Ammo: " .. tonumber(clip_ammo) .. " / " .. tonumber(total_ammo) .. " | Secondary Ammo: " .. tonumber(total_ammo2), "Content", self:GetWide()/2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText("Primary Ammo: " .. tonumber(clip_ammo) .. " / " .. tonumber(total_ammo), "Content", self:GetWide()/2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end
            else
                self.ammo_one_btn:SetVisible(false)
                self.ammo_ten_btn:SetVisible(false)
                self.ammo_secondary_btn:SetVisible(false)
                self.current_ammo_panel.Paint = function () end
            end
        elseif LocalPlayer():GetHordeMoney() < self.item.price or LocalPlayer():GetHordeWeight() < self.item.weight then
            self.buy_btn:SetTextColor(Color(200,200,200))
            self.buy_btn:SetText("Not Enough Money or Carrying Capacity!")
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            self.ammo_one_btn:SetVisible(false)
            self.ammo_ten_btn:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
            self.sell_btn:SetVisible(false)
        else
            self.buy_btn:SetText("Buy Item")
            if self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP then
                local drop_entities = LocalPlayer():GetHordeDropEntities()
                if drop_entities[self.item.class] then
                    self.buy_btn:SetText("Buy Item " .. drop_entities[self.item.class] .. "/" .. self.item.entity_properties.limit)
                    self.sell_btn:SetVisible(true)
                    self.sell_btn:SetTextColor(Color(255,255,255))
                    self.sell_btn:SetText("Sell All for " .. tostring(math.floor(self.item.price * 0.25 * drop_entities[self.item.class])) .. "$")
                    self.sell_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetWide(), 200)
                    end
                else
                    self.sell_btn:SetVisible(false)
                end
            else
                self.sell_btn:SetVisible(false)
            end
            self.buy_btn:SetTextColor(Color(255,255,255))
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            self.ammo_one_btn:SetVisible(false)
            self.ammo_ten_btn:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
        end
    end

end

vgui.Register("HordeDescription", PANEL, "DPanel")