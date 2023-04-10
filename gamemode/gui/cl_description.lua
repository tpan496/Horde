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

    self.sell_panel = vgui.Create("DPanel", self)
    self.sell_panel:Dock(BOTTOM)
    self.sell_panel:DockMargin(5,2.5,5,2.5)
    self.sell_panel:SetTall(50)
    self.sell_panel.Paint = function ()
    end

    self.sell_btn = vgui.Create("DButton", self.sell_panel)
    self.sell_btn:Dock(LEFT)
    self.sell_btn:DockMargin(0,0,2.5,0)
    self.sell_btn:SetFont("Content")
    self.sell_btn:SetTall(50)
    self.sell_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end
    self.sell_btn:SetVisible(false)

    self.subclass_btn = vgui.Create("DButton", self.sell_panel)
    self.subclass_btn:Dock(LEFT)
    self.subclass_btn:DockMargin(2.5,0,0,0)
    self.subclass_btn:SetFont("Content")
    self.subclass_btn:SetTall(50)
    self.subclass_btn:SetText(translate.Get("Class_Change_Subclass") or "Change Subclass")
    self.subclass_btn.OnCursorEntered = function ()
        surface.PlaySound("UI/buttonrollover.wav")
    end
    self.subclass_btn:SetVisible(false)

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

    self.upgrade_btn = vgui.Create("DButton", self)
    self.upgrade_btn:Dock(BOTTOM)
    self.upgrade_btn:DockMargin(5,2.5,5,2.5)
    self.upgrade_btn:SetFont("Content")
    self.upgrade_btn:SetTextColor(Color(0,0,0,0))
    self.upgrade_btn:SetText("")
    self.upgrade_btn:SetTall(50)
    self.upgrade_btn.Paint = function () end
    self.upgrade_btn.OnCursorEntered = function ()
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

    function self.upgrade_btn:DoClick()
        self:GetParent():UpgradeDoClick()
    end

    function self.sell_btn:DoClick()
        self:GetParent():GetParent():SellDoClick()
    end

    function self.subclass_btn:DoClick()
        self:GetParent():GetParent():SubclassDoClick()
    end

    self.perk_panel = vgui.Create("DPanel", self)
    self.perk_panel:Dock(FILL)
    self.perk_panel:SetVisible(false)
    self.perk_panel:SetBackgroundColor(Color(40,40,40))

    self.subclass_panel = vgui.Create("DPanel", self)
    self.subclass_panel:Dock(FILL)
    self.subclass_panel:SetVisible(false)
    self.subclass_panel:SetBackgroundColor(Color(40,40,40))
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not self.item.class then
        Derma_Query("Changing class will remove all your items!", "Change Class",
            "Yes",
            function()
                HORDE:SendSavedPerkChoices(MySelf.Horde_subclass_choices[self.item.name])
                net.Start("Horde_SelectClass")
                net.WriteString(self.item.name)
                net.WriteString(MySelf.Horde_subclass_choices[self.item.name])
                net.SendToServer()

                file.Write("horde/class_choices.txt", self.item.subclass.PrintName)
            end,
            "No", function() end
        )
        --warning_panel:SetFont("Title")
        return
    end
    if not MySelf:Alive() then return end
    if self.item.Mind then
        -- spell item
        if MySelf:Horde_GetMoney() < self.item.price or not self.level_satisfy then
            return
        end
        net.Start("Horde_BuySpell")
        net.WriteString(self.item.ClassName)
        net.SendToServer()
        return
    end
    if MySelf:Horde_GetMoney() < self.item.price or MySelf:Horde_GetWeight() < self.item.weight or (not self.level_satisfy) then return end
    local drop_entities = MySelf:Horde_GetDropEntities()
    if self.item.entity_properties and self.item.entity_properties.limit and self.item.entity_properties.limit > 0 and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP and drop_entities[self.item.class] and drop_entities[self.item.class] >= self.item.entity_properties.limit then return end
    -- Buy the item
    net.Start("Horde_BuyItem")
    net.WriteString(self.item.class)
    net.SendToServer()
end

function PANEL:UpgradeDoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not MySelf:Alive() then return end
    if self.item.Mind then
        net.Start("Horde_BuySpellUpgrade")
        net.WriteString(self.item.ClassName)
        net.SendToServer()
        return
    end
    net.Start("Horde_BuyItemUpgrade")
    net.WriteString(self.item.class)
    net.SendToServer()
