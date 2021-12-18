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

    self.class_progress = vgui.Create("DPanel", self)
    self.class_progress:Dock(BOTTOM)
    self.class_progress:DockMargin(5,2.5,5,2.5)
    self.class_progress:SetTall(50)
    self.class_progress.Paint = function() end
    self.class_progress:SetVisible(false)

    function self.buy_btn:DoClick()
        if self:GetText() == translate.Get("Shop_OWNED") then return end
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

    self.perk_panel = vgui.Create("DPanel", self)
    self.perk_panel:Dock(FILL)
    self.perk_panel:SetVisible(false)
    self.perk_panel:SetBackgroundColor(Color(40,40,40))
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not self.item.class then
        Derma_Query("Changing class will remove all your items!", "Change Class",
            "Yes",
            function()
                HORDE:SendSavedPerkChoices(self.item.name)
                net.Start("Horde_SelectClass")
                net.WriteString(self.item.name)
                net.SendToServer()
            end,
            "No", function() end
        )
        --warning_panel:SetFont("Title")
        return
    end
    if not LocalPlayer():Alive() then return end
    if LocalPlayer():Horde_GetMoney() < self.item.price or LocalPlayer():Horde_GetWeight() < self.item.weight or (not self.level_satisfy) then return end
    local drop_entities = LocalPlayer():Horde_GetDropEntities()
    if self.item.entity_properties and self.item.entity_properties.limit and self.item.entity_properties.limit > 0 and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP and drop_entities[self.item.class] and drop_entities[self.item.class] >= self.item.entity_properties.limit then return end
    -- Buy the item
    net.Start("Horde_BuyItem")
    net.WriteString(self.item.class)
    net.SendToServer()
end

function PANEL:AmmoDoClick(count)
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not LocalPlayer():Alive() then return end
    if count == -1 then
        -- Secondary ammo
        if self.item.secondary_ammo_price <= 0 or LocalPlayer():Horde_GetMoney() < self.item.secondary_ammo_price then return end
        -- Buy the item
        net.Start("Horde_BuyItemAmmoSecondary")
        net.WriteString(self.item.class)
        net.SendToServer()
        return
    end
    local price = self.item.ammo_price and self.item.ammo_price or HORDE.default_ammo_price
    price = price * count
    if LocalPlayer():Horde_GetMoney() < price then return end
    -- Buy the item
    net.Start("Horde_BuyItemAmmoPrimary")
    net.WriteString(self.item.class)
    net.WriteUInt(count,4)
    net.SendToServer()
end

