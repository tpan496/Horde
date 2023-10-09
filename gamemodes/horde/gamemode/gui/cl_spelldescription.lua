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

    function self.buy_btn:DoClick()
        if self:GetText() == translate.Get("Shop_OWNED") then return end
        self:GetParent():DoClick()
    end

    function self.upgrade_btn:DoClick()
        self:GetParent():UpgradeDoClick()
    end

    function self.sell_btn:DoClick()
        self:GetParent():GetParent():SellDoClick()
    end
end

function PANEL:DoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not MySelf:Alive() then return end
    if MySelf:Horde_GetMoney() < (self.item.price or 0) or (not self.level_satisfy) then return end
    -- Buy the item
    net.Start("Horde_BuySpell")
    net.WriteString(self.item.class)
    net.SendToServer()
end

function PANEL:UpgradeDoClick()
    surface.PlaySound("UI/buttonclick.wav")
    if not self.item then return end
    if not MySelf:Alive() then return end
    net.Start("Horde_BuySpellUpgrade")
    net.WriteString(self.item.class)
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


function PANEL:SetData(item)
    self.item = item
    self.item.class = item.ClassName
    self.level_satisfy = true
    if self.item and self.item.levels and (HORDE.disable_levels_restrictions == 0) then
        for class, level in pairs(self.item.levels) do
            if MySelf:Horde_GetLevel(class) < level then
                self.level_satisfy = false
                break
            end
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

            self.sell_btn:SetVisible(false)
            self.upgrade_btn:SetVisible(false)
        elseif MySelf:Horde_GetMoney() < self.item.price or (not MySelf:Alive()) then
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
    else
        self.buy_btn:SetVisible(false)
        self.sell_btn:SetVisible(false)
        self.upgrade_btn:SetVisible(false)
    end

end

function PANEL:IsUpgraded()
    return MySelf:Horde_HasSpell(self.item.ClassName)
end

vgui.Register("HordeSpellDescription", PANEL, "DPanel")