end

function PANEL:AmmoDoClick(count)
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not MySelf:Alive() then return end
    if self.item.ammo_price < 0 then
        net.Start("Horde_BuyItemUpgrade")
        net.WriteString(self.item.class)
        net.SendToServer()
        return
    end
    if count == -1 then
        -- Secondary ammo
        if self.item.secondary_ammo_price <= 0 or MySelf:Horde_GetMoney() < self.item.secondary_ammo_price then return end
        -- Buy the item
        net.Start("Horde_BuyItemAmmoSecondary")
        net.WriteString(self.item.class)
        net.SendToServer()
        return
    end
    local price = self.item.ammo_price and self.item.ammo_price or HORDE.default_ammo_price
    price = price * count
    if MySelf:Horde_GetMoney() < price then return end
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
        if self.perk_panel:IsVisible() then
            self.subclass_panel:SetVisible(false)
        end
        return
    end
    if not MySelf:Alive() then return end
    if MySelf:HasWeapon(self.item.class) or (self.item.entity_properties and (self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP or self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET)) then
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

function PANEL:SubclassDoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not self.item.class then
        -- Toggle subclasses
        self.perk_panel:SetVisible(false)
        self.subclass_panel:SetVisible(not self.subclass_panel:IsVisible())
        return
    end
end