function PANEL:SellDoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not self.item.class then
        -- Toggle perks
        self.perk_panel:SetVisible(not self.perk_panel:IsVisible())
        return
    end
    if not LocalPlayer():Alive() then return end
    if LocalPlayer():HasWeapon(self.item.class) or (self.item.entity_properties and (self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP or self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET)) then
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
    self.perk_panel:SetSize(self:GetWide(), self:GetTall())
    if self.perk_layout then for _, v in pairs(self.perk_layout:GetChildren()) do v:Remove() end end
    self.perk_panel:SetVisible(false)
    self.item = item
    self.level_satisfy = true
    if self.item and self.item.levels and (HORDE.disable_levels_restrictions == 0) then
        for class, level in pairs(self.item.levels) do
            if LocalPlayer():Horde_GetLevel(class) < level then
                self.level_satisfy = false
                break
            end
        end
    end

    if self.item and self.item.class then
        if GetConVar("horde_default_item_config"):GetInt() == 1 then
            if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
                self.loc_name = translate.Get("Gadget_" .. self.item.class) or HORDE.gadgets[self.item.class].PrintName
                self.loc_desc = translate.Get("Gadget_Desc_" .. self.item.class) or HORDE.gadgets[self.item.class].Description
                --self.loc_desc = translate.Get("Gadget_Desc_" .. self.item.class) or HORDE.gadgets[self.item.class].Description
                if HORDE.gadgets[self.item.class].Active then
                    local activate_loc = translate.Get("Gadget_Activation") or "Press T to activate."
                    self.loc_desc = activate_loc .. "\n\n" .. self.loc_desc
                    self.loc_desc = self.loc_desc .. "\n\n"
                    local seconds_loc = translate.Get("Gadget_Seconds") or "seconds"
                    if HORDE.gadgets[self.item.class].Duration and HORDE.gadgets[self.item.class].Duration > 0 then
                        local duration_loc = translate.Get("Gadget_Duration") or "Duration"
                        self.loc_desc = self.loc_desc .. "\n" .. duration_loc .. ": " .. tostring(HORDE.gadgets[self.item.class].Duration) .. " " .. seconds_loc .. "."
                    end
                    if HORDE.gadgets[self.item.class].Cooldown and HORDE.gadgets[self.item.class].Cooldown > 0 then
                        local cd_loc = translate.Get("Gadget_Cooldown") or "Cooldown"
                        self.loc_desc = self.loc_desc .. "\n" .. cd_loc .. ": " .. tostring(HORDE.gadgets[self.item.class].Cooldown) .. " " .. seconds_loc .. "."
                    end
                end
                local warning_loc = translate.Get("Gadget_Owned_Warning") or "Only 1 Gadget can be OWNED!"
                self.loc_desc = self.loc_desc .. "\n\n" .. warning_loc
            else
                self.loc_name = translate.Get("Item_" .. self.item.name) or self.item.name
                self.loc_desc = translate.Get("Item_Desc_" .. self.item.name) or self.item.description
            end
        else
            if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
                self.loc_name = translate.Get("Gadget_" .. self.item.class) or HORDE.gadgets[self.item.class].PrintName
                self.loc_desc = translate.Get("Gadget_Desc_" .. self.item.class) or HORDE.gadgets[self.item.class].Description
                --self.loc_desc = translate.Get("Gadget_Desc_" .. self.item.class) or HORDE.gadgets[self.item.class].Description
                if HORDE.gadgets[self.item.class].Active then
                    local activate_loc = translate.Get("Gadget_Activation") or "Press T to activate."
                    self.loc_desc = activate_loc .. "\n\n" .. self.loc_desc
                    self.loc_desc = self.loc_desc .. "\n\n"
                    local seconds_loc = translate.Get("Gadget_Seconds") or "seconds"
                    if HORDE.gadgets[self.item.class].Duration and HORDE.gadgets[self.item.class].Duration > 0 then
                        local duration_loc = translate.Get("Gadget_Duration") or "Duration"
                        self.loc_desc = self.loc_desc .. "\n" .. duration_loc .. ": " .. tostring(HORDE.gadgets[self.item.class].Duration) .. " " .. seconds_loc .. "."
                    end
                    if HORDE.gadgets[self.item.class].Cooldown and HORDE.gadgets[self.item.class].Cooldown > 0 then
                        local cd_loc = translate.Get("Gadget_Cooldown") or "Cooldown"
                        self.loc_desc = self.loc_desc .. "\n" .. cd_loc .. ": " .. tostring(HORDE.gadgets[self.item.class].Cooldown) .. " " .. seconds_loc .. "."
                    end
                end
                local warning_loc = translate.Get("Gadget_Owned_Warning") or "Only 1 Gadget can be OWNED!"
                self.loc_desc = self.loc_desc .. "\n\n" .. warning_loc
            else
                self.loc_desc = self.item.description
                self.loc_name = self.item.name
            end
        end
    end
    if not self.item then return end
    if not self.item.class then
        self.exp_diff = LocalPlayer():Horde_GetExp(self.item.name)
        self.exp_total = HORDE:GetExpToNextLevel(LocalPlayer():Horde_GetLevel(self.item.name) + 1)
        if GetConVar("horde_enable_perk"):GetInt() ~= 1 then return end
        if not self.perk_scroll_panel then
            self.perk_scroll_panel = vgui.Create("DScrollPanel", self.perk_panel)
            self.perk_scroll_panel:SetSize(self:GetWide(), self:GetTall() - 80)
            self.perk_layout = vgui.Create("DIconLayout", self.perk_scroll_panel)
            self.perk_layout:Dock(FILL)
            self.perk_layout:DockMargin(4, 10, 0, 4)
            self.perk_layout:DockPadding(0, 0, 0, 50)
            self.perk_layout:SetSpaceY(8)
            for _, v in pairs(self.perk_layout:GetChildren()) do v:Remove() end
        end
        local class = self.item
        for perk_level, v in SortedPairs(class.perks) do
            if not v.choices then goto cont end
            local title = self.perk_layout:Add("DLabel")
            title:SetSize(self.perk_layout:GetWide(), 24)
            title:Dock(TOP)
            title:DockMargin(0, 10, 0, 0)
            title:SetContentAlignment(0, 0, 0, 8)
            title:SetFont("Horde_PerkTitle")
            title:SetColor(color_white)

            title:SetContentAlignment(5)
            local cur_panel = self.perk_layout:Add("DIconLayout")
            cur_panel:SetSpaceX(4)
            cur_panel:SetSize(self:GetWide() - 8, 82)
            cur_panel:Dock(TOP)
            cur_panel:DockMargin(0, 10, 0, 0)

            local unlocked_level = HORDE:Horde_GetWaveForPerk(perk_level)
            local loc_title = translate.Get("Perk_Title_" .. class.name .. "_Tier_" .. perk_level) or (v.title or "")
            if unlocked_level > 0 and unlocked_level > HORDE.current_wave then
                title:SetText("[" .. translate.Format("Shop_Unlocks_After_Wave", unlocked_level) .. "] "  .. loc_title)
                title:SetColor(color_gray)
            else
                title:SetText(loc_title)
                title:SetColor(color_white)
            end

            for choice, _ in pairs(v.choices) do -- TODO grey out locked choices
                local perkbutton = cur_panel:Add("HordePerkButton")
                if unlocked_level > 0 and unlocked_level > HORDE.current_wave then
                    perkbutton:SetLocked(true)
                else
                    perkbutton:SetLocked(nil)
                end
                if ScrW() <= 1280 then
                    perkbutton:SetSize(cur_panel:GetWide() - 5, 82)
                else
                    perkbutton:SetSize(cur_panel:GetWide() / 2, 82)
                end
                perkbutton:SetData(class.name, perk_level, choice)
            end
            ::cont::
        end
    end
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
    self.class_progress:SetVisible(false)
    if self.item then
        self.buy_btn:SetVisible(true)
        self.sell_btn:SetVisible(true)
        --[[surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
        local mat = Material("damagetype/fire.png", "mips smooth")
        surface.SetMaterial(mat) -- Use our cached material
        surface.DrawTexturedRect(self:GetWide() - 64, 27, 32, 32)
        draw.DrawText("FIRE", "Trebuchet18", self:GetWide() - 48, 60, Color(255, 255, 255), TEXT_ALIGN_CENTER)--]]
        if self.item.entity_properties and self.item.entity_properties.is_arccw_attachment then
            local icon = nil
            local description = ""
            local atttbl = ArcCW.AttachmentTable[self.item.class]
            if atttbl.Description then
                description = multlinetext(ArcCW.AttachmentTable[self.item.class].Description, self:GetWide() - 64, "Item")
                -- TODO: This should take two parameters. Second one seems useless?
                local pros, cons = ArcCW:GetProsCons(nil, atttbl, nil)
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

        elseif self.item.extra_description then
            self.class_progress:SetVisible(not self.perk_panel:IsVisible())
            local loc_name = translate.Get("Class_" .. self.item.display_name) or self.item.display_name
            draw.DrawText(loc_name, "Title", self:GetWide() / 2 - string.len(self.item.name) - 20, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            local loc_desc = translate.Get("Class_Description_" .. self.item.display_name) or self.item.extra_description
            if GetConVar("horde_enable_perk"):GetInt() == 1 then
                local perk = HORDE.perks[self.item.base_perk]
                local loc_perk_desc = translate.Get("Perk_" .. self.item.base_perk) or perk.Description
                if perk.Params then
                    for i, v in pairs(perk.Params) do
                        local replaced = "{" .. i .. "}"
                        if not string.find(loc_perk_desc, replaced) then goto cont end
                        local formatted = v.value
                        if v.percent then
                            formatted = math.Round(formatted * 100) .. "%"
                        end
                        loc_perk_desc = string.Replace(loc_perk_desc, replaced, formatted)
                        ::cont::
                    end
                end
                draw.DrawText(loc_perk_desc .. "\n\n" .. loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            else
                draw.DrawText(loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            end
            surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
            local mat = Material(self.item.icon, "mips smooth")
            surface.SetMaterial(mat) -- Use our cached material
            surface.DrawTexturedRect(self:GetWide() / 2 + string.len(loc_name) * 2 + 20, 28, 40, 40)

            self.class_progress.Paint = function()
                draw.SimpleText(translate.Get("Rank_" .. LocalPlayer():Horde_GetRank(self.item.name)) .. " " .. LocalPlayer():Horde_GetRankLevel(self.item.name), "Content", 0, 5, color_white, TEXT_ALIGN_LEFT)
                draw.SimpleText(self.exp_diff .. " / "  .. self.exp_total, "Content", self:GetWide() - 10, 5, color_white, TEXT_ALIGN_RIGHT)
                draw.RoundedBox(5, 5, 30, self:GetWide() - 20, 10, Color(80,80,80))
                draw.RoundedBox(5, 5, 30, self:GetWide() * (self.exp_diff / self.exp_total), 10, Color(220,220,220))
            end
        elseif self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
            local icon = Material(HORDE.gadgets[self.item.class].Icon, "mips smooth")
            draw.DrawText(self.loc_name, "Title", self:GetWide() / 2 - surface.GetTextSize(self.loc_name) / 2 + 16, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(self.loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            surface.SetMaterial(icon) -- Use our cached material
            if HORDE.gadgets[self.item.class].Active then
                surface.SetDrawColor(HORDE.color_gadget_active)
            else
                surface.SetDrawColor(255, 255, 255, 255)
            end
            surface.DrawTexturedRect(self:GetWide() / 2 + surface.GetTextSize(self.loc_name) / 2 - 32, 16, 128, 64)
        else
            draw.DrawText(self.loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            draw.DrawText(self.loc_name, "Title", self:GetWide() / 2, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
        end

        -- Check if this is a class or an item
        if not self.item.class then
            self.buy_btn:SetTextColor(Color(255,255,255))
            self.buy_btn:SetText(translate.Get("Shop_Select_Class"))
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            -- Use the sell button to toggle perks
            self.sell_btn:SetVisible(true)
            local text_hide = translate.Get("Shop_Hide_Perks")
            local text_show = translate.Get("Shop_Show_Perks")
            if self.perk_panel:IsVisible() then
                self.sell_btn:SetText(text_hide)
            else
                self.sell_btn:SetText(text_show)
            end
            local text_len = surface.GetTextSize(self.sell_btn:GetText())
            self.sell_btn:SetTextColor(Color(255,255,255))
            self.sell_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
                if not self.item then return end
                local mat = Material(self.item.icon, "mips smooth")
                surface.SetDrawColor(color_white)
                surface.SetMaterial(mat) -- Use our cached material
                surface.DrawTexturedRect(self:GetWide() / 2 + text_len / 2 + 10, 5, 40, 40)
            end

            self.ammo_panel:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel:SetVisible(false)
            
            return
        end

        if LocalPlayer():HasWeapon(self.item.class) or (self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET and LocalPlayer():Horde_GetGadget() == self.item.class) then
            self.buy_btn:SetTextColor(Color(255,255,255))
            self.buy_btn:SetText("OWNED")
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(Color(40,40,40))
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            self.sell_btn:SetVisible(true)
            self.sell_btn:SetTextColor(Color(255,255,255))
            self.sell_btn:SetText(translate.Get("Shop_Sell_For") .. " " .. tostring(math.floor(self.item.price * 0.25)) .. "$")
            self.sell_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            if self.item.category ~= "Melee" and self.item.category ~= "Equipment" and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_WPN then
                self.ammo_panel:SetVisible(true)

                if self.item.ammo_price and self.item.ammo_price >= 0 then
                    self.ammo_one_btn:SetTextColor(Color(255,255,255))
                    local price = self.item.ammo_price and self.item.ammo_price or HORDE.default_ammo_price
                    self.ammo_one_btn:SetText(translate.Get("Shop_Buy_Ammo_Clip") .. " x 1 (" .. tostring(price) .. "$)")
                    self.ammo_one_btn:SetWide(self:GetWide() / 2)
                    self.ammo_one_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetParent():GetParent():GetWide()/2, 200)
                    end


                    self.ammo_ten_btn:SetTextColor(Color(255,255,255))
                    self.ammo_ten_btn:SetText(translate.Get("Shop_Buy_Ammo_Clip") .. " x 10 (" .. tostring(price * 10) .. "$)")
                    self.ammo_ten_btn:SetWide(self:GetWide() / 2)
                    self.ammo_ten_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetParent():GetParent():GetWide()/2, 200)
                    end
                end

                if self.item.secondary_ammo_price and self.item.secondary_ammo_price > 0 then
                    self.ammo_secondary_btn:SetVisible(true)
                    self.ammo_secondary_btn:SetTextColor(Color(255,255,255))
                    self.ammo_secondary_btn:SetText(translate.Get("Shop_Buy_Secondary_Ammo") .. " x 1 (" .. tostring(self.item.secondary_ammo_price) .. "$)")
                    self.ammo_secondary_btn.Paint = function ()
                        surface.SetDrawColor(HORDE.color_crimson)
                        surface.DrawRect(0, 0, self:GetWide(), 200)
                    end
                else
                    self.ammo_secondary_btn:SetVisible(false)
                end

                self.current_ammo_panel.Paint = function ()
                    if not self.item then return end
                    local wpn = LocalPlayer():GetWeapon(self.item.class)
                    local clip_ammo = wpn:Clip1()
                    local total_ammo = LocalPlayer():GetAmmoCount(wpn:GetPrimaryAmmoType())
                    if wpn:GetSecondaryAmmoType() > 0 then
                        local clip_ammo2 = wpn:Clip2()
                        local total_ammo2 = LocalPlayer():GetAmmoCount(wpn:GetSecondaryAmmoType())
                        draw.SimpleText(translate.Get("Shop_Primary_Ammo") .. ": " .. tonumber(clip_ammo) .. " / " .. tonumber(total_ammo) .. " | " .. translate.Get("Shop_Secondary_Ammo") .. ": " .. tonumber(total_ammo2), "Content", self:GetWide()/2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(translate.Get("Shop_Primary_Ammo") .. ": " .. tonumber(clip_ammo) .. " / " .. tonumber(total_ammo), "Content", self:GetWide()/2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end
            else
                self.ammo_panel:SetVisible(false)
                self.ammo_secondary_btn:SetVisible(false)
                self.current_ammo_panel.Paint = function () end
            end
        elseif not self.level_satisfy then
            self.buy_btn:SetTextColor(Color(200,200,200))
            self.buy_btn:SetText("Rank Requirement(s) Not Met")
            
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            local x, y =  self.buy_btn:GetPos()
            y = y - self.buy_btn:GetTall()
            local start_pos = x + 15
            local classes = {"Survivor", "Assault", "Heavy", "Medic", "Demolition", "Ghost", "Engineer", "Berserker", "Warden", "Cremator"}
            for _, class in pairs(classes) do
                local level = self.item.levels[class]
                if level and level > 0 then
                    local rank, rank_level = HORDE:LevelToRank(level)
                    local mat = Material(HORDE.classes[class].icon, "mips smooth")
                    surface.SetMaterial(mat) -- Use our cached material
                    surface.SetDrawColor(HORDE.Rank_Colors[rank])
                    surface.DrawTexturedRect(start_pos, y + 5, 40, 40)
                    if rank == HORDE.Rank_Master then
                        draw.SimpleText(rank_level, "Trebuchet18", start_pos - 5, y + 20, HORDE.Rank_Colors[rank], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    else
                        if rank_level > 0 then
                            local star = Material("star.png", "mips smooth")
                            surface.SetMaterial(star)
                            local y_pos = y + 32
                            for i = 0, rank_level - 1 do
                                surface.DrawTexturedRect(start_pos - 10, y_pos, 10, 10)
                                y_pos = y_pos - 7
                            end
                        end
                    end
                    start_pos = start_pos + 50
                end
            end

            self.ammo_panel:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
            self.sell_btn:SetVisible(false)
        elseif LocalPlayer():Horde_GetMoney() < self.item.price or LocalPlayer():Horde_GetWeight() < self.item.weight or (not LocalPlayer():Alive()) then
            self.buy_btn:SetTextColor(Color(200,200,200))
            if not LocalPlayer():Alive() then
                self.buy_btn:SetText("You are dead.")
            else
                self.buy_btn:SetText("Not Enough Money or Carrying Capacity!")
            end
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            self.ammo_panel:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
            if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP then
                local drop_entities = LocalPlayer():Horde_GetDropEntities()
                if drop_entities[self.item.class] then
                    self.sell_btn:SetVisible(true)
                    self.sell_btn:SetTextColor(Color(255,255,255))
                    self.sell_btn:SetText(translate.Get("Shop_Sell_All_For") .. " " .. tostring(math.floor(self.item.price * 0.25 * drop_entities[self.item.class])) .. "$")
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
        else
            self.buy_btn:SetText(translate.Get("Shop_Buy_Item"))
            if self.item.entity_properties and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP then
                local drop_entities = LocalPlayer():Horde_GetDropEntities()
                if drop_entities[self.item.class] then
                    self.buy_btn:SetText(translate.Get("Shop_Buy_Item") .. " " .. drop_entities[self.item.class] .. "/" .. self.item.entity_properties.limit)
                    self.sell_btn:SetVisible(true)
                    self.sell_btn:SetTextColor(Color(255,255,255))
                    self.sell_btn:SetText(translate.Get("Shop_Sell_All_For") .. " " .. tostring(math.floor(self.item.price * 0.25 * drop_entities[self.item.class])) .. "$")
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

            self.ammo_panel:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
        end
    else
        self.buy_btn:SetVisible(false)
        self.sell_btn:SetVisible(false)
        self.ammo_secondary_btn:SetVisible(false)
        self.ammo_panel:SetVisible(false)
    end

end

vgui.Register("HordeDescription", PANEL, "DPanel")