function PANEL:SetData(item)
    self.perk_panel:SetSize(self:GetWide(), self:GetTall())
    self.subclass_btn:SetSize(self:GetWide(), self:GetTall())
    if self.perk_layout then for _, v in pairs(self.perk_layout:GetChildren()) do v:Remove() end end
    if self.subclass_layout then for _, v in pairs(self.subclass_layout:GetChildren()) do v:Remove() end end
    self.perk_panel:SetVisible(false)
    self.subclass_btn:SetVisible(false)
    self.item = item
    if self.item and self.item.Mind then
        self.item.levels = self.item.Levels
        self.item.price = self.item.Price
    end
    self.level_satisfy = true
    if self.item and self.item.levels and (HORDE.disable_levels_restrictions == 0) then
        for class, level in pairs(self.item.levels) do
            if MySelf:Horde_GetLevel(class) < level then
                self.level_satisfy = false
                break
            end
        end
    end

    if self.item and self.item.Mind then
        -- it is a spell
        self.item.price = 0
        self.item.class = self.item.ClassName
        self.loc_name = translate.Get("Spell_" .. self.item.class) or self.item.PrintName
        self.loc_desc = translate.Get("Spell_Desc_" .. self.item.class) or self.item.Description
        return
    end

    if self.item and self.item.class then
        self.is_special_weapon_item = self.item.class == "horde_carcass" or self.item.class == "horde_pheropod"
        if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_WPN then
            self.wpn = MySelf:GetWeapon(self.item.class)
        end
        if GetConVar("horde_default_item_config"):GetInt() == 1 then
            if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
                self.loc_name = translate.Get("Gadget_" .. self.item.class) or HORDE.gadgets[self.item.class].PrintName
                self.loc_desc = translate.Get("Gadget_Desc_" .. self.item.class) or HORDE.gadgets[self.item.class].Description
                local g = HORDE.gadgets[self.item.class]
                if g.Active then
                    local activate_loc = translate.Get("Gadget_Activation") or "Press T to activate."
                    self.loc_desc = activate_loc .. "\n\n" .. self.loc_desc
                    if g.Once then
                        local once = translate.Get("Gadget_Consumed") or "This gadget is CONSUMED after activation."
                        self.loc_desc = once .. "\n" .. self.loc_desc
                    end
                    self.loc_desc = self.loc_desc .. "\n\n"
                    local seconds_loc = translate.Get("Gadget_Seconds") or "seconds"
                    if g.Duration and g.Duration > 0 then
                        local duration_loc = translate.Get("Gadget_Duration") or "Duration"
                        self.loc_desc = self.loc_desc .. "\n" .. duration_loc .. ": " .. tostring(g.Duration) .. " " .. seconds_loc .. "."
                    end
                    if g.Cooldown and g.Cooldown > 0 then
                        local cd_loc = translate.Get("Gadget_Cooldown") or "Cooldown"
                        self.loc_desc = self.loc_desc .. "\n" .. cd_loc .. ": " .. tostring(g.Cooldown) .. " " .. seconds_loc .. "."
                    end
                end
                local warning_loc = translate.Get("Gadget_Owned_Warning") or "Only 1 Gadget can be OWNED!"
                self.loc_desc = self.loc_desc .. "\n\n" .. warning_loc
                if g.Params then
                    for i, v in pairs(g.Params) do
                        local replaced = "{" .. i .. "}"
                        if not string.find(self.loc_desc, replaced) then goto cont end
                        local formatted = v.value
                        if v.percent then
                            formatted = math.Round(formatted * 100) .. "%"
                        end
                        self.loc_desc = string.Replace(self.loc_desc, replaced, formatted)
                        ::cont::
                    end
                end
            else
                self.loc_name = translate.Get("Item_" .. self.item.name) or self.item.name
                self.loc_desc = translate.Get("Item_Desc_" .. self.item.name) or self.item.description
            end
        else
            if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
                self.loc_name = translate.Get("Gadget_" .. self.item.class) or HORDE.gadgets[self.item.class].PrintName
                self.loc_desc = translate.Get("Gadget_Desc_" .. self.item.class) or HORDE.gadgets[self.item.class].Description
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
        local subclass = HORDE.subclasses[MySelf:Horde_GetSubclass(self.item.name)]
        if not subclass then
            subclass = HORDE.subclasses[self.item.name]
        end

        self.item.subclass = subclass
        self.item.base_perk = subclass.BasePerk

        self.exp_diff = MySelf:Horde_GetExp(self.item.subclass.PrintName)
        self.exp_total = HORDE:GetExpToNextLevel(MySelf:Horde_GetLevel(self.item.subclass.PrintName) + 1)
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
        local name = self.item.name
        local perks = self.item.perks
        if subclass and subclass.ParentClass then
            name = subclass.PrintName
            perks = subclass.Perks
        end
        for perk_level, v in SortedPairs(perks) do
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
            local loc_title = translate.Get("Perk_Title_" .. name .. "_Tier_" .. perk_level) or (v.title or "")
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
                perkbutton:SetData(name, perk_level, choice, subclass)
            end
            ::cont::
        end

        if not self.subclass_scroll_panel then
            self.subclass_scroll_panel = vgui.Create("DScrollPanel", self.subclass_panel)
            self.subclass_scroll_panel:SetSize(self:GetWide(), self:GetTall() - 80)
            self.subclass_layout = vgui.Create("DIconLayout", self.subclass_scroll_panel)
            self.subclass_layout:Dock(FILL)
            self.subclass_layout:DockMargin(4, 10, 0, 4)
            self.subclass_layout:DockPadding(0, 0, 0, 50)
            self.subclass_layout:SetSpaceY(8)
            for _, v in pairs(self.subclass_layout:GetChildren()) do v:Remove() end
        end
        
        local cur_panel = self.subclass_layout:Add("DIconLayout")
        cur_panel:SetSpaceX(4)
        cur_panel:SetSize(self:GetWide() - 8, 82)
        cur_panel:Dock(TOP)
        cur_panel:DockMargin(0, 10, 0, 0)

        for _, subclass_name in SortedPairs(HORDE.classes_to_subclasses[self.item.name]) do

            --[[local unlocked_level = HORDE:Horde_GetWaveForPerk(perk_level)
            local loc_title = translate.Get("Subclass_Title_" .. class.name) or (v.title or "")
            if unlocked_level > 0 and unlocked_level > HORDE.current_wave then
                title:SetText("[Locked]")
                title:SetColor(color_gray)
            else
                title:SetText(loc_title)
                title:SetColor(color_white)
            end]]--

            local subclassbutton = cur_panel:Add("HordeSubclassButton")
            --if unlocked_level > 0 and unlocked_level > HORDE.current_wave then
                subclassbutton:SetLocked(true)
            --else
            --    subclassbutton:SetLocked(nil)
            --end
            subclassbutton:SetSize(cur_panel:GetWide() / 3, 82)
            subclassbutton:SetData(self.item.name, subclass_name)
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

function PANEL:IsUpgraded()
    return MySelf:Horde_HasSpell(self.item.ClassName)
end

local mind_icon = Material("status/mind.png", "mips smooth")
function PANEL:Paint()
    surface.SetDrawColor(HORDE.color_hollow)
    surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
    self.class_progress:SetVisible(false)
    if self.item then
        self.buy_btn:SetVisible(true)
        self.sell_btn:SetVisible(true)
        self.sell_btn:SetWide(self:GetWide())

        if self.item.Mind then
            -- it is a spell
            self.buy_btn:SetVisible(true)
            self.sell_btn:SetVisible(false)
            self.sell_btn:SetWide(self:GetWide())

            if MySelf:Horde_HasSpell(self.item.ClassName) then
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
                if HORDE.spells[self.item.ClassName].Upgrades and MySelf:Horde_GetSpellUpgrade(self.item.ClassName) < self.item.Upgrades then
                    self.upgrade_btn:SetVisible(true)
                    self.upgrade_btn:SetTextColor(Color(255,255,255))
                    local price = HORDE:GetSpellUpgradePrice(self.item.class, MySelf)
                    self.upgrade_btn:SetText("Upgrade to +" .. tostring(MySelf:Horde_GetSpellUpgrade(self.item.ClassName) + 1) .. " (" .. tostring(price) .. "$)")
                    self.upgrade_btn:SetWide(self:GetWide())
                    self.upgrade_btn.Paint = function ()
                        surface.SetDrawColor(Color(153,50,204))
                        surface.DrawRect(0, 0, self:GetParent():GetWide(), 200)
                    end
                else
                    self.upgrade_btn:SetVisible(false)
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
                local classes = {"Artificer", "Warlock", "Necromancer"}
                for _, class in pairs(classes) do
                    local level = self.item.Levels[class]
                    if level and level > 0 then
                        local rank, rank_level = HORDE:LevelToRank(level)
                        local mat = Material(HORDE.subclasses[class].Icon, "mips smooth")
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

                self.sell_btn:SetVisible(false)
                self.upgrade_btn:SetVisible(false)
            elseif MySelf:Horde_GetMoney() < self.item.Price or (not MySelf:Alive()) then
                self.buy_btn:SetTextColor(Color(200,200,200))
                if not MySelf:Alive() then
                    self.buy_btn:SetText("You are dead.")
                else
                    self.buy_btn:SetText(translate.Get("Shop_Not_Enough_Money_Or_Carrying_Capacity"))
                end
                self.buy_btn.Paint = function ()
                    surface.SetDrawColor(HORDE.color_crimson_dark)
                    surface.DrawRect(0, 0, self:GetWide(), 200)
                end

                self.upgrade_btn:SetVisible(false)
                self.sell_btn:SetVisible(false)
            else
                self.buy_btn:SetText(translate.Get("Shop_Buy_Item"))
                self.sell_btn:SetVisible(false)
                self.buy_btn:SetTextColor(Color(255,255,255))
                self.buy_btn.Paint = function ()
                    surface.SetDrawColor(HORDE.color_crimson)
                    surface.DrawRect(0, 0, self:GetWide(), 200)
                end
                self.upgrade_btn:SetVisible(false)
            end
            
            draw.DrawText(multlinetext(self.loc_desc, self:GetWide() - 128, "Content"), "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            local w, h
            if string.sub(self.loc_desc,-1) == "\n" then
                w, h = surface.GetTextSize(self.loc_desc)
            else
                w, h = surface.GetTextSize(self.loc_desc .. "\n")
            end

            draw.DrawText("Spell Type: ", "Content", 50, 120 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            local st = ""
            for i, t in ipairs(self.item.Type) do
                if i ~= #self.item.Type then
                    st = st .. HORDE.Spell_Type_Strings[t] .. ", "
                else
                    st = st ..  HORDE.Spell_Type_Strings[t]
                end
            end
            draw.DrawText(st, "Content", 175, 120 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)

            local mc = ""
            for i, mind in ipairs(self.item.Mind) do
                if i ~= #self.item.Mind then
                    mc = mc .. tostring(mind) .. " / "
                else
                    mc = mc .. tostring(mind)
                end
            end
            draw.DrawText("Mind Cost: ", "Content", 50, 160 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            draw.DrawText(mc, "Content", 175, 160 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            
            surface.SetMaterial(mind_icon)
            surface.SetDrawColor(color_white)
            surface.DrawTexturedRect(175 + surface.GetTextSize(mc) + 5, 157 + h, 25, 25)

            local cc = ""
            for i, t in ipairs(self.item.ChargeTime) do
                if i ~= #self.item.ChargeTime then
                    if t == 0 then
                        cc = cc .. "Instant / "
                    else
                        cc = cc .. tostring(t) .. "s / "
                    end
                else
                    cc = cc .. tostring(t) .. "s"
                end
            end
            draw.DrawText("Charge Time: ", "Content", 50, 200 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            draw.DrawText(cc, "Content", 175, 200 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)

            draw.DrawText("Cooldown: ", "Content", 50, 240 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            draw.DrawText(tostring(self.item.Cooldown) .. "s", "Content", 175, 240 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)

            local ht = 280 + h
            if self.item.DamageType then
                draw.DrawText("Damage Type: ", "Content", 50, ht, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                local px = 0
                for _, dmgtype in SortedPairs(self.item.DamageType) do
                    local icon = Material(HORDE.DMG_TYPE_ICON[dmgtype], "mips smooth")
                    surface.SetMaterial(icon)
                    surface.SetDrawColor(HORDE.DMG_COLOR[dmgtype])
                    surface.DrawTexturedRect(75 + px + 100, ht - 5, 30, 30)
                    px = px + 30
                end
                ht = ht + 40
            end

            draw.DrawText("Upgrade (" .. tostring(self.item.Upgrades or 0) .. "): ", "Content", 50, ht, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            if self.item.Upgrades then
                if self.item.Upgrade_Description then
                    draw.DrawText(self.item.Upgrade_Description, "Content", 175, ht, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                else
                    draw.DrawText("Available", "Content", 175, ht, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                end
            else
                draw.DrawText("None", "Content", 175, ht, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            end
            if self.item.Upgrades then
                draw.DrawText(self.loc_name .. " +" .. tostring(MySelf:Horde_GetSpellUpgrade(self.item.ClassName)), "Title", self:GetWide() / 2, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            else
                draw.DrawText(self.loc_name, "Title", self:GetWide() / 2, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            end
            return
        end

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
            local loc_name = translate.Get("Class_" .. self.item.subclass.PrintName) or self.item.subclass.PrintName
            draw.DrawText(loc_name, "Title", self:GetWide() / 2 - string.len(self.item.subclass.PrintName) - 20, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)

            local loc_desc = translate.Get("Class_Description_" .. self.item.subclass.PrintName) or self.item.extra_description
            if GetConVar("horde_enable_perk"):GetInt() == 1 then
                local perk = HORDE.perks[self.item.base_perk]
                local loc_perk_desc = translate.Get("Perk_" .. self.item.base_perk) or perk.Description
                if perk.Params then
                    for i, v in pairs(perk.Params) do
                        local replaced = "{" .. i .. "}"
                        if not string.find(loc_perk_desc, replaced) then goto cont end
                        if v.level then
                            v.value = math.min(v.max, (v.base or 0) + MySelf:Horde_GetLevel(v.classname) * v.level)
                        end
                        local formatted = v.value
                        if v.percent then
                            formatted = formatted * 100 .. "%"
                        end
                        loc_perk_desc = string.Replace(loc_perk_desc, replaced, formatted)
                        ::cont::
                    end
                end
                if self.item.subclass.ParentClass then
                    draw.DrawText(loc_perk_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                else
                    draw.DrawText(loc_perk_desc .. "\n\n" .. loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                end
            else
                draw.DrawText(loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            end
            surface.SetDrawColor(255, 255, 255, 255) -- Set the drawing color
            local mat = Material(self.item.subclass.Icon or self.item.icon, "mips smooth")
            surface.SetMaterial(mat) -- Use our cached material
            surface.DrawTexturedRect(self:GetWide() / 2 + string.len(loc_name) * 2 + 20, 28, 40, 40)

            self.class_progress.Paint = function()
                draw.SimpleText(translate.Get("Rank_" .. MySelf:Horde_GetRank(self.item.subclass.PrintName)) .. " " .. MySelf:Horde_GetRankLevel(self.item.subclass.PrintName), "Content", 0, 5, color_white, TEXT_ALIGN_LEFT)
                draw.SimpleText(self.exp_diff .. " / "  .. self.exp_total, "Content", self:GetWide() - 10, 5, color_white, TEXT_ALIGN_RIGHT)
                draw.RoundedBox(5, 5, 30, self:GetWide() - 20, 10, Color(80,80,80))
                draw.RoundedBox(5, 5, 30, self:GetWide() * (self.exp_diff / self.exp_total), 10, Color(220,220,220))
            end
        elseif self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET then
            local icon = Material(HORDE.gadgets[self.item.class].Icon, "mips smooth")
            draw.DrawText(self.loc_name, "Title", self:GetWide() / 2 - surface.GetTextSize(self.loc_name) / 2 + 16, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            draw.DrawText(self.loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            local w, h = surface.GetTextSize(self.loc_desc .. "\n")
            if self.loc_desc[-1] ~= "\n" then
                w, h = surface.GetTextSize(self.loc_desc .. "\n\n")
            end
            if self.item.dmgtype then
                draw.DrawText("Damage Type: ", "Content", 50, 80 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                local px = 0
                for _, dmgtype in SortedPairs(self.item.dmgtype) do
                    local icon2 = Material(HORDE.DMG_TYPE_ICON[dmgtype], "mips smooth")
                    surface.SetMaterial(icon2)
                    surface.SetDrawColor(HORDE.DMG_COLOR[dmgtype])
                    surface.DrawTexturedRect(75 + px + 100, 80 + h - 5, 30, 30)
                    px = px + 30
                end
            end
            surface.SetMaterial(icon) -- Use our cached material
            if HORDE.gadgets[self.item.class].Active then
                if HORDE.gadgets[self.item.class].Once then
                    surface.SetDrawColor(HORDE.color_gadget_once)
                else
                    surface.SetDrawColor(HORDE.color_gadget_active)
                end
            else
                surface.SetDrawColor(255, 255, 255, 255)
            end
            surface.DrawTexturedRect(self:GetWide() / 2 + surface.GetTextSize(self.loc_name) / 2 - 32, 16, 128, 64)
        else
            draw.DrawText(self.loc_desc, "Content", 50, 80, Color(200, 200, 200), TEXT_ALIGN_LEFT)
            local w, h
            if string.sub(self.loc_desc,-1) == "\n" then
                w, h = surface.GetTextSize(self.loc_desc)
            else
                w, h = surface.GetTextSize(self.loc_desc .. "\n")
            end
            if self.item.dmgtype then
                draw.DrawText("Damage Type: ", "Content", 50, 80 + h, Color(200, 200, 200), TEXT_ALIGN_LEFT)
                local px = 0
                for _, dmgtype in SortedPairs(self.item.dmgtype) do
                    local icon = Material(HORDE.DMG_TYPE_ICON[dmgtype], "mips smooth")
                    surface.SetMaterial(icon)
                    surface.SetDrawColor(HORDE.DMG_COLOR[dmgtype])
                    surface.DrawTexturedRect(75 + px + 100, 80 + h - 5, 30, 30)
                    px = px + 30
                end
            end
            if self:IsUpgraded() then
                draw.DrawText(self.loc_name .. " +" .. tostring(MySelf:Horde_GetUpgrade(self.item.class)), "Title", self:GetWide() / 2, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            else
                draw.DrawText(self.loc_name, "Title", self:GetWide() / 2, 32, Color(255, 255, 255), TEXT_ALIGN_CENTER)
            end
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
            self.sell_btn:SetWide(self:GetWide() / 2)

            self.subclass_btn:SetVisible(true)
            self.subclass_btn:SetWide(self:GetWide() / 2)
            self.subclass_btn:SetTextColor(color_white)
            self.subclass_btn.Paint = function ()
                surface.SetDrawColor(Color(153,50,204))
                surface.DrawRect(0, 0, self:GetWide(), 200)
                if not self.item then return end
                local mat = Material(self.item.icon, "mips smooth")
                if self.item.subclass and self.item.subclass.ParentClass then
                    mat = Material(self.item.subclass.Icon, "mips smooth")
                end
                surface.SetDrawColor(color_white)
                surface.SetMaterial(mat) -- Use our cached material
                surface.DrawTexturedRect(self.subclass_btn:GetWide() / 2 + surface.GetTextSize(self.subclass_btn:GetText()) / 2 + 10, 5, 40, 40)
            end

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
                --[[
                local mat = Material(self.item.icon, "mips smooth")
                surface.SetDrawColor(color_white)
                surface.SetMaterial(mat) -- Use our cached material
                surface.DrawTexturedRect(self.sell_btn:GetWide() / 2 + text_len / 2 + 10, 5, 40, 40)]]--
            end

            self.ammo_panel:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.current_ammo_panel:SetVisible(false)
            self.upgrade_btn:SetVisible(false)
            
            return
        end

        if MySelf:HasWeapon(self.item.class) or (self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_GADGET and MySelf:Horde_GetGadget() == self.item.class) then
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

            if self.item.category ~= "Equipment" and self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_WPN then
                self.ammo_panel:SetVisible(true)

                self.wpn = MySelf:GetWeapon(self.item.class)
                if self.item.ammo_price and self.item.ammo_price >= 0 and IsValid(self.wpn) and self.wpn:GetPrimaryAmmoType() > 0 then
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
                else
                    self.ammo_panel:SetVisible(false)
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

                if self:IsUpgradable() then
                    self.upgrade_btn:SetVisible(true)
                    self.upgrade_btn:SetTextColor(Color(255,255,255))
                    local price = HORDE:GetUpgradePrice(self.item.class)
                    self.upgrade_btn:SetText("Upgrade to +" .. tostring(MySelf:Horde_GetUpgrade(self.item.class) + 1) .. " (" .. tostring(price) .. "$)")
                    self.upgrade_btn:SetWide(self:GetWide())
                    self.upgrade_btn.Paint = function ()
                        surface.SetDrawColor(Color(153,50,204))
                        surface.DrawRect(0, 0, self:GetParent():GetWide(), 200)
                    end
                else
                    self.upgrade_btn:SetVisible(false)
                end

                self.current_ammo_panel.Paint = function ()
                    if not self.item then return end
                    local wpn = MySelf:GetWeapon(self.item.class)
                    local clip_ammo = wpn:Clip1()
                    local total_ammo = MySelf:GetAmmoCount(wpn:GetPrimaryAmmoType())
                    if wpn:GetSecondaryAmmoType() > 0 then
                        local clip_ammo2 = wpn:Clip2()
                        local total_ammo2 = MySelf:GetAmmoCount(wpn:GetSecondaryAmmoType())
                        draw.SimpleText(translate.Get("Shop_Primary_Ammo") .. ": " .. tonumber(clip_ammo) .. " / " .. tonumber(total_ammo) .. " | " .. translate.Get("Shop_Secondary_Ammo") .. ": " .. tonumber(total_ammo2), "Content", self:GetWide()/2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    else
                        draw.SimpleText(translate.Get("Shop_Primary_Ammo") .. ": " .. tonumber(clip_ammo) .. " / " .. tonumber(total_ammo), "Content", self:GetWide()/2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end
            else
                self.ammo_panel:SetVisible(false)
                self.ammo_secondary_btn:SetVisible(false)
                self.upgrade_btn:SetVisible(false)
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
            self.upgrade_btn:SetVisible(false)
        elseif MySelf:Horde_GetMoney() < self.item.price or MySelf:Horde_GetWeight() < self.item.weight or (not MySelf:Alive()) then
            self.buy_btn:SetTextColor(Color(200,200,200))
            if not MySelf:Alive() then
                self.buy_btn:SetText("You are dead.")
            else
                self.buy_btn:SetText(translate.Get("Shop_Not_Enough_Money_Or_Carrying_Capacity"))
            end
            self.buy_btn.Paint = function ()
                surface.SetDrawColor(HORDE.color_crimson_dark)
                surface.DrawRect(0, 0, self:GetWide(), 200)
            end

            self.ammo_panel:SetVisible(false)
            self.ammo_secondary_btn:SetVisible(false)
            self.upgrade_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
            if self.item.entity_properties.type == HORDE.ENTITY_PROPERTY_DROP then
                local drop_entities = MySelf:Horde_GetDropEntities()
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
                local drop_entities = MySelf:Horde_GetDropEntities()
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
            self.upgrade_btn:SetVisible(false)
            self.current_ammo_panel.Paint = function () end
        end
    else
        self.buy_btn:SetVisible(false)
        self.sell_btn:SetVisible(false)
        self.ammo_secondary_btn:SetVisible(false)
        self.ammo_panel:SetVisible(false)
        self.upgrade_btn:SetVisible(false)
    end

end

function PANEL:IsUpgraded()
    return MySelf:HasWeapon(self.item.class) and
    ((MySelf:Horde_GetCurrentSubclass() == "Gunslinger" and self.item.category == "Pistol")
    or self.is_special_weapon_item)
end

function PANEL:IsUpgradable()
    return MySelf:HasWeapon(self.item.class) and MySelf:Horde_GetUpgrade(self.item.class) < 10 and
    ((MySelf:Horde_GetCurrentSubclass() == "Gunslinger" and self.item.category == "Pistol")
    or self.is_special_weapon_item)
end

vgui.Register("HordeDescription", PANEL, "DPanel")
